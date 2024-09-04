using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class ThongKeBLL : IThongKeBLL
    {
        private IThongKeDAL _res;
        public ThongKeBLL(IThongKeDAL res)
        {
            _res = res;
        }

        public ThongKeSoLuongModel StatisticQuantity()
        {
            return _res.StatisticQuantity();
        }

        public List<ThongKeModel> StatisticRevenue12Month()
        {
            return _res.StatisticRevenue12Month();
        }

        public List<ThongKeModel> StatisticHotCategory()
        {
            return _res.StatisticHotCategory();
        }

        public List<ThongKeModel> StatisticRevenue5Year()
        {
            return _res.StatisticRevenue5Year();
        }

        

    }
}
