using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ILienHeDAL
    {
        LienHeModel GetDataClient();
        LienHeModel GetDataAdmin();

        bool Update(LienHeModel model);
    }
}
