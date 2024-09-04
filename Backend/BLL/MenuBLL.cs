using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Interfaces;
using Model;

namespace BLL
{
    public class MenuBLL : IMenuBLL
    {
        private IMenuDAL _res;
        public MenuBLL(IMenuDAL res)
        {
            _res = res;
        }

        public List<MenuModel> GetAllClient()
        {
            return _res.GetAllClient();
        }

        public List<MenuModel> GetAllAdmin()
        {
            return _res.GetAllAdmin();
        }

        public MenuModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(MenuModel model)
        {
            return _res.Create(model);
        }

        public bool Update(MenuModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
