using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IBannerBLL
    {
        List<BannerModel> GetAllClient();
        List<BannerModel> GetAllAdmin();
        BannerModel GetOne(int id);
        bool Create(BannerModel model);
        bool Update(BannerModel model);
        bool Delete(int id);
    }
}
