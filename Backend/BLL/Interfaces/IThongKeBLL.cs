using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IThongKeBLL
    {
        ThongKeSoLuongModel StatisticQuantity();

        List<ThongKeModel> StatisticRevenue12Month();
        List<ThongKeModel> StatisticHotCategory();
        List<ThongKeModel> StatisticRevenue5Year();
    }
}
