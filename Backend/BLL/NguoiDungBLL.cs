using BLL.Interfaces;
using DAL.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Model;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class NguoiDungBLL : INguoiDungBLL
    {
        private INguoiDungDAL _res;
        private string Secret;

        public NguoiDungBLL(INguoiDungDAL res, IConfiguration configuration)
        {
            _res = res;
            Secret = configuration["AppSettings:Secret"];
        }

        // phương thức mã hóa MD5
        private string GetMd5Hash(string input)
        {
            using (MD5 md5Hash = MD5.Create())
            {
                byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));

                StringBuilder sBuilder = new StringBuilder();

                for (int i = 0; i < data.Length; i++)
                {
                    sBuilder.Append(data[i].ToString("x2"));
                }

                return sBuilder.ToString();
            }
        }

        public NguoiDungModel Login(string TaiKhoan, string MatKhau)
        {
            // Mã hóa mật khẩu từ người dùng trước khi so sánh
            string hashedPassword = GetMd5Hash(MatKhau);
            var nguoidung = _res.Login(TaiKhoan, hashedPassword);

            if (nguoidung == null)
                return null;

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Email, nguoidung.Email.ToString()),
                    new Claim(ClaimTypes.Name, nguoidung.HoTen.ToString()),
                    new Claim(ClaimTypes.DateOfBirth, nguoidung.NgaySinh.ToString()),
                    new Claim(ClaimTypes.Gender, nguoidung.GioiTinh.ToString()),
                    new Claim(ClaimTypes.StreetAddress, nguoidung.DiaChi.ToString()),
                    new Claim(ClaimTypes.MobilePhone, nguoidung.SDT.ToString()),
                    new Claim(ClaimTypes.Role, nguoidung.MaQuyen.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            nguoidung.token = tokenHandler.WriteToken(token);

            return nguoidung;
        }

        public bool Register(NguoiDungModel model)
        {
            // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
            string hashedPassword = GetMd5Hash(model.MatKhau);
            model.MatKhau = hashedPassword;
            return _res.Register(model);
        }

        public NguoiDungModel CheckExist(string TaiKhoan, string Email)
        {
            return _res.CheckExist(TaiKhoan, Email);
        }


        public List<NguoiDungModel> GetAllStaff(int pageIndex, int pageSize, string? HoTen, out long total)
        {
            return _res.GetAllStaff(pageIndex, pageSize, HoTen, out total);
        }

        public List<NguoiDungModel> GetAllCustomer(int pageIndex, int pageSize, string? HoTen, out long total)
        {
            return _res.GetAllCustomer(pageIndex, pageSize, HoTen, out total);
        }

        public NguoiDungModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public bool Create(NguoiDungModel model)
        {
            // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
            string hashedPassword = GetMd5Hash(model.MatKhau);
            model.MatKhau = hashedPassword;
            return _res.Create(model);
        }

        public bool Update(NguoiDungModel model)
        {
            if(model.MatKhau != null)
            {
                // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
                string hashedPassword = GetMd5Hash(model.MatKhau);
                model.MatKhau = hashedPassword;
            }
            
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
