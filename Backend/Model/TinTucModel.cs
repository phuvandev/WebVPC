using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class TinTucModel
    {
        public int MaTT { get; set; }
        public byte[]? AnhDaiDien { get; set; }
        public string? TieuDe { get; set; }
        public DateTime? NgayDang { get; set; }
        public string? NoiDung { get; set; }
        public int? TrangThai { get; set; }
        public int? MaND { get; set; }

        public string? HoTen { get; set; }

        public IFormFile? File { get; set; }
    }
}
