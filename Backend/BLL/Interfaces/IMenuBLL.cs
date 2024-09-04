using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
namespace BLL.Interfaces
{
    public interface IMenuBLL
    {
        List<MenuModel> GetAllClient();
        List<MenuModel> GetAllAdmin();
        MenuModel GetOne(int id);
        bool Create(MenuModel model);
        bool Update(MenuModel model);
        bool Delete(int id);
    }
}
