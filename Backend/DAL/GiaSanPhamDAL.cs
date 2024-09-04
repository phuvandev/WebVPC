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
    public class GiaSanPhamDAL : IGiaSanPhamDAL
    {
        private IDatabaseHelper _dbHelper;
        public GiaSanPhamDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public List<GiaSanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSP, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_giasanpham_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_TenSP", TenSP);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<GiaSanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //public GiaSanPhamModel GetBySP(int maSP)
        //{
        //    string msgError = "";
        //    try
        //    {
        //        var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_giasanpham_by_sanpham",
        //                                                            "p_MaSP", maSP);
        //        if (!string.IsNullOrEmpty(msgError))
        //            throw new Exception(msgError);
        //        return dt.ConvertTo<GiaSanPhamModel>().FirstOrDefault();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public bool Create(GiaSanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_giasanpham",
                                                                                "p_GiaBan", model.GiaBan,
                                                                                "p_PhanTramGiamGia", model.PhanTramGiamGia,
                                                                                "p_NgayBD", model.NgayBD,
                                                                                "p_NgayKT", model.NgayKT,
                                                                                "p_MaSP", model.MaSP);

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

        public bool Update(GiaSanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_giasanpham",
                                                                                "p_MaGSP", model.MaGSP,
                                                                                "p_GiaBan", model.GiaBan,
                                                                                "p_PhanTramGiamGia", model.PhanTramGiamGia,
                                                                                "p_NgayBD", model.NgayBD,
                                                                                "p_NgayKT", model.NgayKT,
                                                                                "p_MaSP", model.MaSP);

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
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_giasanpham",
                                                                                "p_MaGSP", id);
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
