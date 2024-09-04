using DAL.Helper;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace DAL
{
    public class SanPhamDAL : ISanPhamDAL
    {
        private IDatabaseHelper _dbHelper;
        public SanPhamDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public List<SanPhamModel> GetNew(int soLuong)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getnew_sanpham",
                                                                    "p_SoLuong", soLuong);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> GetHot(int soLuong)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_gethot_sanpham",
                                                                    "p_SoLuong", soLuong);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> GetSale(int soLuong)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getsale_sanpham",
                                                                    "p_SoLuong", soLuong);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> GetSameCategory(int maDSP, int maSP)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getsamecategory_sanpham",
                                                                    "p_MaDSP", maDSP,
                                                                    "p_MaSP", maSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> Search(int pageIndex, int pageSize, string tenSP, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_search_sanpham",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TenSP", tenSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> GetByDSP(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_sanpham_by_dongsanpham",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_MaDSP", maDSP,
                                                                    "p_MinGia", minGia,
                                                                    "p_MaxGia", maxGia,
                                                                    "p_ChongNuoc", chongNuoc);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> FilterByPriceAsc(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_filterbypriceasc",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_MaDSP", maDSP,
                                                                    "p_MinGia", minGia,
                                                                    "p_MaxGia", maxGia,
                                                                    "p_ChongNuoc", chongNuoc);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> FilterByPriceDesc(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_filterbypricedesc",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_MaDSP", maDSP,
                                                                    "p_MinGia", minGia,
                                                                    "p_MaxGia", maxGia,
                                                                    "p_ChongNuoc", chongNuoc);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SanPhamModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_sanpham",
                                                                                    "p_MaSP", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSP, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_sanpham_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TenSP", TenSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SanPhamModel GetOneAdmin(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_sanpham_admin",
                                                                                    "p_MaSP", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> GetWithoutPrice(int pageIndex, int pageSize, string? TenSP, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getwithoutprice_sanpham",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TenSP", TenSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_sanpham",
                                                                                "p_TenSP", model.TenSP,
                                                                                "p_AnhDaiDien", model.AnhDaiDien,
                                                                                "p_KichThuoc", model.KichThuoc,
                                                                                "p_TrongLuong", model.TrongLuong,
                                                                                "p_MatKinh", model.MatKinh,
                                                                                "p_ChatLieuDay", model.ChatLieuDay,
                                                                                "p_ChongNuoc", model.ChongNuoc,
                                                                                "p_LoaiMay", model.LoaiMay,
                                                                                "p_MoTa", model.MoTa,
                                                                                "p_TrangThai", model.TrangThai,
                                                                                "p_MaDSP", model.MaDSP);

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
        public bool Update(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_sanpham",
                                                                                "p_MaSP", model.MaSP,
                                                                                "p_TenSP", model.TenSP,
                                                                                "p_AnhDaiDien", model.AnhDaiDien,
                                                                                "p_KichThuoc", model.KichThuoc,
                                                                                "p_TrongLuong", model.TrongLuong,
                                                                                "p_MatKinh", model.MatKinh,
                                                                                "p_ChatLieuDay", model.ChatLieuDay,
                                                                                "p_ChongNuoc", model.ChongNuoc,
                                                                                "p_LoaiMay", model.LoaiMay,
                                                                                "p_MoTa", model.MoTa,
                                                                                "p_TrangThai", model.TrangThai,
                                                                                "p_MaDSP", model.MaDSP);

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
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_sanpham",
                                                                                            "p_MaSP", id);
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
