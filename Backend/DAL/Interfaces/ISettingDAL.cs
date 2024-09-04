using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ISettingDAL
    {
        SettingModel GetBySign(string KyHieu);
        List<SettingModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSetting, out long total);
        SettingModel GetOne(int id);
        bool Create(SettingModel model);
        bool Update(SettingModel model);
        bool Delete(int id);
    }
}
