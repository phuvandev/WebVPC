using DAL.Helper;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class ThongKeDAL : IThongKeDAL
    {
        private IDatabaseHelper _dbHelper;
        public ThongKeDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public ThongKeSoLuongModel StatisticQuantity()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_statistic_soluong");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<ThongKeSoLuongModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ThongKeModel> StatisticRevenue12Month()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_statistic_doanhthu_12month");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<ThongKeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ThongKeModel> StatisticHotCategory()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_statistic_dongsanphambanchay");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<ThongKeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ThongKeModel> StatisticRevenue5Year()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_statistic_doanhthu_5year");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<ThongKeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
