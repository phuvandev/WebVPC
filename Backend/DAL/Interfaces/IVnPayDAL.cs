﻿using Microsoft.AspNetCore.Http;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IVnPayDAL
    {
        string CreatePaymentUrl(PaymentInformationModel model, HttpContext context);
        VnPayModel PaymentExecute(IQueryCollection collections);
    }
}
