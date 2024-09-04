using BLL.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SanPhamBLL : ISanPhamBLL
    {
        private ISanPhamDAL _res;
        public SanPhamBLL(ISanPhamDAL res)
        {
            _res = res;
        }

        public List<SanPhamModel> GetNew(int soLuong)
        {
            return _res.GetNew(soLuong);
        }

        public List<SanPhamModel> GetHot(int soLuong)
        {
            return _res.GetHot(soLuong);
        }

        public List<SanPhamModel> GetSale(int soLuong)
        {
            return _res.GetSale(soLuong);
        }

        public List<SanPhamModel> GetSameCategory(int maDSP, int maSP)
        {
            return _res.GetSameCategory(maDSP, maSP);
        }

        public List<SanPhamModel> Search(int pageIndex, int pageSize, string tenSP, out long total)
        {
            return _res.Search(pageIndex, pageSize, tenSP, out total);
        }

        public List<SanPhamModel> GetByDSP(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total)
        {
            return _res.GetByDSP(pageIndex, pageSize, maDSP, minGia, maxGia, chongNuoc, out total);
        }

        public List<SanPhamModel> FilterByPriceAsc(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total)
        {
            return _res.FilterByPriceAsc(pageIndex, pageSize, maDSP, minGia, maxGia, chongNuoc, out total);
        }

        public List<SanPhamModel> FilterByPriceDesc(int pageIndex, int pageSize, int? maDSP, int? minGia, int? maxGia, string? chongNuoc, out long total)
        {
            return _res.FilterByPriceDesc(pageIndex, pageSize, maDSP, minGia, maxGia, chongNuoc, out total);
        }

        public SanPhamModel GetOne(int id)
        {
            return _res.GetOne(id);
        }

        public List<SanPhamModel> GetAllAdmin(int pageIndex, int pageSize, string? TenSP, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TenSP, out total);
        }

        public List<SanPhamModel> GetWithoutPrice(int pageIndex, int pageSize, string? TenSP, out long total)
        {
            return _res.GetWithoutPrice(pageIndex, pageSize, TenSP, out total);
        }

        public SanPhamModel GetOneAdmin(int id)
        {
            return _res.GetOneAdmin(id);
        }

        public bool Create(SanPhamModel model)
        {
            return _res.Create(model);
        }

        public bool Update(SanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}
