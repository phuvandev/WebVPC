using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ISlideDAL
    {
        List<SlideModel> GetAllClient();
        List<SlideModel> GetAllAdmin();
        SlideModel GetOne(int id);
        bool Create(SlideModel model);
        bool Update(SlideModel model);
        bool Delete(int id);
    }
}
