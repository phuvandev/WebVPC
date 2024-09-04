﻿using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IGioiThieuBLL
    {
        GioiThieuModel GetDataClient();
        GioiThieuModel GetDataAdmin();

        bool Update(GioiThieuModel model);
    }
}
