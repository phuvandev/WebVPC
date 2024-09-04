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
    public class TinTucDAL : ITinTucDAL
    {
        private IDatabaseHelper _dbHelper;
        public TinTucDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public List<TinTucModel> GetAllClient(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_tintuc_client",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<TinTucModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<TinTucModel> GetAllAdmin(int pageIndex, int pageSize, string?TieuDe, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_tintuc_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TieuDe", TieuDe);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<TinTucModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public TinTucModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_tintuc",
                                                                                    "p_MaTT", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<TinTucModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<TinTucModel> GetRandom(int maTT, int soLuong)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getrandom_tintuc",
                                                                    "p_MaTT", maTT,
                                                                    "p_SoLuong", soLuong);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<TinTucModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(TinTucModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_tintuc",
                                                                                "p_AnhDaiDien", model.AnhDaiDien,
                                                                                "p_TieuDe", model.TieuDe,
                                                                                "p_NoiDung", model.NoiDung,
                                                                                "p_TrangThai", model.TrangThai,
                                                                                "p_MaND", model.MaND);

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
        public bool Update(TinTucModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_tintuc",
                                                                                "p_MaTT", model.MaTT,
                                                                                "p_AnhDaiDien", model.AnhDaiDien,
                                                                                "p_TieuDe", model.TieuDe,
                                                                                "p_NoiDung", model.NoiDung,
                                                                                "p_TrangThai", model.TrangThai,
                                                                                "p_MaND", model.MaND);

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
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_tintuc",
                                                                                            "p_MaTT", id);
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
