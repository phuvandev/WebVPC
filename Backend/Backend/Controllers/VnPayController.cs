using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace Backend.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class VnPayController : ControllerBase
    {
        private IVnPayBLL _vnpayBLL;
        private IDonHangBLL _donhangBLL;

        public VnPayController(IVnPayBLL vnpayBLL, IDonHangBLL donhangBLL)
        {
            _vnpayBLL = vnpayBLL;
            _donhangBLL = donhangBLL;
        }

        [Route("vnpay")]
        [HttpPost]
        public IActionResult CreatePaymentUrl(PaymentInformationModel model)
        {
            try
            {
                var url = _vnpayBLL.CreatePaymentUrl(model, HttpContext);
                return Ok(new { success = true, message = "Lấy Url thành công", data = url });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("call-back")]
        [HttpGet]
        public IActionResult PaymentCallback()
        {
            try
            {
                var response = _vnpayBLL.PaymentExecute(Request.Query);
                if (response.Success)
                {
                    DonHangModel model = new DonHangModel();
                    model.MaDH = int.Parse(response.OrderId);
                    model.TrangThai = 3;
                    _donhangBLL.Check(model);
                }
                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
