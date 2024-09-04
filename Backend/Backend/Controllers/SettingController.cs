using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;
using System.Data;

namespace Backend.Controllers
{
    [Authorize(Roles = "1, 2")] //xác thực
    [Route("api/[controller]")]
    [ApiController]
    public class SettingController : ControllerBase
    {
        private ISettingBLL _settingBLL;
        private string _path;


        public SettingController(ISettingBLL settingBLL, IConfiguration configuration)
        {
            _settingBLL = settingBLL;
            _path = configuration["AppSettings:PATH_IMG"];
        }

        [Route("get-all-admin")]
        [HttpPost]
        public IActionResult GetAllAdmin([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                string TenSetting = "";
                if (formData.Keys.Contains("tenSetting") && !string.IsNullOrEmpty(Convert.ToString(formData["tenSetting"]))) { TenSetting = Convert.ToString(formData["tenSetting"]); }

                long total = 0;
                var data = _settingBLL.GetAllAdmin(page, pageSize, TenSetting, out total);

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
        [Route("get-by-sign/{kyhieu}")]
        [HttpGet]
        public IActionResult GetSign(string KyHieu)
        {
            try
            {
                var result = _settingBLL.GetBySign(KyHieu);
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
                var result = _settingBLL.GetOne(id);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromForm] SettingModel model)
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

                    // Tạo đối tượng Setting mới với các thông tin
                    var setting = new SettingModel
                    {
                        TenSetting = model.TenSetting,
                        KyHieu = model.KyHieu,
                        Anh = System.IO.File.ReadAllBytes(filePath), // Chuyển đổi tệp ảnh thành mảng byte, // Đường dẫn tương đối của ảnh
                        MoTa = model.MoTa
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
                    _settingBLL.Create(setting);

                    // Trả về kết quả thành công
                    return Ok(new { success = true, message = "Tạo mới thành công" });
                }
                else
                {
                    // Tạo đối tượng Setting mới với các thông tin
                    var setting = new SettingModel
                    {
                        TenSetting = model.TenSetting,
                        KyHieu = model.KyHieu,
                        Anh = new byte[0], // mảng byte rỗng
                        MoTa = model.MoTa
                    };
                    // Gọi phương thức Create từ BLL để thêm mới vào cơ sở dữ liệu
                    _settingBLL.Create(setting);

                    // Trả về kết quả thành công
                    return Ok(new { success = true, message = "Tạo mới thành công" });
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
        public IActionResult Update([FromForm] SettingModel model)
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

                    model.Anh = System.IO.File.ReadAllBytes(filePath);

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

                _settingBLL.Update(model);

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
                var setting = _settingBLL.GetOne(id);

                if (setting == null)
                {
                    return NotFound(new { success = false, message = "Setting không tồn tại" });
                }

                // Xoá từ cơ sở dữ liệu
                bool result = _settingBLL.Delete(id);

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
