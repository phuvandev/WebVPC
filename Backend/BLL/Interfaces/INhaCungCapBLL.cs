using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface INhaCungCapBLL
    {
        List<NhaCungCapModel> GetAllAdmin(int pageIndex, int pageSize, string? TenNCC, out long total);
        NhaCungCapModel GetOne(int id);
        bool Create(NhaCungCapModel model);
        bool Update(NhaCungCapModel model);
        bool Delete(int id);
    }
}
