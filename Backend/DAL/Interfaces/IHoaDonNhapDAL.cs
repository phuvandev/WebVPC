using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IHoaDonNhapDAL
    {
        List<HoaDonNhapModel> GetAllAdmin(int pageIndex, int pageSize, string? TenNCC, out long total);
        bool Create(HoaDonNhapModel model);

        List<CTHoaDonNhapModel> GetByHDN(int maHDN);
        HoaDonNhapModel GetOne(int id);
    }
}
