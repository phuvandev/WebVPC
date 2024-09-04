using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface ILienHeBLL
    {
        LienHeModel GetDataClient();
        LienHeModel GetDataAdmin();

        bool Update(LienHeModel model);
    }
}
