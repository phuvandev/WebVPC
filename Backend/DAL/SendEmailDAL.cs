using DAL.Interfaces;
using MimeKit;
using MailKit.Net.Smtp;
using Microsoft.Extensions.Options;
using System;
using Model;
using System.Globalization;

namespace DAL
{
    public class SendEmailDAL : ISendEmailDAL
    {
        private readonly SendEmailModel _sendEmailModel;

        public SendEmailDAL(IOptions<SendEmailModel> sendEmail)
        {
            _sendEmailModel = sendEmail.Value;
        }

        public void SendOrderEmail(string senderName, string email, string tenKH, long? tongTien, string diaChiGiaoHang, string sdt, DateTime ngayDat, int? maDH, List<CTDonHangModel> model)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress(senderName, _sendEmailModel.SenderEmail));
            message.To.Add(new MailboxAddress("", email));
            message.Subject = "Thông tin đơn hàng đặt tại " + senderName;

            var bodyBuilder = new BodyBuilder();

            string htmlContent = $@"
                    <h2>Cảm ơn bạn đã đặt hàng tại {senderName}</h2>
                    <p>Xin chào {tenKH},</p>
                    <p>Dưới đây là chi tiết đơn hàng của bạn:</p>
                    <table border='1' cellpadding='0' cellspacing='0' style='width: 100%; text-align: center'>
                        <thead>
                            <tr>
                                <th style='padding: 10px;'>STT</th>
                                <th style='padding: 10px;'>Sản phẩm</th>
                                <th style='padding: 10px;'>Giá bán</th>
                                <th style='padding: 10px;'>Số lượng</th>
                                <th style='padding: 10px;'>Thành tiền</td>
                            </tr>
                        </thead>
                        <tbody>";

                        int stt = 1;
                        foreach (var item in model)
                        {
                            htmlContent += $@"
                        <tr>
                            <td style='padding: 10px;'>{stt}</td>
                            <td style='padding: 10px;'>{item.TenSP}</td>
                            <td style='padding: 10px;'>{item.GiaBan.ToString("N0", new CultureInfo("vi-VN"))}đ</td>
                            <td style='padding: 10px;'>{item.SoLuong}</td>
                            <td style='padding: 10px;'>{(item.GiaBan * item.SoLuong).ToString("N0", new CultureInfo("vi-VN"))}đ</td>
                        </tr>";
                            stt++;
                        }

                        htmlContent += $@"
                            <tr>
                                <td colspan='4' style='padding: 10px;'><strong>Tổng hóa đơn</strong></td>
                                <td style='padding: 10px;'><strong>{tongTien?.ToString("N0", new CultureInfo("vi-VN"))}đ</strong></td>
                            </tr>
                        </tbody>
                    </table>

                    <p>Địa chỉ giao hàng: {diaChiGiaoHang}</p>
                    <p>Số điện thoại: {sdt}</p>
                    <p>Ngày đặt đơn: {ngayDat.ToString("HH:mm:ss dd/MM/yyyy")}</p>
                    <p>Vui lòng kiểm tra lại thông tin đơn hàng của bạn.</p> <br>
                    <p> Xin chân thành cảm ơn!</p> ";

            bodyBuilder.HtmlBody = htmlContent;
            message.Body = bodyBuilder.ToMessageBody();

            using (var client = new SmtpClient())
            {
                client.Connect(_sendEmailModel.Server, _sendEmailModel.Port, false);
                client.Authenticate(_sendEmailModel.SenderEmail, _sendEmailModel.Password);
                client.Send(message);
                client.Disconnect(true);
            }
        }

    }
}
