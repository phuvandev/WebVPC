using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class DonHangModel
    {
        public int MaDH { get; set; }
        public string? TenKH { get; set; }
        public string? Email { get; set; }
        public string? DiaChiGiaoHang { get; set; }
        public string? SDT { get; set; }
        public string? GhiChu { get; set; }
        public DateTime NgayDat { get; set; }
        public string? PhuongThucThanhToan { get; set; }
        public int? TrangThai { get; set; }
        public int? MaND { get; set; }

        public long TongTien { get; set; }

        public List<CTDonHangModel>? listjson_chitietdonhang { get; set; }
    }

    public class CTDonHangModel
    {
        public int MaCTDH { get; set; }
        public int SoLuong { get; set; }
        public long GiaBan { get; set; }
        public int MaSP { get; set; }
        public int MaDH { get; set; }

        public string? TenSP { get; set; }
        public byte[]? AnhDaiDien { get; set; }
    }
}
