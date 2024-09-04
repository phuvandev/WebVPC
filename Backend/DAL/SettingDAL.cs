using DAL.Helper;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class SettingDAL : ISettingDAL
    {
        private IDatabaseHelper _dbHelper;
        public SettingDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public SettingModel GetBySign(string KyHieu)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getbysign_setting",
                                                                    "p_KyHieu", KyHieu);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SettingModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SettingModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSetting, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_setting_admin",
                                                                                    "p_pageIndex", pageIndex,
                                                                                    "p_pageSize", pageSize,
                                                                                    "p_TenSetting", TenSetting);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SettingModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SettingModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_setting",
                                                                    "p_MaSetting", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SettingModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(SettingModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_setting",
                                                                                "p_TenSetting", model.TenSetting,
                                                                                "p_KyHieu", model.KyHieu,
                                                                                "p_Anh", model.Anh,
                                                                                "p_MoTa", model.MoTa);

                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Update(SettingModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_setting",
                                                                                "p_MaSetting", model.MaSetting,
                                                                                "p_TenSetting", model.TenSetting,
                                                                                "p_KyHieu", model.KyHieu,
                                                                                "p_Anh", model.Anh,
                                                                                "p_MoTa", model.MoTa);

                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(int id)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_setting",
                                                                                "p_MaSetting", id);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
