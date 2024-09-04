﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IDongSanPhamDAL
    {
        List<DongSanPhamModel> GetAllClient();
        List<DongSanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenDSP, out long total);
        DongSanPhamModel GetOne(int id);
        bool Create(DongSanPhamModel model);
        bool Update(DongSanPhamModel model);
        bool Delete(int id);
    }
}