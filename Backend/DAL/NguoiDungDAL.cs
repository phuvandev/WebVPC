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
    public class NguoiDungDAL : INguoiDungDAL
    {
        private IDatabaseHelper _dbHelper;
        public NguoiDungDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public NguoiDungModel Login(string TaiKhoan, string MatKhau)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_login",
                                                                     "p_TaiKhoan", TaiKhoan,
                                                                     "p_MatKhau", MatKhau);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NguoiDungModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Register(NguoiDungModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_register",
                                                                                "p_TaiKhoan", model.TaiKhoan,
                                                                                "p_MatKhau", model.MatKhau,
                                                                                "p_Email", model.Email,
                                                                                "p_HoTen", model.HoTen,
                                                                                "p_SDT", model.SDT);

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

        public NguoiDungModel CheckExist(string TaiKhoan, string Email)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_check_exist_register",
                                                                     "p_TaiKhoan", TaiKhoan,
                                                                     "p_Email", Email);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NguoiDungModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<NguoiDungModel> GetAllStaff(int pageIndex, int pageSize, string? HoTen, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_nhanvien_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_HoTen", HoTen);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<NguoiDungModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<NguoiDungModel> GetAllCustomer(int pageIndex, int pageSize, string? HoTen, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getall_khachhang_admin",
                                                                    "p_pageIndex", pageIndex,
                                                                    "p_pageSize", pageSize,
                                                                    "p_HoTen", HoTen);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<NguoiDungModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public NguoiDungModel GetOne(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_getone_nguoidung",
                                                                                    "p_MaND", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NguoiDungModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(NguoiDungModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_nguoidung",
                                                                                "p_TaiKhoan", model.TaiKhoan,
                                                                                "p_MatKhau", model.MatKhau,
                                                                                "p_Email", model.Email,
                                                                                "p_HoTen", model.HoTen,
                                                                                "p_NgaySinh", model.NgaySinh,
                                                                                "p_GioiTinh", model.GioiTinh,
                                                                                "p_AnhDaiDien", model.AnhDaiDien,
                                                                                "p_DiaChi", model.DiaChi,
                                                                                "p_SDT", model.SDT,
                                                                                "p_TrangThai", model.TrangThai,
                                                                                "p_MaQuyen", model.MaQuyen);

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

        public bool Update(NguoiDungModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_update_nguoidung",
                                                                                "p_MaND", model.MaND,
                                                                                "p_MatKhau", model.MatKhau,
                                                                                "p_HoTen", model.HoTen,
                                                                                "p_NgaySinh", model.NgaySinh,
                                                                                "p_GioiTinh", model.GioiTinh,
                                                                                "p_AnhDaiDien", model.AnhDaiDien,
                                                                                "p_DiaChi", model.DiaChi,
                                                                                "p_SDT", model.SDT,
                                                                                "p_TrangThai", model.TrangThai,
                                                                                "p_MaQuyen", model.MaQuyen);

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
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_delete_nguoidung",
                                                                                            "p_MaND", id);
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
