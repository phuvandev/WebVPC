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
    public class SettingBLL : ISettingBLL
    {
        private ISettingDAL _res;
        public SettingBLL(ISettingDAL res)
        {
            _res = res;
        }

        public SettingModel GetBySign(string KyHieu)
        {
            return _res.GetBySign(KyHieu);
        }

        public List<SettingModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSetting, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TenSetting, out total);
        }

        public SettingModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(SettingModel model)
        {
            return _res.Create(model);
        }

        public bool Update(SettingModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
