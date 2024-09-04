using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IQuyenDAL
    {
        List<QuyenModel> GetAllAdmin();
        QuyenModel GetOne(int id);
        bool Create(QuyenModel model);
        bool Update(QuyenModel model);
        bool Delete(int id);
    }
}
