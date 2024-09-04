using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace Backend.Controllers
{
    [Authorize(Roles = "1, 2")] //xác thực
    [Route("api/[controller]")]
    [ApiController]
    public class ThongKeController : ControllerBase
    {
        private IThongKeBLL _thongkeBLL;
        public ThongKeController(IThongKeBLL thongkeBLL)
        {
            _thongkeBLL = thongkeBLL;
        }

        [Route("statistic-quantity")]
        [HttpGet]
        public IActionResult StatisticQuantity()
        {
            try
            {
                var result = _thongkeBLL.StatisticQuantity();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("statistic-revenue-12month")]
        [HttpGet]
        public IActionResult StatisticRevenue12Month()
        {
            try
            {
                var result = _thongkeBLL.StatisticRevenue12Month();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("statistic-hot-category")]
        [HttpGet]
        public IActionResult StatisticHotCategory()
        {
            try
            {
                var result = _thongkeBLL.StatisticHotCategory();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("statistic-revenue-5year")]
        [HttpGet]
        public IActionResult StatisticRevenue5Year()
        {
            try
            {
                var result = _thongkeBLL.StatisticRevenue5Year();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

    }
}
