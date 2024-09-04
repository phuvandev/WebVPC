using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface ISendEmailBLL
    {
        void SendOrderEmail(string senderName, string email, string tenKH, long? tongTien, string diaChiGiaoHang, string sdt, DateTime ngayDat, int? maDH, List<CTDonHangModel> model);
    }
}
