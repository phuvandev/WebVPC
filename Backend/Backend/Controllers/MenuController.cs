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
    public class MenuController : ControllerBase
    {
        private IMenuBLL _menuBLL;
        public MenuController(IMenuBLL menuBLL)
        {
            _menuBLL = menuBLL;
        }

        [AllowAnonymous] //không cần xác thực
        [Route("get-all-client")]
        [HttpGet]
        public IActionResult GetAllClient()
        {
            try
            {
                var result = _menuBLL.GetAllClient();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("get-all-admin")]
        [HttpGet]
        public IActionResult GetAllAdmin()
        {
            try
            {
                var result = _menuBLL.GetAllAdmin();
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
                var result = _menuBLL.GetOne(id);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        
        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromBody] MenuModel model)
        {
            try
            {
                _menuBLL.Create(model);
                return Ok(new { success = true, message = "Tạo mới thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("update")]
        [HttpPut]
        public IActionResult Update([FromBody] MenuModel model)
        {
            try
            {
                _menuBLL.Update(model);
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
                _menuBLL.Delete(id);
                return Ok(new { success = true, message = "Xóa thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
