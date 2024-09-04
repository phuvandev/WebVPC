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
    public class NhaCungCapBLL : INhaCungCapBLL
    {
        private INhaCungCapDAL _res;
        public NhaCungCapBLL(INhaCungCapDAL res)
        {
            _res = res;
        }

        public List<NhaCungCapModel> GetAllAdmin(int pageIndex, int pageSize, string? TenNCC, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TenNCC, out total);
        }

        public NhaCungCapModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(NhaCungCapModel model)
        {
            return _res.Create(model);
        }

        public bool Update(NhaCungCapModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
