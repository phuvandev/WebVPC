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
    public class SlideBLL : ISlideBLL
    {
        private ISlideDAL _res;
        public SlideBLL(ISlideDAL res)
        {
            _res = res;
        }

        public List<SlideModel> GetAllClient()
        {
            return _res.GetAllClient();
        }

        public List<SlideModel> GetAllAdmin()
        {
            return _res.GetAllAdmin();
        }

        public SlideModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(SlideModel model)
        {
            return _res.Create(model);
        }

        public bool Update(SlideModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
