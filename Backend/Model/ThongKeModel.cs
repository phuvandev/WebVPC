using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class ThongKeModel
    {
        public string? ThangNam { get; set; }
        public int? DoanhThu { get; set; }

        public int? MaDSP { get; set; }
        public string? TenDSP { get; set; }
        public int? SoLuongSanPhamBanRa { get; set; }

        public string? Nam { get; set; }
        public long? DoanhThuNam { get; set; }
        public int? SLSanPhamBanRa { get; set; }
    }

    public class ThongKeSoLuongModel
    {
        public int? SoLuongSP { get; set; }

        public int? SoLuongKH { get; set; }

        public int? SoLuongDHDaHoanThanh { get; set; }
        public int? SoLuongDHChuaXacThuc { get; set; }

        public long? DoanhSo { get; set; }
        public int? NamHienTai { get; set; }
    }
}
