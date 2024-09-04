using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class DongSanPhamModel
    {
        public int MaDSP { get; set; }
        public string? TenDSP { get; set; }
        public byte[]? Logo { get; set; }
        public int? TrangThai { get; set; }

        public IFormFile? File { get; set; }
    }
}
