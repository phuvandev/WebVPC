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
    public class HoaDonNhapBLL : IHoaDonNhapBLL
    {
        private IHoaDonNhapDAL _res;
        public HoaDonNhapBLL(IHoaDonNhapDAL res)
        {
            _res = res;
        }

        public List<HoaDonNhapModel> GetAllAdmin(int pageIndex, int pageSize, string? TenNCC, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TenNCC, out total);
        }

        public bool Create(HoaDonNhapModel model)
        {
            return _res.Create(model);
        }

        public HoaDonNhapModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public List<CTHoaDonNhapModel> GetByHDN(int maHDN)
        {
            return _res.GetByHDN(maHDN);
        }
    }
}
