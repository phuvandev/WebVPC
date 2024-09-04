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
    public class DonHangBLL : IDonHangBLL
    {
        private IDonHangDAL _res;
        public DonHangBLL(IDonHangDAL res)
        {
            _res = res;
        }

        public List<DonHangModel> GetAllAdmin(int pageIndex, int pageSize, string? TenKH, out long total)
        {
            return _res.GetAllAdmin(pageIndex, pageSize, TenKH, out total);
        }

        public bool Create(DonHangModel model)
        {
            return _res.Create(model);
        }

        public DonHangModel GetOneNew()
        {
            return _res.GetOneNew();
        }


        public bool Check(DonHangModel model)
        {
            return _res.Check(model);
        }

        public List<CTDonHangModel> GetByDH(int maDH)
        {
            return _res.GetByDH(maDH);
        }

        public List<DonHangModel> GetPurchaseHistory(int pageIndex, int pageSize, int? maND, out long total)
        {
            return _res.GetPurchaseHistory(pageIndex, pageSize, maND, out total);
        }

        public DonHangModel GetOne(int id)
        {
            return _res.GetOne(id);
        }
    }
}
