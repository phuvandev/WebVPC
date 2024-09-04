using BLL.Interfaces;
using DAL.Interfaces;
using Microsoft.AspNetCore.Http;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class VnPayBLL : IVnPayBLL
    {
        private IVnPayDAL _res;
        public VnPayBLL(IVnPayDAL res)
        {
            _res = res;
        }
        public string CreatePaymentUrl(PaymentInformationModel model, HttpContext context)
        {
            return _res.CreatePaymentUrl(model, context);
        }
        public VnPayModel PaymentExecute(IQueryCollection collections)
        {
            return _res.PaymentExecute(collections);
        }
    }
}
