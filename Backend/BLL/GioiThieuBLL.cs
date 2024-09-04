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
    public class GioiThieuBLL : IGioiThieuBLL
    {
        private IGioiThieuDAL _res;
        public GioiThieuBLL(IGioiThieuDAL res)
        {
            _res = res;
        }

        public GioiThieuModel GetDataClient()
        {
            return _res.GetDataClient();
        }

        public GioiThieuModel GetDataAdmin()
        {
            return _res.GetDataAdmin();
        }

        public bool Update(GioiThieuModel model)
        {
            return _res.Update(model);
        }
    }
}
