using BLL;
using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;
using Mysqlx.Crud;
using MySqlX.XDevAPI.Common;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.IO;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DonHangController : ControllerBase
    {
        private IDonHangBLL _donhangBLL;
        private ISettingBLL _settingBLL;
        private ISendEmailBLL _sendEmailBLL;

        public DonHangController(IDonHangBLL donhangBLL, ISettingBLL settingBLL, ISendEmailBLL sendEmailBLL)
        {
            _donhangBLL = donhangBLL;
            _settingBLL = settingBLL;
            _sendEmailBLL = sendEmailBLL;
        }

        [Authorize(Roles = "1, 2")] //xác thực
        [Route("get-all-admin")]
        [HttpPost]
        public IActionResult GetAllAdmin([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                string TenKH = "";
                if (formData.Keys.Contains("tenKH") && !string.IsNullOrEmpty(Convert.ToString(formData["tenKH"]))) { TenKH = Convert.ToString(formData["tenKH"]); }

                long total = 0;
                var data = _donhangBLL.GetAllAdmin(page, pageSize, TenKH, out total);

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

        [Authorize] //xác thực
        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromBody] DonHangModel model)
        {
            try
            {
                _donhangBLL.Create(model);
                return Ok(new { success = true, message = "Đặt hàng thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Authorize] //xác thực
        [Route("get-one-new")]
        [HttpGet]
        public IActionResult GetOneNew()
        {
            try
            {
                var result = _donhangBLL.GetOneNew();
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }


        [Authorize] //xác thực
        [Route("check")]
        [HttpPut]
        public IActionResult Check([FromBody] DonHangModel model)
        {
            try
            {
                _donhangBLL.Check(model);
                return Ok(new { success = true, message = "Đã duyệt đơn" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Authorize] //xác thực
        [Route("get-by-order/{madh}")]
        [HttpGet]
        public IActionResult GetByDH(int maDH)
        {
            try
            {
                var result = _donhangBLL.GetByDH(maDH);
                return Ok(new { success = true, message = "Lấy dữ liệu thành công", data = result });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Authorize] //xác thực
        [Route("get-purchase-history")]
        [HttpPost]
        public IActionResult GetPurchaseHistory([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());

                int? maND = null;
                if (formData.Keys.Contains("maND") && !string.IsNullOrEmpty(Convert.ToString(formData["maND"])))
                {
                    maND = int.Parse(formData["maND"].ToString());
                }

                long total = 0;
                var data = _donhangBLL.GetPurchaseHistory(page, pageSize, maND, out total);

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


        [Authorize(Roles = "1, 2")] //xác thực
        [Route("export-to-excel/{id}")]
        [HttpGet]
        public IActionResult ExportToExcel(int id)
        {
            try
            {
                // Lấy thông tin đơn hàng và chi tiết đơn hàng từ BLL
                var donHang = _donhangBLL.GetOne(id);
                var chiTietDonHang = _donhangBLL.GetByDH(id);
                var nameWebsite = _settingBLL.GetBySign("NAME_WEB");
                var addressWebsite = _settingBLL.GetBySign("ADDRESS");
                var phoneWebsite = _settingBLL.GetBySign("PHONE");

                using (var package = new ExcelPackage())
                {
                    // Tạo một trang tính mới
                    var worksheet = package.Workbook.Worksheets.Add("Hóa đơn bán hàng");
                    // Font chữ: Arial
                    worksheet.Cells.Style.Font.Name = "Arial";
                    // Gộp cột
                    worksheet.Cells["A1:D1"].Merge = true;
                    worksheet.Cells["A4:D4"].Merge = true;
                    worksheet.Cells["A6:G6"].Merge = true;
                    worksheet.Cells["A7:G7"].Merge = true;
                    worksheet.Cells["A8:G8"].Merge = true;
                    worksheet.Cells["A9:G9"].Merge = true;
                    worksheet.Cells["A10:G10"].Merge = true;
                    worksheet.Cells["E1:G1"].Merge = true;
                    worksheet.Cells["E2:G2"].Merge = true;
                    // Hàng 1:
                    worksheet.Row(1).Height = 50;
                    worksheet.Cells["A1:G1"].Style.Font.Bold = true;
                    worksheet.Cells["A1:G1"].Style.Font.Size = 18;
                    worksheet.Cells["A1:G1"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    worksheet.Cells["A1:G1"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    //Hàng 2, 3:
                    worksheet.Cells["A2:G3"].Style.Font.Bold = true;
                    worksheet.Cells["A2:D3"].Merge = true;
                    worksheet.Cells["A2:C3"].Style.WrapText = true;
                    worksheet.Cells["A2:C3"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    worksheet.Cells["A2:C3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells["E2:G3"].Merge = true;
                    worksheet.Cells["E2:G3"].Style.VerticalAlignment = ExcelVerticalAlignment.Top;
                    worksheet.Cells["E2:G3"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    //Hàng 4:
                    worksheet.Cells["A4:C4"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells["A4:C4"].Style.Font.Bold = true;
                    //Hàng 10:
                    //worksheet.Cells["A10:G10"].Merge = true;
                    worksheet.Cells["A10"].Style.VerticalAlignment = ExcelVerticalAlignment.Top;
                    worksheet.Cells["A10"].Style.WrapText = true;
                    worksheet.Row(10).Height = 40;
                    //Hàng 12:
                    worksheet.Cells["A12:G12"].Style.Font.Bold = true;
                    worksheet.Cells["A12:G12"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells["B12:D12"].Merge = true;
                    // Thiết lập border cho hàng 12
                    for (int col = 1; col <= 7; col++)
                    {
                        var cell = worksheet.Cells[12, col];
                        var border = cell.Style.Border;
                        border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;
                        cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    }



                    // Thêm thông tin cửa hàng và hoá đơn vào các ô
                    worksheet.Cells["A1"].Value = nameWebsite.MoTa;
                    worksheet.Cells["A2"].Value = "Đ/C: " + addressWebsite.MoTa;
                    worksheet.Cells["A4"].Value = "ĐT: " + phoneWebsite.MoTa;
                    worksheet.Cells["A6"].Value = "Tên khách hàng: " + donHang.TenKH;
                    worksheet.Cells["A7"].Value = "Địa chỉ: " + donHang.DiaChiGiaoHang;
                    worksheet.Cells["A8"].Value = "Điện thoại: " + donHang.SDT;
                    worksheet.Cells["A9"].Value = "Phương thức thanh toán: " + donHang.PhuongThucThanhToan;
                    worksheet.Cells["A10"].Value = "Ghi chú: " + donHang.GhiChu;
                    worksheet.Cells["A10"].Style.WrapText = true;
                    // Tăng chiều cao của hàng tự động để phù hợp với nội dung
                    worksheet.Cells.AutoFitColumns();

                    worksheet.Cells["E1"].Value = "Hóa đơn bán hàng";
                    worksheet.Cells["E2"].Value = "Mặt hàng bán (Đồng hồ Casio)";

                    worksheet.Cells["A12"].Value = "STT";
                    worksheet.Cells["B12"].Value = "Tên sản phẩm";
                    worksheet.Cells["E12"].Value = "Số lượng";
                    worksheet.Cells["F12"].Value = "Đơn giá";
                    worksheet.Cells["G12"].Value = "Thành tiền";

                    // Duyệt qua danh sách chi tiết đơn hàng và ghi dữ liệu vào worksheet
                    int rowIndex = 13; // Bắt đầu từ hàng thứ 13
                    // Tính tổng số lượng
                    int totalQuantity = 0;
                    //Tính thành tiền
                    long totalPrice = 0;
                    foreach (var item in chiTietDonHang)
                    {
                        worksheet.Cells[rowIndex, 1].Value = rowIndex - 12;
                        worksheet.Cells[rowIndex, 2].Value = item.TenSP;
                        worksheet.Cells[rowIndex, 5].Value = item.SoLuong;
                        worksheet.Cells[rowIndex, 6].Value = item.GiaBan.ToString("#,##0") + " VNĐ";
                        worksheet.Cells[rowIndex, 7].Value = (item.SoLuong * item.GiaBan).ToString("#,##0") + " VNĐ";

                        totalQuantity += item.SoLuong;
                        totalPrice += item.SoLuong * item.GiaBan;


                        // Merge cột B tới D
                        worksheet.Cells[rowIndex, 2, rowIndex, 4].Merge = true;

                        // Đặt border cho các ô trong dữ liệu
                        for (int col = 1; col <= 7; col++)
                        {
                            var cell = worksheet.Cells[rowIndex, col];
                            var border = cell.Style.Border;
                            //Border đậm cho các hàng, cột
                            border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;
                            // Căn giữa dữ liệu trong từng ô
                            cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        }

                        rowIndex++;
                    }

                    // Thiết lập border cho hàng cuối cùng
                    for (int col = 1; col <= 7; col++)
                    {
                        var cell = worksheet.Cells[rowIndex, col];
                        var border = cell.Style.Border;
                        border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;
                        cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    }
                    // Merge cột B tới D
                    worksheet.Cells[rowIndex, 1, rowIndex, 4].Merge = true;

                    // Đặt giá trị cho ô "Tổng cộng" sau khi đã lặp qua danh sách chi tiết đơn hàng
                    worksheet.Cells["A" + rowIndex].Value = "Tổng cộng";
                    worksheet.Cells["A" + rowIndex + ":D" + rowIndex].Merge = true; // Gộp ô từ A đến D tại hàng cuối cùng
                    worksheet.Cells["A" + rowIndex].Style.Font.Bold = true;
                    worksheet.Cells["A" + rowIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    // Đổ dữ liệu tính tổng số lượng
                    worksheet.Cells["E" + rowIndex].Value = totalQuantity;
                    // Đổ dữ liệu tổng thành tiền vào ô cuối cùng của hàng cuối cùng
                    worksheet.Cells["G" + rowIndex].Value = totalPrice.ToString("#,##0") + " VNĐ";

                    //Ký tên cho khách hàng
                    int customerRow = rowIndex + 3;
                    // Điền chữ khách hàng vào cột B
                    worksheet.Cells["C" + customerRow].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells["C" + customerRow].Value = "KHÁCH HÀNG";
                    worksheet.Cells["C" + customerRow].Style.Font.Bold = true;

                    //Ngày tháng năm xuất
                    int dateRow = rowIndex + 2;
                    // Lấy ngày tháng năm hiện tại
                    DateTime currentDate = DateTime.Now;
                    // Định dạng chuỗi ngày tháng năm
                    string formattedDate = "Ngày " + currentDate.Day.ToString() + " tháng " + currentDate.Month.ToString() + " năm " + currentDate.Year.ToString();
                    // Gộp cột từ E đến G tại hàng dateRow
                    worksheet.Cells[dateRow, 5, dateRow, 7].Merge = true;
                    worksheet.Cells[dateRow, 5, dateRow, 7].Style.Font.Italic = true;
                    worksheet.Cells[dateRow, 5, dateRow, 7].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells[dateRow, 5, dateRow, 7].Value = formattedDate;

                    //Ký tên cho nhân viên
                    int staffRow = dateRow + 1;
                    // Điền chữ nhân viên vào cột E
                    worksheet.Cells[staffRow, 5, staffRow, 7].Merge = true;
                    worksheet.Cells[staffRow, 5, staffRow, 7].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells["E" + staffRow].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells["E" + staffRow].Value = "NHÂN VIÊN";
                    worksheet.Cells["E" + staffRow].Style.Font.Bold = true;


                    // Tự động điều chỉnh chiều rộng của các cột
                    worksheet.Cells.AutoFitColumns();


                    // Chuyển đổi package Excel thành một mảng byte
                    var fileBytes = package.GetAsByteArray();
                    return File(fileBytes, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "donhang.xlsx");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        [Authorize]
        [Route("send-order-email")]
        [HttpPost]
        public IActionResult SendOrderEmail([FromBody] DonHangModel model)
        {
            try
            {
                var nameWebsite = _settingBLL.GetBySign("NAME_WEB");
                var donHang = _donhangBLL.GetOne(model.MaDH);

                var chiTietDonHang = _donhangBLL.GetByDH(model.MaDH).Select(chitiet => new CTDonHangModel
                {
                    TenSP = chitiet.TenSP,
                    SoLuong = chitiet.SoLuong,
                    GiaBan = chitiet.GiaBan
                }).ToList();

                _sendEmailBLL.SendOrderEmail(nameWebsite.MoTa, model.Email, donHang.TenKH, donHang.TongTien, donHang.DiaChiGiaoHang, donHang.SDT, donHang.NgayDat, donHang.MaDH, chiTietDonHang);
                return Ok(new { success = true, message = "Thông tin đơn hàng đã được gửi đến email của bạn" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
