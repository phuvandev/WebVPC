using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IMenuDAL
    {
        List<MenuModel> GetAllClient();
        List<MenuModel> GetAllAdmin();
        MenuModel GetOne(int id);
        bool Create(MenuModel model);
        bool Update(MenuModel model);
        bool Delete(int id);
    }
}
