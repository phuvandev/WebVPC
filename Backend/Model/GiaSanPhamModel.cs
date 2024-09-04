using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class GiaSanPhamModel
    {
        public int MaGSP { get; set; }
        public int? GiaBan { get; set; }
        public int? PhanTramGiamGia { get; set; }
        public DateTime? NgayBD { get; set; }
        public DateTime? NgayKT { get; set; }
        public int? MaSP { get; set; }
           
        public string? TenSP { get; set; }
        public byte[]? AnhDaiDien { get; set; }
        public int? GiaSauGiam { get; set; }

    }
}
