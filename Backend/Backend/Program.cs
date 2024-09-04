using DAL.Helper.Interfaces;
using DAL.Helper;
using DAL.Interfaces;
using DAL;
using BLL.Interfaces;
using BLL;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using OfficeOpenXml;
using Model;

var builder = WebApplication.CreateBuilder(args);
builder.WebHost.UseUrls("https://localhost:44301");
//builder.WebHost.UseUrls("http://103.67.163.158:44301");

//***************************xử lý token****************************************
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

// configure strongly typed settings objects
var appSettingsSection = builder.Configuration.GetSection("AppSettings");
builder.Services.Configure<IAppSettings>(appSettingsSection);
// configure jwt authentication
var appSettings = appSettingsSection.Get<IAppSettings>();
var key = Encoding.ASCII.GetBytes(appSettings.Secret);
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false
    };
});
//***************************************************************************************

//dky, sd dich vu
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();
builder.Services.AddTransient<IMenuDAL, MenuDAL>();
builder.Services.AddTransient<IMenuBLL, MenuBLL>();

builder.Services.AddTransient<ISlideDAL, SlideDAL>();
builder.Services.AddTransient<ISlideBLL, SlideBLL>();

builder.Services.AddTransient<IBannerDAL, BannerDAL>();
builder.Services.AddTransient<IBannerBLL, BannerBLL>();

builder.Services.AddTransient<IGioiThieuDAL, GioiThieuDAL>();
builder.Services.AddTransient<IGioiThieuBLL, GioiThieuBLL>();

builder.Services.AddTransient<ILienHeDAL, LienHeDAL>();
builder.Services.AddTransient<ILienHeBLL, LienHeBLL>();

builder.Services.AddTransient<INhaCungCapDAL, NhaCungCapDAL>();
builder.Services.AddTransient<INhaCungCapBLL, NhaCungCapBLL>();

builder.Services.AddTransient<IDongSanPhamDAL, DongSanPhamDAL>();
builder.Services.AddTransient<IDongSanPhamBLL, DongSanPhamBLL>();

builder.Services.AddTransient<ISanPhamDAL, SanPhamDAL>();
builder.Services.AddTransient<ISanPhamBLL, SanPhamBLL>();

builder.Services.AddTransient<IGiaSanPhamDAL, GiaSanPhamDAL>();
builder.Services.AddTransient<IGiaSanPhamBLL, GiaSanPhamBLL>();

builder.Services.AddTransient<IQuyenDAL, QuyenDAL>();
builder.Services.AddTransient<IQuyenBLL, QuyenBLL>();

builder.Services.AddTransient<INguoiDungDAL, NguoiDungDAL>();
builder.Services.AddTransient<INguoiDungBLL, NguoiDungBLL>();

builder.Services.AddTransient<ITinTucDAL, TinTucDAL>();
builder.Services.AddTransient<ITinTucBLL, TinTucBLL>();

builder.Services.AddTransient<IHoaDonNhapDAL, HoaDonNhapDAL>();
builder.Services.AddTransient<IHoaDonNhapBLL, HoaDonNhapBLL>();

builder.Services.AddTransient<IDonHangDAL, DonHangDAL>();
builder.Services.AddTransient<IDonHangBLL, DonHangBLL>();

builder.Services.AddTransient<IThongKeDAL, ThongKeDAL>();
builder.Services.AddTransient<IThongKeBLL, ThongKeBLL>();

builder.Services.AddTransient<ISettingDAL, SettingDAL>();
builder.Services.AddTransient<ISettingBLL, SettingBLL>();

builder.Services.AddTransient<ISendEmailDAL, SendEmailDAL>();
builder.Services.AddTransient<ISendEmailBLL, SendEmailBLL>();

builder.Services.AddTransient<IVnPayDAL, VnPayDAL>();
builder.Services.AddTransient<IVnPayBLL, VnPayBLL>();

//Cấu hình execl
ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

//Cấu hình mail
builder.Services.Configure<SendEmailModel>(builder.Configuration.GetSection("MailSettings"));

//Cấu hình VnPay
builder.Services.AddHttpContextAccessor();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//---------------------------------------------------
app.UseRouting(); // cau hinh dinh tuyen
app.UseCors(x => x
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
app.UseAuthentication();
app.UseAuthorization();
//---------------------------------------------------

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
