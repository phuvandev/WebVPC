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
    public class HoaDonNhapController : ControllerBase
    {
        private IHoaDonNhapBLL _hoadonnhapBLL;

        public HoaDonNhapController(IHoaDonNhapBLL hoadonnhapBLL)
        {
            _hoadonnhapBLL = hoadonnhapBLL;
        }

        [Route("get-all-admin")]
        [HttpPost]
        public IActionResult GetAllAdmin([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                string TenNCC = "";
                if (formData.Keys.Contains("tenNCC") && !string.IsNullOrEmpty(Convert.ToString(formData["tenNCC"]))) { TenNCC = Convert.ToString(formData["tenNCC"]); }

                long total = 0;
                var data = _hoadonnhapBLL.GetAllAdmin(page, pageSize, TenNCC, out total);

                var response = new
                {
                    success = true,
                    message = "Lấy dữ liệu thành công",
                    totalItems = total,
                    page = page,
                    pageSize = pageSize,
                    data = data
                };

                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }

        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromBody] HoaDonNhapModel model)
        {
            try
            {
                _hoadonnhapBLL.Create(model);
                return Ok(new { success = true, message = "Tạo mới thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("get-one/{id}")]
        [HttpGet]
        public IActionResult GetOne(int id)
        {
            try
            {
                var result = _hoadonnhapBLL.GetOne(id);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("get-by-importInvoice/{mahdn}")]
        [HttpGet]
        public IActionResult GetByHDN(int maHDN)
        {
            try
            {
                var result = _hoadonnhapBLL.GetByHDN(maHDN);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

    }
}
