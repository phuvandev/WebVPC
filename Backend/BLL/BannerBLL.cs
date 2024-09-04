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
    public class BannerBLL : IBannerBLL
    {
        private IBannerDAL _res;
        public BannerBLL(IBannerDAL res)
        {
            _res = res;
        }

        public List<BannerModel> GetAllClient()
        {
            return _res.GetAllClient();
        }

        public List<BannerModel> GetAllAdmin()
        {
            return _res.GetAllAdmin();
        }

        public BannerModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(BannerModel model)
        {
            return _res.Create(model);
        }

        public bool Update(BannerModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
