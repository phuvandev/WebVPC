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
    public class HoaDonNhapDAL : IHoaDonNhapDAL
    {
        private IDatabaseHelper _dbHelper;
        public HoaDonNhapDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public List<HoaDonNhapModel> GetAllAdmin(int pageIndex, int pageSize, string? TenNCC, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_hoadonnhap_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TenNCC", TenNCC);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<HoaDonNhapModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(HoaDonNhapModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_hoadonnhap",
                                                                                "p_MaND", model.MaND,
                                                                                "p_MaNCC", model.MaNCC,
                                                                                "p_listjson_chitiethoadonnhap", model.listjson_chitiethoadonnhap != null ? MessageConvert.SerializeObject(model.listjson_chitiethoadonnhap) : null);

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

        public HoaDonNhapModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_hoadonnhap",
                                                                                    "p_MaHDN", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HoaDonNhapModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //------------------chi tiết hđn-------------------------------
        public List<CTHoaDonNhapModel> GetByHDN(int maHDN)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_cthoadonnhap_by_hoadonnhap",
                                                                    "p_MaHDN", maHDN);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<CTHoaDonNhapModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
