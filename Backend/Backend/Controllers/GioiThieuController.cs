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
    public class GioiThieuController : ControllerBase
    {
        private IGioiThieuBLL _gioithieuBLL;
        public GioiThieuController(IGioiThieuBLL gioithieuBLL)
        {
            _gioithieuBLL = gioithieuBLL;
        }

        [AllowAnonymous] 
        [Route("get-data-client")]
        [HttpGet]
        public IActionResult GetDataClient()
        {
            try
            {
                var result = _gioithieuBLL.GetDataClient();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("get-data-admin")]
        [HttpGet]
        public IActionResult GetDataAdmin()
        {
            try
            {
                var result = _gioithieuBLL.GetDataAdmin();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("update")]
        [HttpPut]
        public IActionResult Update([FromBody] GioiThieuModel model)
        {
            try
            {
                _gioithieuBLL.Update(model);
                return Ok(new { success = true, message = "Cập nhật thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
