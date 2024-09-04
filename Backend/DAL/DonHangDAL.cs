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
    public class DonHangDAL : IDonHangDAL
    {
        private IDatabaseHelper _dbHelper;
        public DonHangDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public List<DonHangModel> GetAllAdmin(int pageIndex, int pageSize, string? TenKH, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_donhang_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TenKH", TenKH);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<DonHangModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(DonHangModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_donhang",
                                                                                "p_TenKH", model.TenKH,
                                                                                "p_Email", model.Email,
                                                                                "p_DiaChiGiaoHang", model.DiaChiGiaoHang,
                                                                                "p_SDT", model.SDT,
                                                                                "p_GhiChu", model.GhiChu,
                                                                                "p_PhuongThucThanhToan", model.PhuongThucThanhToan,
                                                                                "p_TrangThai", model.TrangThai,
                                                                                "p_MaND", model.MaND,
                                                                                "p_listjson_chitietdonhang", model.listjson_chitietdonhang != null ? MessageConvert.SerializeObject(model.listjson_chitietdonhang) : null);

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

        public DonHangModel GetOneNew()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getonenew_donhang");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DonHangModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool Check(DonHangModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_check_donhang",
                                                                                "p_MaDH", model.MaDH,
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

        //------------------chi tiết đơn hàng-------------------------------
        public List<CTDonHangModel> GetByDH(int maDH)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_ctdonhang_by_donhang",
                                                                    "p_MaDH", maDH);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<CTDonHangModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<DonHangModel> GetPurchaseHistory(int pageIndex, int pageSize, int? maND, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, " sp_get_purchase_history_by_nguoidung",
                                                                                    "p_pageIndex", pageIndex,
                                                                                    "p_pageSize", pageSize,
                                                                                    "p_MaND", maND);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<DonHangModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DonHangModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_donhang",
                                                                                    "p_MaDH", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DonHangModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
