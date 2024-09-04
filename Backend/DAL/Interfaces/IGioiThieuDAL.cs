﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IGioiThieuDAL
    {
        GioiThieuModel GetDataClient();
        GioiThieuModel GetDataAdmin();

        bool Update(GioiThieuModel model);
    }
}
