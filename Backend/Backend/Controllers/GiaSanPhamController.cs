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
    public class GiaSanPhamController : ControllerBase
    {
        private IGiaSanPhamBLL _giasanphamBLL;
        public GiaSanPhamController(IGiaSanPhamBLL giasanphamBLL)
        {
            _giasanphamBLL = giasanphamBLL;
        }

        [Route("get-all-admin")]
        [HttpPost]
        public IActionResult GetAllAdmin([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string TenSP = "";
                if (formData.Keys.Contains("tenSP") && !string.IsNullOrEmpty(Convert.ToString(formData["tenSP"]))) { TenSP = Convert.ToString(formData["tenSP"]); }

                long total = 0;
                var data = _giasanphamBLL.GetAllAdmin(page, pageSize, TenSP, out total);

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

        //[Route("get-by-sp/{masp}")]
        //[HttpGet]
        //public IActionResult GetBySP(int maSP)
        //{
        //    try
        //    {
        //        var result = _giasanphamBLL.GetBySP(maSP);
        //        return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
        //    }
        //}


        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromBody] GiaSanPhamModel model)
        {
            try
            {
                _giasanphamBLL.Create(model);
                return Ok(new { success = true, message = "Tạo mới thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("update")]
        [HttpPut]
        public IActionResult Update([FromBody] GiaSanPhamModel model)
        {
            try
            {
                _giasanphamBLL.Update(model);
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
                _giasanphamBLL.Delete(id);
                return Ok(new { success = true, message = "Xóa thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
