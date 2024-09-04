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
    public class NhaCungCapDAL : INhaCungCapDAL
    {
        private IDatabaseHelper _dbHelper;
        public NhaCungCapDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public List<NhaCungCapModel> GetAllAdmin(int pageIndex, int pageSize, string? TenNCC, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_nhacungcap_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TenNCC", TenNCC);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<NhaCungCapModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public NhaCungCapModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_nhacungcap",
                                                                                    "p_MaNCC", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NhaCungCapModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(NhaCungCapModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_nhacungcap",
                                                                                "p_TenNCC", model.TenNCC,
                                                                                "p_DiaChi", model.DiaChi,
                                                                                "p_SDT", model.SDT,
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
        public bool Update(NhaCungCapModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_nhacungcap",
                                                                                "p_MaNCC", model.MaNCC,
                                                                                "p_TenNCC", model.TenNCC,
                                                                                "p_DiaChi", model.DiaChi,
                                                                                "p_SDT", model.SDT,
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
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_nhacungcap",
                                                                                            "p_MaNCC", id);
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
