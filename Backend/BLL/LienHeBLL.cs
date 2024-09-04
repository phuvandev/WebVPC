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
    public class LienHeBLL : ILienHeBLL
    {
        private ILienHeDAL _res;
        public LienHeBLL(ILienHeDAL res)
        {
            _res = res;
        }

        public LienHeModel GetDataClient()
        {
            return _res.GetDataClient();
        }

        public LienHeModel GetDataAdmin()
        {
            return _res.GetDataAdmin();
        }

        public bool Update(LienHeModel model)
        {
            return _res.Update(model);
        }
    }
}
