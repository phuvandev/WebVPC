using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ISendEmailDAL
    {
        void SendOrderEmail(string senderName, string email, string tenKH, long? tongTien, string diaChiGiaoHang, string sdt, DateTime ngayDat, int? maDH, List<CTDonHangModel> model);
    }
}
