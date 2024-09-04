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
    public class QuyenBLL : IQuyenBLL
    {
        private IQuyenDAL _res;
        public QuyenBLL(IQuyenDAL res)
        {
            _res = res;
        }

        public List<QuyenModel> GetAllAdmin()
        {
            return _res.GetAllAdmin();
        }

        public QuyenModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(QuyenModel model)
        {
            return _res.Create(model);
        }

        public bool Update(QuyenModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
