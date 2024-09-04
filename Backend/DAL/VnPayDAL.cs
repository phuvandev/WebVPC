using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Model;
using Org.BouncyCastle.Asn1.Ocsp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class VnPayDAL : IVnPayDAL
    {
        private IDatabaseHelper _dbHelper;
        private IConfiguration _configuration;
        public VnPayDAL(IDatabaseHelper dbHelper, IConfiguration configuration)
        {
            _dbHelper = dbHelper;
            _configuration = configuration;
        }
        public string CreatePaymentUrl(PaymentInformationModel model, HttpContext context)
        {
            var timeNow = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.Local);

            var pay = new VnPayLibrary();
            //sử dụng thông tin từ Paymentinfomationmodel và câu hình từ appsetting.json để tạo url thanh toán
            pay.AddRequestData("vnp_Version", _configuration["Vnpay:Version"]);
            pay.AddRequestData("vnp_Command", _configuration["Vnpay:Command"]);
            pay.AddRequestData("vnp_TmnCode", _configuration["Vnpay:TmnCode"]);
            pay.AddRequestData("vnp_Amount", ((int)model.Amount * 100).ToString());
            pay.AddRequestData("vnp_CreateDate", timeNow.ToString("yyyyMMddHHmmss"));
            pay.AddRequestData("vnp_CurrCode", _configuration["Vnpay:CurrCode"]);
            pay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress(context));
            pay.AddRequestData("vnp_Locale", _configuration["Vnpay:Locale"]);
            pay.AddRequestData("vnp_OrderInfo", "Thanh toan cho don hang: " + model.OrderId);
            pay.AddRequestData("vnp_OrderType", model.OrderType);
            pay.AddRequestData("vnp_ReturnUrl", model.Url);
            pay.AddRequestData("vnp_TxnRef", model.OrderId.ToString());

            var paymentUrl =
                pay.CreateRequestUrl(_configuration["Vnpay:BaseUrl"], _configuration["Vnpay:HashSecret"]);
            return paymentUrl;
        }

        //lấy thông tin từ callback, xác minh chữ ký(signature) để đảm bảo tính toàn vẹn của dữ liệu
        //kiểm tra trạng thái giao dịch
        public VnPayModel PaymentExecute(IQueryCollection collections)
        {
            var vnPay = new VnPayLibrary();
            foreach (var (key, value) in collections)
            {
                if (!string.IsNullOrEmpty(key) && key.StartsWith("vnp_"))
                {
                    vnPay.AddResponseData(key, value);
                }
            }

            var orderId = Convert.ToInt64(vnPay.GetResponseData("vnp_TxnRef"));
            var vnPayTranId = Convert.ToInt64(vnPay.GetResponseData("vnp_TransactionNo"));
            var vnpResponseCode = vnPay.GetResponseData("vnp_ResponseCode");
            var vnpSecureHash =
                collections.FirstOrDefault(k => k.Key == "vnp_SecureHash").Value;
            var orderInfo = vnPay.GetResponseData("vnp_OrderInfo");

            var checkSignature =
                vnPay.ValidateSignature(vnpSecureHash, _configuration["Vnpay:HashSecret"]);

            if (!checkSignature)
                return new VnPayModel()
                {
                    Success = false
                };

            var transactionStatus = vnPay.GetResponseData("vnp_TransactionStatus");
            if (transactionStatus != "00")
            {
                return new VnPayModel()
                {
                    Success = false
                };
            }

            return new VnPayModel()
            {
                Success = true,
                PaymentMethod = "VnPay",
                OrderDescription = orderInfo,
                OrderId = orderId.ToString(),
                PaymentId = vnPayTranId.ToString(),
                TransactionId = vnPayTranId.ToString(),
                Token = vnpSecureHash,
                VnPayResponseCode = vnpResponseCode
            };
        }
    }
}
