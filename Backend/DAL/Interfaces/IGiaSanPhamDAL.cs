using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IGiaSanPhamDAL
    {
        List<GiaSanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSP, out long total);
        //GiaSanPhamModel GetBySP(int maSP);
        bool Create(GiaSanPhamModel model);
        bool Update(GiaSanPhamModel model);
        bool Delete(int id);
    }
}
