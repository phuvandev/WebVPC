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
    public class DongSanPhamBLL : IDongSanPhamBLL
    {
        private IDongSanPhamDAL _res;
        public DongSanPhamBLL(IDongSanPhamDAL res)
        {
            _res = res;
        }

        public List<DongSanPhamModel> GetAllClient()
        {
            return _res.GetAllClient();
        }

        public List<DongSanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenDSP, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TenDSP, out total);
        }

        public DongSanPhamModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(DongSanPhamModel model)
        {
            return _res.Create(model);
        }

        public bool Update(DongSanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
