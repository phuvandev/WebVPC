using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace Backend.Controllers
{
    [Authorize(Roles = "1")] //xác thực
    [Route("api/[controller]")]
    [ApiController]
    public class QuyenController : ControllerBase
    {
        private IQuyenBLL _quyenBLL;
        public QuyenController(IQuyenBLL quyenBLL)
        {
            _quyenBLL = quyenBLL;
        }

        [Route("get-all-admin")]
        [HttpGet]
        public IActionResult GetAllAdmin()
        {
            try
            {
                var result = _quyenBLL.GetAllAdmin();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
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
                var result = _quyenBLL.GetOne(id);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromBody] QuyenModel model)
        {
            try
            {
                _quyenBLL.Create(model);
                return Ok(new { success = true, message = "Tạo mới thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("update")]
        [HttpPut]
        public IActionResult Update([FromBody] QuyenModel model)
        {
            try
            {
                _quyenBLL.Update(model);
                return Ok(new { success = true, message = "Cập nhật thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("delete/{id}")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            try
            {
                _quyenBLL.Delete(id);
                return Ok(new { success = true, message = "Xóa thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
