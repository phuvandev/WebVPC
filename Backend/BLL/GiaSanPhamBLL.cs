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
    public class GiaSanPhamBLL : IGiaSanPhamBLL
    {
        private IGiaSanPhamDAL _res;
        public GiaSanPhamBLL(IGiaSanPhamDAL res)
        {
            _res = res;
        }

        public List<GiaSanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSP, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TenSP, out total);
        }

        //public GiaSanPhamModel GetBySP(int maSP)
        //{
        //    return _res.GetBySP(maSP);
        //}

        public bool Create(GiaSanPhamModel model)
        {
            return _res.Create(model);
        }

        public bool Update(GiaSanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
