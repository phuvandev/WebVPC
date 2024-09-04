using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NguoiDungController : ControllerBase
    {
        private INguoiDungBLL _nguoidungBLL;
        private string _path;

        public NguoiDungController(INguoiDungBLL nguoidungBLL, IConfiguration configuration)
        {
            _nguoidungBLL = nguoidungBLL;
            _path = configuration["AppSettings:PATH_IMG"];
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] NguoiDungModel model)
        {
            var data = _nguoidungBLL.Login(model.TaiKhoan, model.MatKhau);
            if (data != null)
            {
                if (data.TrangThai == 0)
                {
                    // Trả về thông báo lỗi
                    return Ok(new { message = "Tài khoản đang bị khóa, vui lòng liên hệ đội ngũ admin", status = 403 });
                } else
                {
                    return Ok(new { result = data, message = "Đăng nhập thành công", status = 200 });
                }
            }
            else
            {
                // Trả về thông báo lỗi
                return Ok(new { message = "Thông tin đăng nhập không chính xác", status = 404 });
            }
        }

        [Route("register")]
        [HttpPost]
        public IActionResult Register([FromBody] NguoiDungModel model)
        {
            try
            {
                _nguoidungBLL.Register(model);
                return Ok(new { success = true, message = "Đăng ký thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("check-exist")]
        [HttpPost]
        public IActionResult CheckExist([FromBody] NguoiDungModel model)
        {
            var data = _nguoidungBLL.CheckExist(model.TaiKhoan, model.Email);
            if (data != null)
            {
                return Ok(new { result = data, message = "Tài khoản hoặc email đã tồn tại", status = 409 }); //lỗi Conflict
            }
            else
            {
                // Trả về thông báo lỗi
                return Ok(new { message = "Tài khoản, email chưa tồn tại, tiếp tục đăng ký", status = 200 });
            }

        }


        [Authorize(Roles = "1")] //xác thực
        [Route("get-all-staff")]
        [HttpPost]
        public IActionResult GetAllStaff([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                string HoTen = "";
                if (formData.Keys.Contains("hoTen") && !string.IsNullOrEmpty(Convert.ToString(formData["hoTen"]))) { HoTen = Convert.ToString(formData["hoTen"]); }


                long total = 0;
                var data = _nguoidungBLL.GetAllStaff(page, pageSize, HoTen, out total);

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

        [Authorize(Roles = "1")] //xác thực
        [Route("get-all-customer")]
        [HttpPost]
        public IActionResult GetAllCustomer([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                string HoTen = "";
                if (formData.Keys.Contains("hoTen") && !string.IsNullOrEmpty(Convert.ToString(formData["hoTen"]))) { HoTen = Convert.ToString(formData["hoTen"]); }


                long total = 0;
                var data = _nguoidungBLL.GetAllCustomer(page, pageSize, HoTen, out total);

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

        [Authorize(Roles = "1")] //xác thực
        [Route("get-one/{id}")]
        [HttpGet]
        public IActionResult GetOne(int id)
        {
            try
            {
                var result = _nguoidungBLL.GetOne(id);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Authorize(Roles = "1")] //xác thực
        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromForm] NguoiDungModel model)
        {
            try
            {
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

                    // Tạo đối tượng nguoidung mới với các thông tin
                    var nguoidung = new NguoiDungModel
                    {
                        TaiKhoan = model.TaiKhoan,
                        MatKhau = model.MatKhau,
                        Email = model.Email,
                        HoTen = model.HoTen,
                        NgaySinh = model.NgaySinh,
                        GioiTinh = model.GioiTinh,
                        AnhDaiDien = System.IO.File.ReadAllBytes(filePath), // Chuyển đổi tệp ảnh thành mảng byte, // Đường dẫn tương đối của ảnh
                        DiaChi = model.DiaChi,
                        SDT = model.SDT,
                        TrangThai = model.TrangThai,
                        MaQuyen = model.MaQuyen
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

                    _nguoidungBLL.Create(nguoidung);

                    return Ok(new { success = true, message = "Tạo mới thành công" });
                }
                else
                {
                    // Tạo người dùng mới với các thông tin
                    var nguoidung = new NguoiDungModel
                    {
                        TaiKhoan = model.TaiKhoan,
                        MatKhau = model.MatKhau,
                        Email = model.Email,
                        HoTen = model.HoTen,
                        NgaySinh = model.NgaySinh,
                        GioiTinh = model.GioiTinh,
                        AnhDaiDien = new byte[0], // mảng byte rỗng
                        DiaChi = model.DiaChi,
                        SDT = model.SDT,
                        TrangThai = model.TrangThai,
                        MaQuyen = model.MaQuyen
                    };

                    _nguoidungBLL.Create(nguoidung);

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

        [Authorize] //xác thực
        [Route("update")]
        [HttpPut]
        public IActionResult Update([FromForm] NguoiDungModel model)
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

                // Gọi phương thức cập nhật từ BLL với thông tin mới
                _nguoidungBLL.Update(model);

                return Ok(new { success = true, message = "Cập nhật thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Authorize(Roles = "1")] //xác thực
        [Route("delete/{id}")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            try
            {
                // Lấy thông tin từ cơ sở dữ liệu
                var nguoidung = _nguoidungBLL.GetOne(id);

                if (nguoidung == null)
                {
                    return NotFound(new { success = false, message = "Người dùng không tồn tại" });
                }

                // Xoá từ cơ sở dữ liệu
                bool result = _nguoidungBLL.Delete(id);

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
