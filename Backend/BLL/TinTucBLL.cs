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
    public class TinTucBLL : ITinTucBLL
    {
        private ITinTucDAL _res;
        public TinTucBLL(ITinTucDAL res)
        {
            _res = res;
        }

        public List<TinTucModel> GetAllClient(int pageIndex, int pageSize, out long total)
        {
            return _res.GetAllClient(pageIndex, pageSize, out total);
        }

        public List<TinTucModel> GetAllAdmin(int pageIndex, int pageSize, string? TieuDe, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TieuDe, out total);
        }

        public TinTucModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public List<TinTucModel> GetRandom(int maTT, int soLuong)
        {
            return _res.GetRandom(maTT, soLuong);
        }

        public bool Create(TinTucModel model)
        {
            return _res.Create(model);
        }

        public bool Update(TinTucModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
