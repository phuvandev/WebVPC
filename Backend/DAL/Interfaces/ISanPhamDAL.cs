using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ISanPhamDAL
    {
        List<SanPhamModel> GetNew(int soLuong);
        List<SanPhamModel> GetHot(int soLuong);
        List<SanPhamModel> GetSale(int soLuong);
        List<SanPhamModel> GetSameCategory(int maDSP, int MaSP);
        List<SanPhamModel> Search(int pageIndex, int pageSize, string tenSP, out long total);

        List<SanPhamModel> GetByDSP(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total);
        List<SanPhamModel> FilterByPriceAsc(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total);
        List<SanPhamModel> FilterByPriceDesc(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total);
        SanPhamModel GetOne(int id);

        List<SanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSP, out long total);
        SanPhamModel GetOneAdmin(int id);
        List<SanPhamModel> GetWithoutPrice(int pageIndex, int pageSize, string? TenSP, out long total);
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);
        bool Delete(int id);
    }
}
