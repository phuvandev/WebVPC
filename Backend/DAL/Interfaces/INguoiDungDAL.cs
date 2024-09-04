using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface INguoiDungDAL
    {
        NguoiDungModel Login(string TaiKhoan, string MatKhau);
        bool Register(NguoiDungModel model);
        NguoiDungModel CheckExist(string TaiKhoan, string Email);

        List<NguoiDungModel> GetAllStaff(int pageIndex, int pageSize, string? HoTen, out long total);
        List<NguoiDungModel> GetAllCustomer(int pageIndex, int pageSize, string? HoTen, out long total);
        NguoiDungModel GetOne(int id);
        bool Create(NguoiDungModel model);
        bool Update(NguoiDungModel model);
        bool Delete(int id);
    }
}
