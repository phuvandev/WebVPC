using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Model;

namespace Backend.Controllers
{
    [Authorize(Roles = "1, 2")] //xác thực
    [Route("api/[controller]")]
    [ApiController]
    public class TinTucController : ControllerBase
    {
        private ITinTucBLL _tintucBLL;
        private string _path;


        public TinTucController(ITinTucBLL tintucBLL, IConfiguration configuration)
        {
            _tintucBLL = tintucBLL;
            _path = configuration["AppSettings:PATH_IMG"];
        }

        [AllowAnonymous]
        [Route("get-all-client")]
        [HttpPost]
        public IActionResult GetAllClient([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                long total = 0;
                var data = _tintucBLL.GetAllClient(page, pageSize, out total);

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

        [Route("get-all-admin")]
        [HttpPost]
        public IActionResult GetAllAdmin([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                string TieuDe = "";
                if (formData.Keys.Contains("tieuDe") && !string.IsNullOrEmpty(Convert.ToString(formData["tieuDe"]))) { TieuDe = Convert.ToString(formData["tieuDe"]); }

                long total = 0;
                var data = _tintucBLL.GetAllAdmin(page, pageSize, TieuDe, out total);

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

        [AllowAnonymous]
        [Route("get-one/{id}")]
        [HttpGet]
        public IActionResult GetOne(int id)
        {
            try
            {
                var result = _tintucBLL.GetOne(id);
                if (result != null)
                {
                    return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
                }
                else
                {
                    // Trả về thông báo lỗi
                    return Ok(new { success = false, message = "Tin tức này hiện không khả dụng!" });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [AllowAnonymous]
        [Route("get-random")]
        [HttpGet]
        public IActionResult GetRandom([FromQuery] int maTT, [FromQuery] int soLuong)
        {
            try
            {
                var result = _tintucBLL.GetRandom(maTT, soLuong);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromForm] TinTucModel model)
        {
            try
            {
                //Kiểm tra xem có dữ liệu file ảnh được gửi lên không và có dung lượng lớn hơn 0 không
                if (model.File != null && model.File.Length > 0)
                {
                    if (model.File.Length > 5 * 1024 * 1024) // Kiểm tra kích thước tệp, 5MB
                    {
                        return BadRequest(new { success = false, message = "Kích thước tệp ảnh không được vượt quá 5MB." });
                    }

                    // Tạo tên file duy nhất bằng cách kết hợp GUID và tên file gốc
                    string uniqueFileName = Guid.NewGuid().ToString() + "_" + model.File.FileName;

                    // Kết hợp đường dẫn thư mục lưu trữ ảnh và tên file duy nhất để tạo đường dẫn đầy đủ
                    string filePath = Path.Combine(_path, uniqueFileName);

                    // Lưu file ảnh vào thư mục được chỉ định
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        model.File.CopyTo(stream); // Copy dữ liệu file vào stream
                    }

                    // Tạo đối tượng tintuc mới với các thông tin
                    var tintuc = new TinTucModel
                    {
                        AnhDaiDien = System.IO.File.ReadAllBytes(filePath), // Chuyển đổi tệp ảnh thành mảng byte, // Đường dẫn tương đối của ảnh
                        TieuDe = model.TieuDe,
                        NoiDung = model.NoiDung,
                        TrangThai = model.TrangThai,
                        MaND = model.MaND
                    };

                    // Xoá file ảnh theo tên từ thư mục lưu trữ
                    if (!string.IsNullOrEmpty(uniqueFileName))
                    {
                        string filePathDelete = Path.Combine(_path, uniqueFileName);
                        if (System.IO.File.Exists(filePathDelete))
                        {
                            System.IO.File.Delete(filePathDelete);
                        }
                    }

                    // Gọi phương thức Create từ BLL để thêm mới vào cơ sở dữ liệu
                    _tintucBLL.Create(tintuc);

                    // Trả về kết quả thành công
                    return Ok(new { success = true, message = "Tạo mới thành công" });
                }
                else
                {
                    return BadRequest(new { success = false, message = "Vui lòng chọn một tệp ảnh." });
                }
            }
            catch (Exception ex)
            {
                // Nếu có lỗi xảy ra, trả về mã lỗi 500 và thông báo lỗi
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("update")]
        [HttpPut]
        public IActionResult Update([FromForm] TinTucModel model)
        {
            try
            {
                // Kiểm tra xem người dùng có tải lên một ảnh mới không
                if (model.File != null && model.File.Length > 0)
                {
                    if (model.File.Length > 5 * 1024 * 1024) // Kiểm tra kích thước tệp, 5MB
                    {
                        return BadRequest(new { success = false, message = "Kích thước tệp ảnh không được vượt quá 5MB." });
                    }

                    // Tạo tên file duy nhất bằng cách kết hợp GUID và tên file gốc
                    string uniqueFileName = Guid.NewGuid().ToString() + "_" + model.File.FileName;

                    // Kết hợp đường dẫn thư mục lưu trữ ảnh và tên file duy nhất để tạo đường dẫn đầy đủ
                    string filePath = Path.Combine(_path, uniqueFileName);

                    // Lưu file ảnh vào thư mục được chỉ định
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        model.File.CopyTo(stream); // Copy dữ liệu file vào stream
                    }

                    model.AnhDaiDien = System.IO.File.ReadAllBytes(filePath);

                    // Xoá file ảnh theo tên từ thư mục lưu trữ
                    if (!string.IsNullOrEmpty(uniqueFileName))
                    {
                        string filePathDelete = Path.Combine(_path, uniqueFileName);
                        if (System.IO.File.Exists(filePathDelete))
                        {
                            System.IO.File.Delete(filePathDelete);
                        }
                    }
                }

                _tintucBLL.Update(model);

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
                // Lấy thông tin từ cơ sở dữ liệu
                var tintuc = _tintucBLL.GetOne(id);

                if (tintuc == null)
                {
                    return NotFound(new { success = false, message = "Tin tức không tồn tại" });
                }

                // Xoá từ cơ sở dữ liệu
                bool result = _tintucBLL.Delete(id);

                if (result)
                {
                    return Ok(new { success = true, message = "Xóa thành công" });
                }
                else
                {
                    return NotFound(new { success = false, message = "Không thể xoá" });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
