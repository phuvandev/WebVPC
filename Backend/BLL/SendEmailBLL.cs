using BLL.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SendEmailBLL : ISendEmailBLL
    {
        private readonly ISendEmailDAL _sendEmailDAL;

        public SendEmailBLL(ISendEmailDAL sendEmailDAL)
        {
            _sendEmailDAL = sendEmailDAL;
        }

        public void SendOrderEmail(string senderName, string email, string tenKH, long? tongTien, string diaChiGiaoHang, string sdt, DateTime ngayDat, int? maDH, List<CTDonHangModel> model)
        {
            _sendEmailDAL.SendOrderEmail(senderName, email, tenKH, tongTien, diaChiGiaoHang, sdt, ngayDat, maDH, model);
        }
    }
}
