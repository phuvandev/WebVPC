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
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBLL _sanphamBLL;
        private string _path;

        public SanPhamController(ISanPhamBLL sanphamBLL, IConfiguration configuration)
        {
            _sanphamBLL = sanphamBLL;
            _path = configuration["AppSettings:PATH_IMG"];
        }

        [AllowAnonymous]
        [Route("get-new/{soLuong}")]
        [HttpGet]
        public IActionResult GetNew(int soLuong)
        {
            try
            {
                var result = _sanphamBLL.GetNew(soLuong);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [AllowAnonymous]
        [Route("get-hot/{soLuong}")]
        [HttpGet]
        public IActionResult GetHot(int soLuong)
        {
            try
            {
                var result = _sanphamBLL.GetHot(soLuong);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [AllowAnonymous]
        [Route("get-sale/{soLuong}")]
        [HttpGet]
        public IActionResult GetSale(int soLuong)
        {
            try
            {
                var result = _sanphamBLL.GetSale(soLuong);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [AllowAnonymous]
        [Route("get-same-category")]
        [HttpGet]
        public IActionResult GetSameCategory([FromQuery] int maDSP, [FromQuery] int maSP)
        {
            try
            {
                var result = _sanphamBLL.GetSameCategory(maDSP, maSP);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [AllowAnonymous]
        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string tenSP = "";
                if (formData.Keys.Contains("tenSP") && !string.IsNullOrEmpty(Convert.ToString(formData["tenSP"])))
                {
                    tenSP = Convert.ToString(formData["tenSP"].ToString());
                }

                long total = 0;
                var data = _sanphamBLL.Search(page, pageSize, tenSP, out total);

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
        [Route("get-by-dsp")]
        [HttpPost]
        public IActionResult GetByDSP([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int? maDSP = null;
                if (formData.Keys.Contains("maDSP") && !string.IsNullOrEmpty(Convert.ToString(formData["maDSP"]))) 
                { 
                    maDSP = int.Parse(formData["maDSP"].ToString()); 
                }

                int? minGia = null;
                if (formData.Keys.Contains("minGia") && !string.IsNullOrEmpty(Convert.ToString(formData["minGia"]))) 
                { 
                    minGia = int.Parse(formData["minGia"].ToString()); 
                }

                int? maxGia = null;
                if (formData.Keys.Contains("maxGia") && !string.IsNullOrEmpty(Convert.ToString(formData["maxGia"]))) 
                { 
                    maxGia = int.Parse(formData["maxGia"].ToString()); 
                }

                string? chongNuoc = "";
                if (formData.Keys.Contains("chongNuoc") && !string.IsNullOrEmpty(Convert.ToString(formData["chongNuoc"])))
                {
                    chongNuoc = Convert.ToString(formData["chongNuoc"].ToString());
                }

                string kieuSX = "";
                if (formData.Keys.Contains("kieuSX") && !string.IsNullOrEmpty(Convert.ToString(formData["kieuSX"])))
                {
                    kieuSX = Convert.ToString(formData["kieuSX"].ToString());
                }

                long total = 0;
                var data = new List<SanPhamModel>();

                switch (kieuSX)
                {
                    case "1":
                        data = _sanphamBLL.GetByDSP(page, pageSize, maDSP, minGia, maxGia, chongNuoc, out total);
                        break;
                    case "2":
                        data = _sanphamBLL.FilterByPriceAsc(page, pageSize, maDSP, minGia, maxGia, chongNuoc, out total);
                        break;
                    case "3":
                        data = _sanphamBLL.FilterByPriceDesc(page, pageSize, maDSP, minGia, maxGia, chongNuoc, out total);
                        break;
                    default:
                        data = _sanphamBLL.GetByDSP(page, pageSize, maDSP, minGia, maxGia, chongNuoc, out total);
                        break;
                }

                var response = new
                {
                    success = true,
                    message = "Lấy dữ liệu thành công",
                    totalItems = total,
                    page = page,
                    pageSize = pageSize,
                    maDSP = maDSP,
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
                var result = _sanphamBLL.GetOne(id);
                if (result != null)
                {
                    return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
                }
                else
                {
                    // Trả về thông báo lỗi
                    return Ok(new { success = false, message = "Sản phẩm hiện không khả dụng!" });
                }
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
                string TenSP = "";
                if (formData.Keys.Contains("tenSP") && !string.IsNullOrEmpty(Convert.ToString(formData["tenSP"]))) { TenSP = Convert.ToString(formData["tenSP"]); }

                long total = 0;
                var data = _sanphamBLL.GetAllAdmin(page, pageSize, TenSP, out total);

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

        [Route("get-one-admin/{id}")]
        [HttpGet]
        public IActionResult GetOneAdmin(int id)
        {
            try
            {
                var result = _sanphamBLL.GetOneAdmin(id);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Route("get-without-price")]
        [HttpPost]
        public IActionResult GetWithoutPrice([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string TenSP = "";
                if (formData.Keys.Contains("tenSP") && !string.IsNullOrEmpty(Convert.ToString(formData["tenSP"]))) { TenSP = Convert.ToString(formData["tenSP"]); }

                long total = 0;
                var data = _sanphamBLL.GetWithoutPrice(page, pageSize, TenSP, out total);

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
        public IActionResult Create([FromForm] SanPhamModel model)
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

                    // Tạo đối tượng sanpham mới với các thông tin
                    var sanpham = new SanPhamModel
                    {
                        TenSP = model.TenSP,
                        AnhDaiDien = System.IO.File.ReadAllBytes(filePath), // Chuyển đổi tệp ảnh thành mảng byte, // Đường dẫn tương đối của ảnh
                        KichThuoc = model.KichThuoc,
                        TrongLuong = model.TrongLuong,
                        MatKinh = model.MatKinh,
                        ChatLieuDay = model.ChatLieuDay,
                        ChongNuoc = model.ChongNuoc,
                        LoaiMay = model.LoaiMay,
                        MoTa = model.MoTa,
                        TrangThai = model.TrangThai,
                        MaDSP = model.MaDSP
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

                    _sanphamBLL.Create(sanpham);

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
        public IActionResult Update([FromForm] SanPhamModel model)
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

                _sanphamBLL.Update(model);

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
                var sanpham = _sanphamBLL.GetOneAdmin(id);

                if (sanpham == null)
                {
                    return NotFound(new { success = false, message = "Sản phẩm không tồn tại" });
                }

                // Xoá từ cơ sở dữ liệu
                bool result = _sanphamBLL.Delete(id);

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
