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
    public class DongSanPhamController : ControllerBase
    {
        private IDongSanPhamBLL _dongsanphamBLL;
        private string _path;


        public DongSanPhamController(IDongSanPhamBLL dongsanphamBLL, IConfiguration configuration)
        {
            _dongsanphamBLL = dongsanphamBLL;
            _path = configuration["AppSettings:PATH_IMG"];
        }

        [AllowAnonymous]
        [Route("get-all-client")]
        [HttpGet]
        public IActionResult GetAllClient()
        {
            try
            {
                var result = _dongsanphamBLL.GetAllClient();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
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

                string TenDSP = "";
                if (formData.Keys.Contains("tenDSP") && !string.IsNullOrEmpty(Convert.ToString(formData["tenDSP"]))) { TenDSP = Convert.ToString(formData["tenDSP"]); }

                long total = 0;
                var data = _dongsanphamBLL.GetAllAdmin(page, pageSize, TenDSP, out total);

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
                var result = _dongsanphamBLL.GetOne(id);
                if (result != null)
                {
                    return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
                }
                else
                {
                    // Trả về thông báo lỗi
                    return Ok(new { success = false, message = "Dòng sản phẩm này hiện không khả dụng!" });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromForm] DongSanPhamModel model)
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

                    // Tạo đối tượng dongsanpham mới với các thông tin
                    var dongsanpham = new DongSanPhamModel
                    {
                        TenDSP = model.TenDSP,
                        Logo = System.IO.File.ReadAllBytes(filePath), // Chuyển đổi tệp ảnh thành mảng byte, // Đường dẫn tương đối của ảnh
                        TrangThai = model.TrangThai
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
                    _dongsanphamBLL.Create(dongsanpham);

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
        public IActionResult Update([FromForm] DongSanPhamModel model)
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

                    model.Logo = System.IO.File.ReadAllBytes(filePath);

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

                _dongsanphamBLL.Update(model);

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
                var dongsanpham = _dongsanphamBLL.GetOne(id);

                if (dongsanpham == null)
                {
                    return NotFound(new { success = false, message = "Dòng sản phẩm không tồn tại" });
                }

                // Xoá từ cơ sở dữ liệu
                bool result = _dongsanphamBLL.Delete(id);

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
