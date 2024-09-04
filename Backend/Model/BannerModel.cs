using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class BannerModel
    {
        public int MaBanner { get; set; }
        public byte[]? Anh { get; set; }
        public string?Link { get; set; }
        public int? TrangThai { get; set; }

        public IFormFile? File { get; set; }
    }
}
