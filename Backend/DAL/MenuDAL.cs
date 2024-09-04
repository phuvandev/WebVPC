using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Helper;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Model;

namespace DAL
{
    public class MenuDAL : IMenuDAL
    {
        private IDatabaseHelper _dbHelper;
        public MenuDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public List<MenuModel> GetAllClient()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_menu_client");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<MenuModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<MenuModel> GetAllAdmin()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_menu_admin");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<MenuModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public MenuModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_menu",
                                                                    "p_MaMenu", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<MenuModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(MenuModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_menu",
                                                                                "p_TenMenu", model.TenMenu,
                                                                                "p_Link", model.Link,
                                                                                "p_TrangThai", model.TrangThai);

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
        public bool Update(MenuModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_menu",
                                                                                "p_MaMenu", model.MaMenu,
                                                                                "p_TenMenu", model.TenMenu,
                                                                                "p_Link", model.Link,
                                                                                "p_TrangThai", model.TrangThai);

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
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_menu",
                                                                                "p_MaMenu", id);
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
