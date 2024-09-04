using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IDonHangBLL
    {
        List<DonHangModel> GetAllAdmin(int pageIndex, int pageSize, string? TenKH, out long total);
        bool Create(DonHangModel model);
        List<DonHangModel> GetPurchaseHistory(int pageIndex, int pageSize, int? maND, out long total);
        DonHangModel GetOneNew();


        bool Check(DonHangModel model);
        List<CTDonHangModel> GetByDH(int maDH);

        DonHangModel GetOne(int id);
    }
}
