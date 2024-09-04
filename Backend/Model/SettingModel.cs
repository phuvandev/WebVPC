using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class SettingModel
    {
        public int MaSetting { get; set; }
        public string? TenSetting { get; set; }
        public string? KyHieu { get; set; }
        public byte[]? Anh { get; set; }
        public string? MoTa { get; set; }

        public IFormFile? File { get; set; }
    }
}
