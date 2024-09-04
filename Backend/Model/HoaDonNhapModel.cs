﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class HoaDonNhapModel
    {
        public int MaHDN { get; set; }
        public DateTime? NgayNhap { get; set; }
        public int TrangThai { get; set; }  
        public int MaND { get; set; }
        public int MaNCC { get; set; }

        public string? HoTen { get; set; }
        public string? TenNCC { get; set; }

        public long TongTien { get; set; }

        public List<CTHoaDonNhapModel>? listjson_chitiethoadonnhap { get; set; }
    }

    public class CTHoaDonNhapModel
    {
        public int MaCTHDN { get; set; }
        public int SoLuong { get; set; }
        public int GiaNhap { get; set; }
        public int MaSP { get; set; }
        public int MaHDN { get; set; }

        public string? TenSP { get; set; }
        public byte[]? AnhDaiDien { get; set; }
    }
}
