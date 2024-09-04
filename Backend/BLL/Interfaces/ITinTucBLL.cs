using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface ITinTucBLL
    {
        List<TinTucModel> GetAllClient(int pageIndex, int pageSize, out long total);
        List<TinTucModel> GetAllAdmin(int pageIndex, int pageSize, string? TieuDe, out long total);
        TinTucModel GetOne(int id);
        List<TinTucModel> GetRandom(int maTT, int soLuong);

        bool Create(TinTucModel model);
        bool Update(TinTucModel model);
        bool Delete(int id);
    }
}
