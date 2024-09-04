using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class SanPhamModel
    {
        public int MaSP { get; set; }
        public string? TenSP { get; set; }
        public byte[]? AnhDaiDien { get; set; }
        public int? SoLuong { get; set; }
        public string? KichThuoc { get; set; }
        public string? TrongLuong { get; set; }
        public string? MatKinh { get; set; }
        public string? ChatLieuDay { get; set; }
        public string? ChongNuoc { get; set; }
        public string? LoaiMay { get; set; }
        public string? MoTa { get; set; }
        public DateTime? NgayTao { get; set; }
        public int TrangThai { get; set; }
        public int? MaDSP { get; set; }

        public string? TenDSP { get; set; }
        public int? GiaBan { get; set; }
        public int? PhanTramGiamGia { get; set; }
        public int? GiaSauGiam { get; set; }

        public IFormFile? File { get; set; }
    }
}
