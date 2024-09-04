CREATE DATABASE WebVPC;
USE WebVPC;
CREATE TABLE Menu
(
	MaMenu INT AUTO_INCREMENT PRIMARY KEY,
	TenMenu VARCHAR(100),
	Link TEXT,
    TrangThai TINYINT
);
CREATE TABLE Slide
(
	MaSlide INT AUTO_INCREMENT PRIMARY KEY,
	Anh LONGBLOB,
    TrangThai TINYINT
);
CREATE TABLE Banner (
	MaBanner INT AUTO_INCREMENT PRIMARY KEY,
    Anh LONGBLOB,
    Link TEXT,
    TrangThai TINYINT
);
CREATE TABLE GioiThieu
(
	MaGT INT AUTO_INCREMENT PRIMARY KEY,
	TieuDe VARCHAR(100),
    NoiDung TEXT,
    MaMenu INT,
    FOREIGN KEY (MaMenu) REFERENCES Menu(MaMenu) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE LienHe
(
	MaLH INT AUTO_INCREMENT PRIMARY KEY,
    TieuDe VARCHAR(100),
    GoogleMap TEXT,
    NoiDung TEXT,
    MaMenu INT,
    FOREIGN KEY (MaMenu) REFERENCES Menu(MaMenu) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE NhaCungCap
(
	MaNCC INT AUTO_INCREMENT PRIMARY KEY,
	TenNCC VARCHAR(100),
	DiaChi VARCHAR(255),
	SDT VARCHAR(10),
    TrangThai TINYINT
);
CREATE TABLE DongSanPham (
    MaDSP INT AUTO_INCREMENT PRIMARY KEY,
    TenDSP VARCHAR(100),
    Logo LONGBLOB,
    TrangThai TINYINT
);
CREATE TABLE SanPham (
    MaSP INT AUTO_INCREMENT PRIMARY KEY,
    TenSP VARCHAR(100) NOT NULL, --
    AnhDaiDien LONGBLOB,
    SoLuong INT, --
    KichThuoc VARCHAR(100), --
    TrongLuong VARCHAR(100), --
    MatKinh VARCHAR(100),--
    ChatLieuDay VARCHAR(100),--
    ChongNuoc VARCHAR(100),--
    LoaiMay VARCHAR(100),--
    MoTa TEXT,
    NgayTao DATETIME,
    TrangThai TINYINT,
    MaDSP INT,
    FOREIGN KEY (MaDSP) REFERENCES DongSanPham(MaDSP) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE GiaSanPham (
	MaGSP INT AUTO_INCREMENT PRIMARY KEY,
    GiaBan INT,
    PhanTramGiamGia INT,
	NgayBD DATETIME,
	NgayKT DATETIME,
	MaSP INT,
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE Quyen (
	MaQuyen INT AUTO_INCREMENT PRIMARY KEY,
    TenQuyen VARCHAR(100),
    TrangThai TINYINT
);
CREATE TABLE NguoiDung (
    MaND INT AUTO_INCREMENT PRIMARY KEY,
    TaiKhoan VARCHAR(100),
    MatKhau VARCHAR(255),
    Email VARCHAR(100),
    HoTen VARCHAR(100),
    NgaySinh DATETIME,
    GioiTinh VARCHAR(100),
    AnhDaiDien LONGBLOB,
    DiaChi VARCHAR(255),
    SDT VARCHAR(10),
    NgayThamGia DATETIME,
    TrangThai TINYINT,
    MaQuyen INT,
    FOREIGN KEY (MaQuyen) REFERENCES Quyen(MaQuyen) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE TinTuc (
    MaTT INT AUTO_INCREMENT PRIMARY KEY,
    AnhDaiDien LONGBLOB,
    TieuDe VARCHAR(200),
    NgayDang DATETIME,
    NoiDung TEXT,
    TrangThai TINYINT,
    MaND INT,
    MaMenu INT,
    FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (MaMenu) REFERENCES Menu(MaMenu) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE HoaDonNhap(
    MaHDN INT AUTO_INCREMENT PRIMARY KEY,
    NgayNhap DATETIME,
    TrangThai TINYINT,
    MaND INT,
    MaNCC INT,
    FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE CTHoaDonNhap(
    MaCTHDN INT AUTO_INCREMENT PRIMARY KEY,
    SoLuong INT,
    GiaNhap INT,
    MaSP INT,
    MaHDN INT,
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (MaHDN) REFERENCES HoaDonNhap(MaHDN) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE DonHang(
    MaDH INT AUTO_INCREMENT PRIMARY KEY,
    TenKH VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
	DiaChiGiaoHang VARCHAR(255) NOT NULL,
	SDT VARCHAR(10),
    GhiChu TEXT,
    NgayDat DATETIME,
    PhuongThucThanhToan VARCHAR(100),
    TrangThai TINYINT,
	MaND INT,
    FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- ALTER TABLE DonHang ADD 
CREATE TABLE CTDonHang(
    MaCTDH INT AUTO_INCREMENT PRIMARY KEY,
    SoLuong INT,
    GiaBan INT,
    MaSP INT,
    MaDH INT,
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (MaDH) REFERENCES DonHang(MaDH) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE Setting(
	MaSetting INT AUTO_INCREMENT PRIMARY KEY,
    TenSetting VARCHAR(100),
    KyHieu VARCHAR(20),
    Anh LONGBLOB,
    MoTa TEXT
);
-- --------------------------------- 17 bảng -------------------------------------------------------
-- Menu Slide Banner GioiThieu LienHe NhaCungCap DongSanPham SanPham GiaSanPham 
-- Quyen NguoiDung TinTuc HoaDonNhap CTHoaDonNhap DonHang CTDonHang Setting
-- USE WebVPC;
-- Menu 4
INSERT INTO Menu(MaMenu, TenMenu, Link, TrangThai) VALUES (NULL, 'Trang chủ', '/', 1);
INSERT INTO Menu(MaMenu, TenMenu, Link, TrangThai) VALUES (NULL, 'Giới thiệu', '/gioi-thieu', 1);
INSERT INTO Menu(MaMenu, TenMenu, Link, TrangThai) VALUES (NULL, 'Tin tức', '/tin-tuc', 1);
INSERT INTO Menu(MaMenu, TenMenu, Link, TrangThai) VALUES (NULL, 'Liên hệ', '/lien-he', 1);
-- Slide 6
INSERT INTO Slide(MaSlide, TrangThai) VALUES (NULL, 1);
INSERT INTO Slide(MaSlide, TrangThai) VALUES (NULL, 1);
INSERT INTO Slide(MaSlide, TrangThai) VALUES (NULL, 1);
INSERT INTO Slide(MaSlide, TrangThai) VALUES (NULL, 1);
INSERT INTO Slide(MaSlide, TrangThai) VALUES (NULL, 1);
INSERT INTO Slide(MaSlide, TrangThai) VALUES (NULL, 1);
-- Banner 4
INSERT INTO Banner(MaBanner, Link, TrangThai) VALUES (NULL, '/dong-san-pham/1', 1);
INSERT INTO Banner(MaBanner, Link, TrangThai) VALUES (NULL, '/dong-san-pham/2', 1);
INSERT INTO Banner(MaBanner, Link, TrangThai) VALUES (NULL, '/dong-san-pham/4', 1);
INSERT INTO Banner(MaBanner, Link, TrangThai) VALUES (NULL, '/dong-san-pham/3', 1);
-- GioiThieu
INSERT INTO GioiThieu(MaGT, TieuDe, MaMenu) VALUES (NULL, 'Giới thiệu', 2);
-- LienHe
INSERT INTO LienHe(MaLH, TieuDe, GoogleMap, MaMenu) VALUES (NULL, 'Liên hệ','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3726.109026772203!2d106.32074867460736!3d20.948136340756946!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31359b42ee5f01ff%3A0x21d9f58a24f3a4bc!2zTmfDtSA0NDEgxJBp4buHbiBCacOqbiBQaOG7pywgQsOsbmggSMOgbiwgSOG6o2kgRMawxqFuZywgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1714060457380!5m2!1svi!2s', 4);
-- NhaCungCap 10
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Phạm Quang Hải', 'Hà Nội', '0354472583', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Nguyễn Việt Trung', 'TP Hồ Chí Minh', '0354473456', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Lê Việt Thái', 'Đà Nẵng', '0357872587', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Đỗ Văn Huy', 'Hà Nội', '0354472562', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Hoàng Ngọc Hà', 'TP Hồ Chí Minh', '0354473412', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Lê Viết Duy', 'Hà Nội', '0354472583', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Đỗ Thị Trang', 'TP Hồ Chí Minh', '0354473456', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Phạm Thị Nhàn', 'Đà Nẵng', '0357872587', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Nguyễn Huy Đức', 'Hà Nội', '0354472562', 1);
INSERT INTO NhaCungCap(MaNCC, TenNCC, DiaChi, SDT, TrangThai) VALUES(NULL, 'Bùi Quang Việt', 'TP Hồ Chí Minh', '0354473412', 1);
-- DongSanPham 6
INSERT INTO DongSanPham(MaDSP, TenDSP, TrangThai) VALUES(NULL, 'G-Shock', 1);
INSERT INTO DongSanPham(MaDSP, TenDSP, TrangThai) VALUES(NULL, 'Baby-G', 1);
INSERT INTO DongSanPham(MaDSP, TenDSP, TrangThai) VALUES(NULL, 'Edifice', 1);
INSERT INTO DongSanPham(MaDSP, TenDSP, TrangThai) VALUES(NULL, 'Sheen', 1);
INSERT INTO DongSanPham(MaDSP, TenDSP, TrangThai) VALUES(NULL, 'General', 1);
INSERT INTO DongSanPham(MaDSP, TenDSP, TrangThai) VALUES(NULL, 'Pro Trek', 1);
-- SanPham 120
-- G-SHOCK-20
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP) 
VALUES(NULL,'GM-2140GEM-2ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu G-SHOCK Adventurer’s Stone mới này sử dụng các họa tiết của đá khoáng chất, làm điểm đánh dấu dẫn đường từ thời trung cổ.
Mỗi thiết kế đều kết hợp tinh thần của G-SHOCK, nhằm hỗ trợ và hướng dẫn cho những người thích mạo hiểm và các nhà thám hiểm trên toàn thế giới. Dựa trên các mẫu được phủ kim loại, những chiếc đồng hồ mới này sử dụng kỹ thuật rèn và mạ ion tiên tiến (IP) để tạo ra các thiết kế tái tạo kết cấu thô và độ sáng nhiều màu của khoáng quặng.
Kết quả là một bộ sưu tập các mẫu đặc biệt nắm bắt được tinh thần của quá khứ và những thách thức trong tương lai, thành một phiên bản kỷ niệm ý nghĩa
Các bezels phủ kim loại được tạo ra bằng cách rèn đặc biệt và đúc bằng khuôn đặc biệt. Toàn bộ bề mặt của tất cả các bezels có bề mặt gồ ghề giống như quặng khoáng sản. Nhưng vẫn được mãi dũa để có lớp hoàn thiện bóng loáng, mặt trên và các mặt của khung bezel được đánh bóng hoàn hảo sáng bóng đến từng chi tiết nhỏ nhất. 
Thành phẩm tạo ra từ quy trình sử dụng công nghệ gia công kim loại tái tạo trung thực hình thức, kết cấu, và độ sáng chói của từng loại quặng khoáng sản.
Nắp sau của các mẫu này được khắc chữ G-SHOCK
Logo kỷ niệm 40 năm. Vòng dây cho GM-2140GEM, GM5640GEM và GM-114GEM là khắc laser với bốn ngôi sao và các chữ TỪ 1983.
Hộp thiết kế đặc biệt theo kiểu chữ cái G, vật liệu thân thiện với môi trường tái chế vật liệu.'
, '2024-01-01 00:00:00', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'GM-114GEM-1A9DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu G-SHOCK Adventurer’s Stone mới này sử dụng các họa tiết của đá khoáng chất, làm điểm đánh dấu dẫn đường từ thời trung cổ.
Mỗi thiết kế đều kết hợp tinh thần của G-SHOCK, nhằm hỗ trợ và hướng dẫn cho những người thích mạo hiểm và các nhà thám hiểm trên toàn thế giới. Dựa trên các mẫu được phủ kim loại, những chiếc đồng hồ mới này sử dụng kỹ thuật rèn và mạ ion tiên tiến (IP) để tạo ra các thiết kế tái tạo kết cấu thô và độ sáng nhiều màu của khoáng quặng.
Kết quả là một bộ sưu tập các mẫu đặc biệt nắm bắt được tinh thần của quá khứ và những thách thức trong tương lai, thành một phiên bản kỷ niệm ý nghĩa
Các bezels phủ kim loại được tạo ra bằng cách rèn đặc biệt và đúc bằng khuôn đặc biệt. Toàn bộ bề mặt của tất cả các bezels có bề mặt gồ ghề giống như quặng khoáng sản. Nhưng vẫn được mãi dũa để có lớp hoàn thiện bóng loáng, mặt trên và các mặt của khung bezel được đánh bóng hoàn hảo sáng bóng đến từng chi tiết nhỏ nhất. 
Thành phẩm tạo ra từ quy trình sử dụng công nghệ gia công kim loại tái tạo trung thực hình thức, kết cấu, và độ sáng chói của từng loại quặng khoáng sản.
Nắp sau của các mẫu này được khắc chữ G-SHOCK
Logo kỷ niệm 40 năm. Vòng dây cho GM-2140GEM, GM-5640GEM và GM-114GEM là khắc laser với bốn ngôi sao và các chữ TỪ 1983.
Hộp thiết kế đặc biệt theo kiểu chữ cái G, vật liệu thân thiện với môi trường tái chế vật liệu.'
, '2024-01-01 00:00:01', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'GG-B100Y-1ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Vỏ của mẫu GG-B100Y MUDMASTER được chế tạo bằng vật liệu cacbon có độ cứng cao có thể chịu được biến dạng và chống hư hỏng, ngoài ra còn có độ kín khí cao và chống va đập. Mẫu đồng hồ này còn được tích hợp bộ lọc để ngăn chặn bùn tràn vào bên trong vỏ, một bảng điều khiển phía sau bằng thép không gỉ và nắp lưng được làm bằng nhựa cao cấp pha sợi thủy tinh chống sốc. Vòng mặt số cũng được tạo hình từ ba lớp nhựa cao cấp pha sợi cacbon.
Đèn LED đôi: gồm 1 đèn LED dành cho mặt đồng hồ tự động và đèn nền LED chiếu sáng cực mạnh dành cho màn hình số. Cả 2 đen đều chiếu sáng cực mạnh, thời lượng chiếu sáng có thể chọn 1,5 giây hoặc 3 giây 
Chống nước độ sâu 200m ; Công cụ tìm điện thoại
Liên kết điện thoại thông minh (Kết nối không dây với thiết bị Bluetooth).  Yêu cầu cài đặt ứng dụng trên điện thoại của bạn.
Hiển thị giờ mặt trời mọc, mặt trời lặn Giờ mặt trời mọc và mặt trời lặn cho ngày cụ thể
5 chế độ báo thức hằng ngày và cập nhật lịch hoàn toàn tự động đến 2099 vô cùng tiện nghi khi sử dụng. Chức năng bấm giờ G7'
, '2024-01-01 00:00:02', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'GM-B2100GD-9ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu dòng đồng hồ G-SHOCK GM-B2100 kim điện tử kết hợp, với bộ vỏ kim loại nguyên khối hoàn toàn mới và được thừa hưởng nguyên bản ý tưởng thiết kế của mẫu đồng hồ G-SHOCK DW-5000C. Thép không gỉ được sử dụng làm ốc nắp lưng, vòng mặt số và dây, mang đến sự đơn giản, đồng thời loại bỏ những chi tiết thiết kế không hợp lý. GM-B2100GD giữ nguyên cấu trúc chống va đập nhằm bảo vệ bộ máy tránh khỏi những hư hỏng do va chạm.
Các chức năng được thừa hưởng từ mẫu đồng hồ nguyên bản DW-5000C từ năm 1983 bao gồm vòng mặt số bát giác và những lỗ nhỏ trên bề mặt dây đeo.
Vòng mặt số và dây của mẫu đồng hồ GM-B2100GD-9A được hoàn thiện bằng phương pháp phủ ion (IP) màu vàng kim.
Độ dày tổng thể đã được giảm đi nhờ vào việc ứng dụng công nghệ gắn kết mật độ cao để sản xuất bộ máy mỏng và hiệu suất cao. Từng chi tiết được cải tiến nhằm mang đến sự thoải mái khi đeo trên cổ tay.
Vòng mặt số bằng thép không gỉ, hình thành sau quá trình rèn, cắt đến đánh bóng cực kỳ tỉ mỉ. Bề mặt đồng hồ được hoàn thiện bằng phương pháp đánh bóng vân xoáy; trong khi đó, bề mặt của các góc cạnh lại được đánh bóng tráng gương. 
Cấu trúc chống sốc cho các bộ phận kim loại bên ngoài có được nhờ vào các bộ phận đệm bằng nhựa cao cấp nằm giữa vòng mặt số và vỏ. Mặt số được tạo hình tinh tế nhờ vào "công nghệ vi chế tạo" của Nhà máy CASIO Yamagata và hoàn thiện bề mặt một cách tinh xảo với "công nghệ phủ lắng đọng màng mỏng".
Bộ máy kim điện tử kết hợp có kích thước mỏng và hiệu suất cao có thể kết nối với điện thoại thông minh bằng Bluetooth để truy cập dữ liệu thời gian một cách chính xác.
Cùng một số tính năng hữu ích khác bao gồm pin mặt trời, đèn LED siêu sáng.'
, '2024-01-01 00:00:03', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GMA-S2100GA-3ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ bộ sưu tập đồng hồ kim - điện tử kết hợp và nhỏ gọn GMA-S2100, trân trọng giới thiệu một số mẫu đồng hồ mới sử dụng màu xanh lá làm điểm nhấn nổi bật. Mặt số phẳng kết hợp với vạch chỉ giờ đơn giản mang đến vẻ đẹp tối giản cho mẫu đồng hồ. Màu xanh lá đang là xu hướng được sử dụng cho logo, vạch chỉ giờ, LCD và một số chi tiết khác giúp cho mẫu đồng hồ đời thường trở nên thật phong cách khi kết hợp với thời trang đường phố hiện nay.'
, '2024-01-01 00:00:04', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GMA-S2100GA-1ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ bộ sưu tập đồng hồ kim - điện tử kết hợp và nhỏ gọn GMA-S2100, trân trọng giới thiệu một số mẫu đồng hồ mới sử dụng màu xanh lá làm điểm nhấn nổi bật. Mặt số phẳng kết hợp với vạch chỉ giờ đơn giản mang đến vẻ đẹp tối giản cho mẫu đồng hồ. Màu xanh lá đang là xu hướng được sử dụng cho logo, vạch chỉ giờ, LCD và một số chi tiết khác giúp cho mẫu đồng hồ đời thường trở nên thật phong cách khi kết hợp với thời trang đường phố hiện nay.'
, '2024-01-01 00:00:05', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GMA-S120TB-8ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ bộ sưu tập đồng hồ kim điện tử nhỏ gọn GMA-S110 và GMA-S120, trân trọng giới thiệu bộ sưu tập mới với sắc xanh dương làm điểm nhấn. Dây và vỏ làm từ nhựa bán trong suốt màu xám, kết hợp với mặt đồng hồ màu xanh thời thượng, tạo nên một mẫu đồng hồ đời thường và đa phong cách. Đây là sự kết hợp hoàn hảo với phong cách thời trang đường phố.'
, '2024-01-01 00:00:06', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GMA-S110TB-8ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ bộ sưu tập đồng hồ kim điện tử nhỏ gọn GMA-S110 và GMA-S120, trân trọng giới thiệu bộ sưu tập mới với sắc xanh dương làm điểm nhấn. Dây và vỏ làm từ nhựa bán trong suốt màu xám, kết hợp với mặt đồng hồ màu xanh thời thượng, tạo nên một mẫu đồng hồ đời thường và đa phong cách. Đây là sự kết hợp hoàn hảo với phong cách thời trang đường phố.'
, '2024-01-01 00:00:07', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GBX-100TT-8', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'GBX-100TT có tính năng kết nối điện thoại. Ứng dụng trên điện thoại thông minh có thể sử dụng nhanh chóng, dễ dàng truy cập thông tin thủy triều, mặt trời mọc và thời gian hoàng hôn tại hơn 3.300 địa điểm trên toàn thế giới. Đây đều là những dữ liệu cần thiết cho người chơi lướt sóng. 
Màu sắc lấy cảm hứng từ môn lướt sóng kết hợp cùng ý tưởng về du hành thời gian – xuyên không giữa hiện tại và quá khứ. Hiện tại được thể hiện bằng nhiều màu sắc khác nhau, còn quá khứ là những màu đơn sắc (gam màu trắng đen),tạo ra hình ảnh của một chuyến đi lướt sóng từ quá khứ đến hiện tại.
Mặt đồng hồ kích thước lớn và MIP (Memory In Pixel) độ phân giải cao, sắc nét.
LCD nâng cấp khả năng đọc màn hình của các chức năng tiêu chuẩn như Biểu đồ thủy triều, hiển thị dữ liệu mặt trăng, thủy triều cao - thấp, thời gian mặt trời mọc - lặn. Điều này cung cấp thông tin quan trọng về các điều kiện hiện tại trong tích tắc.'
, '2024-01-01 00:00:08', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GBD-H2000-2DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu những sản phẩm mới nhất cho dòng đồng hồ thể thao G-SQUAD của G-SHOCK. 
Những mẫu đồng hồ thuộc dòng GBD-H2000 mới ra mắt được trang bị máy đo nhịp tim và khả năng kết nối GPS để hỗ trợ cho các hoạt động thể thao của nhiều môn thể thao khác nhau.
Các tính năng và chức năng được thiết kế để hỗ trợ, sao lưu việc tập luyện của bạn bằng bộ ba cảm biến: 
- Một cảm biến quang đo nhịp tim. 
- Một cảm biến gia tốc đếm số bước.
- Cảm biến con quay hồi chuyển (Nó là một thiết bị ứng dụng nguyên tắc bảo toàn mô men động lượng để đo đạc hoặc duy trì phương hướng. Có thể hiểu đơn giản, cảm biến con quay hồi chuyển là một bánh xe hay đĩa quay có trục quay tự do theo mọi hướng. Người ta dùng nó để đo vận tốc góc rất lớn của những vật trong không gian và qua đó phát hiện những thay đổi, để kịp thời điều chỉnh sự cân bằng của vật) để phát hiện kiểu bơi và hướng rẽ của bạn. 
Ngoài ra còn có điều hướng, độ cao/áp suất khí quyển, và cảm biến nhiệt độ. Mẫu đồng hồ này không chỉ hỗ trợ việc chạy bộ mà còn hỗ trợ cho nhiều môn thể thao khác như đạp xe hay bơi lội.
Khả năng GPS có thể sử dụng để đo khoảng cách, tốc độ, nhịp độ, và hơn thế nữa.
Bạn cũng có thể phân tích quá trình luyện tập và phục hồi của mình thông qua giấc ngủ bằng cách sử dụng thư viện Polar. 
Dây đeo và vòng mặt số sử dụng vật liệu nhựa sinh khối làm từ bắp, thân thiện với môi trường. Nhựa sinh khối là vật liệu polyme bao gồm các chất có nguồn gốc từ vật liệu hữu cơ tái tạo, thu được bằng cách tổng hợp hóa học hoặc sinh học các nguyên liệu thô.
Nhựa sinh khối giảm tải tác động xấu đến môi trường và giúp con người tiến gần hơn một "xã hội xanh".
Thiết kế thông minh với nắp lưng cong giúp ôm sát chuyển động của mu bàn tay, các nút bấm được cải thiện khả năng hoạt động và tinh thể lỏng MIP độ nét cao giúp cho màn hình hiển thị dễ đọc hơn.
Cả USB và sạc năng lượng mặt trời đều được hỗ trợ để đồng hồ hoạt động liên tục mà không bị gián đoạn.'
, '2024-01-01 00:00:09', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GBD-H2000-1BDR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu những sản phẩm mới nhất cho dòng đồng hồ thể thao G-SQUAD của G-SHOCK. 
Những mẫu đồng hồ thuộc dòng GBD-H2000 mới ra mắt được trang bị máy đo nhịp tim và khả năng kết nối GPS để hỗ trợ cho các hoạt động thể thao của nhiều môn thể thao khác nhau.
Các tính năng và chức năng được thiết kế để hỗ trợ, sao lưu việc tập luyện của bạn bằng bộ ba cảm biến: 
- Một cảm biến quang đo nhịp tim. 
- Một cảm biến gia tốc đếm số bước.
- Cảm biến con quay hồi chuyển (Nó là một thiết bị ứng dụng nguyên tắc bảo toàn mô men động lượng để đo đạc hoặc duy trì phương hướng. Có thể hiểu đơn giản, cảm biến con quay hồi chuyển là một bánh xe hay đĩa quay có trục quay tự do theo mọi hướng. Người ta dùng nó để đo vận tốc góc rất lớn của những vật trong không gian và qua đó phát hiện những thay đổi, để kịp thời điều chỉnh sự cân bằng của vật) để phát hiện kiểu bơi và hướng rẽ của bạn. 
Ngoài ra còn có điều hướng, độ cao/áp suất khí quyển, và cảm biến nhiệt độ. Mẫu đồng hồ này không chỉ hỗ trợ việc chạy bộ mà còn hỗ trợ cho nhiều môn thể thao khác như đạp xe hay bơi lội.
Khả năng GPS có thể sử dụng để đo khoảng cách, tốc độ, nhịp độ, và hơn thế nữa.
Bạn cũng có thể phân tích quá trình luyện tập và phục hồi của mình thông qua giấc ngủ bằng cách sử dụng thư viện Polar. 
Dây đeo và vòng mặt số sử dụng vật liệu nhựa sinh khối làm từ bắp, thân thiện với môi trường. Nhựa sinh khối là vật liệu polyme bao gồm các chất có nguồn gốc từ vật liệu hữu cơ tái tạo, thu được bằng cách tổng hợp hóa học hoặc sinh học các nguyên liệu thô.
Nhựa sinh khối giảm tải tác động xấu đến môi trường và giúp con người tiến gần hơn một "xã hội xanh".
Thiết kế thông minh với nắp lưng cong giúp ôm sát chuyển động của mu bàn tay, các nút bấm được cải thiện khả năng hoạt động và tinh thể lỏng MIP độ nét cao giúp cho màn hình hiển thị dễ đọc hơn.
Cả USB và sạc năng lượng mặt trời đều được hỗ trợ để đồng hồ hoạt động liên tục mà không bị gián đoạn.'
, '2024-01-01 00:00:10', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GBD-H2000-1ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu những sản phẩm mới nhất cho dòng đồng hồ thể thao G-SQUAD của G-SHOCK. 
Những mẫu đồng hồ thuộc dòng GBD-H2000 mới ra mắt được trang bị máy đo nhịp tim và khả năng kết nối GPS để hỗ trợ cho các hoạt động thể thao của nhiều môn thể thao khác nhau.
Các tính năng và chức năng được thiết kế để hỗ trợ, sao lưu việc tập luyện của bạn bằng bộ ba cảm biến: 
- Một cảm biến quang đo nhịp tim. 
- Một cảm biến gia tốc đếm số bước.
- Cảm biến con quay hồi chuyển (Nó là một thiết bị ứng dụng nguyên tắc bảo toàn mô men động lượng để đo đạc hoặc duy trì phương hướng. Có thể hiểu đơn giản, cảm biến con quay hồi chuyển là một bánh xe hay đĩa quay có trục quay tự do theo mọi hướng. Người ta dùng nó để đo vận tốc góc rất lớn của những vật trong không gian và qua đó phát hiện những thay đổi, để kịp thời điều chỉnh sự cân bằng của vật) để phát hiện kiểu bơi và hướng rẽ của bạn. 
Ngoài ra còn có điều hướng, độ cao/áp suất khí quyển, và cảm biến nhiệt độ. Mẫu đồng hồ này không chỉ hỗ trợ việc chạy bộ mà còn hỗ trợ cho nhiều môn thể thao khác như đạp xe hay bơi lội.
Khả năng GPS có thể sử dụng để đo khoảng cách, tốc độ, nhịp độ, và hơn thế nữa.
Bạn cũng có thể phân tích quá trình luyện tập và phục hồi của mình thông qua giấc ngủ bằng cách sử dụng thư viện Polar. 
Dây đeo và vòng mặt số sử dụng vật liệu nhựa sinh khối làm từ bắp, thân thiện với môi trường. Nhựa sinh khối là vật liệu polyme bao gồm các chất có nguồn gốc từ vật liệu hữu cơ tái tạo, thu được bằng cách tổng hợp hóa học hoặc sinh học các nguyên liệu thô.
Nhựa sinh khối giảm tải tác động xấu đến môi trường và giúp con người tiến gần hơn một "xã hội xanh".
Thiết kế thông minh với nắp lưng cong giúp ôm sát chuyển động của mu bàn tay, các nút bấm được cải thiện khả năng hoạt động và tinh thể lỏng MIP độ nét cao giúp cho màn hình hiển thị dễ đọc hơn.
Cả USB và sạc năng lượng mặt trời đều được hỗ trợ để đồng hồ hoạt động liên tục mà không bị gián đoạn.'
, '2024-01-01 00:00:11', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GBD-H2000-1A9', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu những sản phẩm mới nhất cho dòng đồng hồ thể thao G-SQUAD của G-SHOCK. 
Những mẫu đồng hồ thuộc dòng GBD-H2000 mới ra mắt được trang bị máy đo nhịp tim và khả năng kết nối GPS để hỗ trợ cho các hoạt động thể thao của nhiều môn thể thao khác nhau.
Các tính năng và chức năng được thiết kế để hỗ trợ, sao lưu việc tập luyện của bạn bằng bộ ba cảm biến: 
- Một cảm biến quang đo nhịp tim. 
- Một cảm biến gia tốc đếm số bước.
- Cảm biến con quay hồi chuyển (Nó là một thiết bị ứng dụng nguyên tắc bảo toàn mô men động lượng để đo đạc hoặc duy trì phương hướng. Có thể hiểu đơn giản, cảm biến con quay hồi chuyển là một bánh xe hay đĩa quay có trục quay tự do theo mọi hướng. Người ta dùng nó để đo vận tốc góc rất lớn của những vật trong không gian và qua đó phát hiện những thay đổi, để kịp thời điều chỉnh sự cân bằng của vật) để phát hiện kiểu bơi và hướng rẽ của bạn. 
Ngoài ra còn có điều hướng, độ cao/áp suất khí quyển, và cảm biến nhiệt độ. Mẫu đồng hồ này không chỉ hỗ trợ việc chạy bộ mà còn hỗ trợ cho nhiều môn thể thao khác như đạp xe hay bơi lội.
Khả năng GPS có thể sử dụng để đo khoảng cách, tốc độ, nhịp độ, và hơn thế nữa.
Bạn cũng có thể phân tích quá trình luyện tập và phục hồi của mình thông qua giấc ngủ bằng cách sử dụng thư viện Polar. 
Dây đeo và vòng mặt số sử dụng vật liệu nhựa sinh khối làm từ bắp, thân thiện với môi trường. Nhựa sinh khối là vật liệu polyme bao gồm các chất có nguồn gốc từ vật liệu hữu cơ tái tạo, thu được bằng cách tổng hợp hóa học hoặc sinh học các nguyên liệu thô.
Nhựa sinh khối giảm tải tác động xấu đến môi trường và giúp con người tiến gần hơn một "xã hội xanh".
Thiết kế thông minh với nắp lưng cong giúp ôm sát chuyển động của mu bàn tay, các nút bấm được cải thiện khả năng hoạt động và tinh thể lỏng MIP độ nét cao giúp cho màn hình hiển thị dễ đọc hơn.
Cả USB và sạc năng lượng mặt trời đều được hỗ trợ để đồng hồ hoạt động liên tục mà không bị gián đoạn.'
, '2024-01-01 00:00:12', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'G-B001MVE-9DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu mẫu đồng hồ hoàn toàn mới G-B001M, là phiên bản nâng cấp của mẫu đồng hồ DW-001, được ra mắt với tạo hình Capsule Tough và trở lại vào năm 1994. Mẫu G-B001M vẫn giữ phom dáng nguyên bản và cấu trúc chống sốc của mẫu DW-001 nhưng lại được thêm vào cấu trúc bảo vệ lõi cacbon và vòng mặt số bằng kim loại được đánh bóng để mang đến một lớp hoàn thiện độc đáo. Bộ vỏ vòng mặt số hai màu mang đến một vẻ đẹp mới mẻ và độc lạ. Mẫu G-B001MVE-9 sử dụng màu vàng đặc trưng của mẫu DW-001 ra mắt năm 1994, được thiết kế thêm dây đeo có thể thay thế và bộ vỏ vòng mặt số bằng nhựa có thể mix-match với bất kỳ mã đồng hồ nào trong 12 phiên bản khác nhau của bộ sưu tập mới này. 
Đồng hồ có khả năng kết nối Bluetooth, bạn có thể liên kết với một ứng dụng đặc biệt trên điện thoại để đi đến bất kỳ thông báo nào.'
, '2024-01-01 00:00:13', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'G-B001MVB-8DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập hoàn toàn mới, mẫu đồng hồ G-B001M đến từ G-SHOCK, thương hiệu đồng hồ đã không ngừng thử nghiệm những giới hạn mới về độ cứng cáp bền bỉ của chiếc đồng hồ đeo tay từ năm 1983. Bộ sưu tập mới lần này được tích hợp khả năng kết nối với điện thoại thông minh và vòng mặt số có khả năng tháo rời.
Mẫu đồng hồ G-B001M là một phiên bản mới và được cải tiến từ mẫu DW-001, được thiết kế theo kiểu Capsule Tough trở trở lại vào năm 1994. Mẫu G-B001M vẫn được giữ nguyên hình dáng cũ và tính năng chống sốc của mẫu DW-001 nhưng cũng được trang bị thêm cấu trúc bảo vệ lõi cacbon và vòng mặt số bằng kim loại được đánh bóng mang đến vẻ đẹp độc đáo. Một sự cải tiến sáng tạo với vỏ bọc vòng mặt số được kết hợp với nhựa bán trong suốt tạo nên một vẻ ngoài độc đáo khác lạ.
Bộ sưu tập mới lần này cải tiến hơn so với thiết kế ban đầu vì được tích hợp khả năng kết nối điện thoại thông minh trong một cấu trúc chống sốc của G-SHOCK cùng với thiết kế mới lạ.'
, '2024-01-01 00:00:14', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'G-B001MVA-1DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập hoàn toàn mới, mẫu đồng hồ G-B001M đến từ G-SHOCK, thương hiệu đồng hồ đã không ngừng thử nghiệm những giới hạn mới về độ cứng cáp bền bỉ của chiếc đồng hồ đeo tay từ năm 1983. Bộ sưu tập mới lần này được tích hợp khả năng kết nối với điện thoại thông minh và vòng mặt số có khả năng tháo rời.
Mẫu đồng hồ G-B001M là một phiên bản mới và được cải tiến từ mẫu DW-001, được thiết kế theo kiểu Capsule Tough trở trở lại vào năm 1994. Mẫu G-B001M vẫn được giữ nguyên hình dáng cũ và tính năng chống sốc của mẫu DW-001 nhưng cũng được trang bị thêm cấu trúc bảo vệ lõi cacbon và vòng mặt số bằng kim loại được đánh bóng mang đến vẻ đẹp độc đáo. Một sự cải tiến sáng tạo với vỏ bọc vòng mặt số được kết hợp với nhựa bán trong suốt tạo nên một vẻ ngoài độc đáo khác lạ.
Bộ sưu tập mới lần này cải tiến hơn so với thiết kế ban đầu vì được tích hợp khả năng kết nối điện thoại thông minh trong một cấu trúc chống sốc của G-SHOCK cùng với thiết kế mới lạ.'
, '2024-01-01 00:00:15', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GA-2100FT-8ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ G-SHOCK, thương hiệu đồng hồ đã luôn không ngừng theo đuổi sự bền bỉ từ năm 1983, trân trọng giới thiệu một mẫu đồng hồ hợp tác cùng thương hiệu FUTUR, thương hiệu thời trang mới nổi gần đây đến từ Pháp.
Mẫu đồng hồ nguyên bản là mẫu mặt số bát giác GA-2100, sử dụng sắc màu xám kết hợp cùng một số bộ phận bán trong suốt, hoàn thiện bằng những gam màu đơn sắc.
Một mặt số nhỏ ở vị trí 9h được nhấn nhá nổi bật bằng chiếc kim nhỏ màu vàng kim kết hợp cùng các chữ số màu xanh dương, trắng, đỏ, tượng trưng cho 3 màu cờ nước Pháp.
Sự kết hợp cùng thương hiệu thời trang đường phố được ưa chuộng như FUTUR mang đến một mẫu đồng hồ đơn giản nhưng không bao giờ lỗi mốt.
FUTUR được sáng lập bởi Felix Schaper và Benoit Fredonie vào tháng 7/2014. Xuất phát từ hai nền tảng khác nhau, một từ lĩnh vực trượt ván và nền tảng còn lại đến từ lĩnh vực thời trang. Hai cá thể riêng biệt này cùng nhau xây dựng FUTUR thành một thương hiệu tập trung vào gu thẩm mỹ bóng bẩy hút mắt bắt nguồn từ phong cách trượt ván đi cùng với sản phẩm chất lượng cao.'
, '2024-01-01 00:00:16', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GA-700RGB-1ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ G-SHOCK, dòng đồng hồ cứng cáp luôn không ngừng thúc đẩy những giới hạn mới về độ bền bỉ của chiếc đồng hồ đeo tay từ năm 1983, trân trọng giới thiệu bộ sưu tập hoàn toàn mới mang tên Virtual Rainbow (tạm dịch: cầu vồng thế giới ảo) dựa theo mô-típ là hình ảnh sắc màu cầu vồng của thế giới ảo trong các trò chơi điện tử.
Vòng mặt số và dây đeo của mẫu đồng hồ này được sơn một màu đen tuyền lấp lánh, cùng với màu cầu vồng được phủ lên mặt số và thêm vào một vài chi tiết sắc màu khác để tạo nên một thiết kế hoàn toàn phù hợp với đa dạng các phong cách thời trang khác nhau.
Mẫu cơ bản bao gồm mẫu có bộ vỏ lớn GA-100 và GA-700, mẫu DW-6900 có vỏ tròn và 3 vòng mặt số phụ điện tử và mẫu GA-2100 với vòng mặt số bát giác.
Sắc màu cầu vồng rực rỡ của mặt số sáng rực tương phản với màu đen lấp lánh của dây đeo mang đến một thiết kế vô cùng độc đáo.'
, '2024-01-01 00:00:17', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'GA-110GL-4ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ G-SHOCK, dòng đồng hồ cứng cáp luôn không ngừng thúc đẩy những giới hạn mới về độ bền bỉ của chiếc đồng hồ đeo tay từ năm 1983, trân trọng giới thiệu bộ sưu tập hoàn toàn mới mang tên Virtual Rainbow (tạm dịch: cầu vồng thế giới ảo) dựa theo mô-típ là hình ảnh sắc màu cầu vồng của thế giới ảo trong các trò chơi điện tử.
Vòng mặt số và dây đeo của mẫu đồng hồ này được sơn một màu đen tuyền lấp lánh, cùng với màu cầu vồng được phủ lên mặt số và thêm vào một vài chi tiết sắc màu khác để tạo nên một thiết kế hoàn toàn phù hợp với đa dạng các phong cách thời trang khác nhau.
Mẫu cơ bản bao gồm mẫu có bộ vỏ lớn GA-100 và GA-700, mẫu DW-6900 có vỏ tròn và 3 vòng mặt số phụ điện tử và mẫu GA-2100 với vòng mặt số bát giác.
Sắc màu cầu vồng rực rỡ của mặt số sáng rực tương phản với màu đen lấp lánh của dây đeo mang đến một thiết kế vô cùng độc đáo.'
, '2024-01-01 00:00:18', 1, 1);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTG-B2000YR-1ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng hồ MT-G đạt cấu trúc đẹp hoàn hảo nhờ cách kết hợp nhựa và kim loại vào thiết kế ban đầu.   
Giờ đây, khung sợi thủy tinh và carbon nhiều màu của mẫu MTG-B2000YR bổ sung thêm vẻ đẹp mới cho dòng sản phẩm bằng cách tạo ra một giao diện lung linh của cảnh quan thành phố về đêm.
Viền thép không gỉ của mẫu này có lớp phủ mạ ion (IP) cầu vồng, khắc họa nên hình ảnh đặc trưng của đô thị.
Lịch ngày hiển thị màu khác nhau cho mỗi ngày. Các vạch chỉ giờ, kim và logo MT-G của đồng hồ cũng có màu trong nhóm bảy sắc cầu vồng.
- Về chức năng, đồng hồ sử dụng Bluetooth để kết nối với app CASIO WATCHES chạy trên điện thoại thông minh của bạn để thu thập thông tin về thời gian.
Siêu phẩm này cũng được trang bị các chức năng hữu ích khác, bao gồm MULTIBAND 6, Tough Solar, hệ thống chiếu sáng LED với độ sáng cao và hơn thế nữa.'
, '2024-01-01 00:00:19', 1, 1);
--
-- BABY-G-20
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BGD-565XG-2', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đừng bỏ lỡ phong cách đường phố phù hợp với những cô gái cá tính. BABY-G và X-girl hợp tác tạo nên chiếc đồng hồ đơn giản vô cùng phù hợp với những cô gái năng động. BABY-G và X-girl là hai thương hiệu mang phong cách đường phố đích thực dành cho những cô gái sinh ra vào thời kỳ đỉnh cao của thời trang đường phố năm 1994. Họ đã trở lại với phong cách ảnh chế theo trào lưu vaporwave vào đầu những năm 2010 trong mẫu đồng hồ BGD-565 màu neon phân cực đặc trưng, tạo nên một cảm giác hư ảo và cổ điển. Dây đeo màu xanh lam nhạt mờ được hoàn thiện bằng lớp phủ ngọc trai màu tím, kết hợp với mặt đồng hồ phân cực với màu sắc óng ánh theo từng cử động nghiêng cổ tay. X-girl luôn đi đầu và là trung tâm của những điểm nhấn thiết kế đặc biệt. Logo X-girl được in trên vòng dây và xuất hiện trên màn hình khi bạn nhấn nút đèn. Ngoài ra còn có logo khuôn mặt nổi tiếng của thương hiệu do Mike Mills thiết kế được khắc trên phần lưng vỏ. Khi phong cách vaporwave không phù hợp với bầu không khí, chúng tôi có ngay dây đeo và gờ bằng nhựa màu đen có thể thay thế để đưa bạn đến bất cứ đâu. Chỉ cần trượt cần gạt trên lưng vỏ để dễ dàng hoán đổi dây đeo và khoác lên mình phong cách bạn muốn. Bao bì được thiết kế đặc biệt nhằm hoàn thiện trải nghiệm X-girl. Phong cách đường phố X-girl dành cho những cô gái cá tính. X-girl cung cấp “Trang phục cho những cô gái cá tính” lấy cảm hứng từ âm nhạc, văn hóa, thể thao và nhiều yếu tố khung cảnh đường phố khác đi trước thời đại.'
, '2024-01-01 00:00:20', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BG-169HRB-7', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'BABY-G, dòng đồng hồ đơn giản dành cho giới nữ năng động, đã phát triển mẫu đồng hồ mới được hợp tác sản xuất cùng với thương hiệu HARIBO, nhà sản xuất kẹo dẻo nổi tiếng của Đức. Mọi yếu tố trong phong cách thiết kế của chiếc đồng hồ này đều vui nhộn và phá cách, hoàn toàn phù hợp với thế giới HARIBO. Chất liệu trong mờ màu trắng cơ bản của mẫu đồng hồ được tạo thêm điểm nhấn với màu sắc của những chiếc kẹo Goldbears phổ biến. Mẫu cơ sở là chiếc đồng hồ BABY-G BG-169 nhỏ nhắn. Các nút và mặt đồng hồ được trang trí với màu sắc lấy cảm hứng từ HARIBO Goldbears. Toàn bộ phần mặt đồng hồ đều được trang trí hình HARIBO Goldbears đặc trưng, mô phỏng hương vị của kẹo mâm xôi, chanh, táo và cam. Khi bật đèn nền EL của đồng hồ cũng sẽ thấy được hoa văn HARIBO Goldbears sắp xếp theo mẫu cố định trên mặt đồng hồ. Dây đeo và vỏ của mẫu đồng hồ này được làm bằng nhựa trong mờ, tạo cảm giác giống như kẹo dẻo và tô điểm cho màu sắc tươi sáng của thiết kế. Biểu tượng Goldbears màu vàng được in trên vòng dây đeo, trong khi nắp sau của đồng hồ được khắc biểu tượng Goldbears và HARIBO quen thuộc. Bao bì của mẫu đồng hồ này cũng được thiết kế nhằm gợi lên mô-típ kẹo dẻo. Mọi chi tiết trong thiết kế dễ thương của mẫu hợp tác đặc biệt này khiến nó trở thành một biểu tượng đại chúng. HARIBO TM &  2022 HARIBO Holding GmbH & Co. KG. Mọi quyền được bảo lưu.'
, '2024-01-01 00:00:21', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BA-110XRG-4ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Hãy đeo lên tay chiếc đồng hồ bắt mắt với màu sắc tươi tắn, thanh lịch, lấy cảm hứng từ thiết kế G-SHOCK GA-110 nổi tiếng. Sự kết hợp tinh xảo giữa mặt số, vạch chỉ giờ và các bộ phận khác tạo nên hình ảnh thiết bị cơ khí với điểm nhấn sắc nét tràn đầy năng lượng. Mẫu đồng hồ BABY-G mang phong cách thời trang đường phố nổi trội và có nhiều chức năng. Trải nghiệm các chức năng tiện dụng, đáng tin cậy như đèn LED và đồng hồ bấm giờ, bên cạnh khả năng chống va đập và chống nước.'
, '2024-01-01 00:00:22', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BGD-565SC-3DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ BABY-G, thương hiệu đồng hồ đời thường chống sốc dành cho phái nữ năng động, trân trọng giới thiệu bộ sưu tập mới với nhiều màu sắc hoàn hảo dành cho mùa xuân.
Mẫu cơ bản là BGD-565, được biết đến với kích thước nhỏ gọn. Ba màu sắc của mẫu đồng hồ này được đặc biệt lựa chọn để tạo nên hình ảnh của hoa tử đinh hương, hoa xô thơm và hoa anh đào. Hai mẫu hoa tử đinh hương và hoa xô thơm có mặt số, dây đeo và vỏ cùng tông màu.
Riêng mẫu hoa anh đào có dây đeo màu trắng và mặt số màu hồng nhạt mang đến hình ảnh e ấp  dịu dàng của cánh hoa anh đào hoàn toàn phù hợp với phong cách thời trang thường ngày.
Mặt số được phủ một lớp ngọc trai lấp lánh mang đến vẻ quyến rũ cho mẫu đồng hồ.
Mỗi một chiếc đồng hồ trong bộ sưu tập mới lần này sẽ mang đến cho người đeo cảm giác tươi mới của mùa xuân.
', '2024-01-01 00:00:23', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BGA-320-9A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Tiếp nối thành công của dòng đồng hồ BABY-G dành cho phụ nữ năng động, sê-ri BGA-320 xoay quanh chủ đề "Một ngày nắng rực rỡ trên bãi biển mùa hè". 
Thiết kế của BGA-320 là vỏ mỏng và vạch chỉ giờ 3 chiều bằng kim loại.
Các mẫu mới xuất hiện với đa dạng màu sắc khác nhau như: xanh bạc hà từ đầm lầy, màu hồng hạc, màu cát trắng và màu vàng tươi ánh mặt trời.
Về thiết kế, sự chuyển màu của mặt số gợi nên hình ảnh của bãi biển hoàng hôn mùa hè. Kỹ thuật lắng đọng hơi kim loại (Metal Vapor Deposition - MVD) hoàn hảo dùng cho các vạch chỉ giờ gợi lên vẻ ngoài của những viên ngọc trai lấp lánh và vỏ sò như những món đồ trang sức biển. Kim phút được tạo hình như vây đuôi nàng tiên cá. Màu sắc vui tươi, thiết kế hấp dẫn và nhiều chi tiết khác về những chiếc đồng hồ này chắc chắn sẽ mang đến sự vui tươi tràn đầy sức sống cho bạn khi mang nó trên tay
Về chức năng, những chiếc đồng hồ này đi kèm với những tính năng hữu ích như chống sốc mạnh và chống vô nước ở độ sâu 100 mét , ngay cả khi bạn đang bơi.
Hãy tạo nên một mùa hè rực rỡ sắc màu khi bạn diện chiếc đồng hồ BABY-G biển tươi mới.
', '2024-01-01 00:00:24', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BGA-320-7A1', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Tiếp nối thành công của dòng đồng hồ BABY-G dành cho phụ nữ năng động, sê-ri BGA-320 xoay quanh chủ đề "Một ngày nắng rực rỡ trên bãi biển mùa hè". 
Thiết kế của BGA-320 là vỏ mỏng và vạch chỉ giờ 3 chiều bằng kim loại.
Các mẫu mới xuất hiện với đa dạng màu sắc khác nhau như: xanh bạc hà từ đầm lầy, màu hồng hạc, màu cát trắng và màu vàng tươi ánh mặt trời.
Về thiết kế, sự chuyển màu của mặt số gợi nên hình ảnh của bãi biển hoàng hôn mùa hè. Kỹ thuật lắng đọng hơi kim loại (Metal Vapor Deposition - MVD) hoàn hảo dùng cho các vạch chỉ giờ gợi lên vẻ ngoài của những viên ngọc trai lấp lánh và vỏ sò như những món đồ trang sức biển. Kim phút được tạo hình như vây đuôi nàng tiên cá. Màu sắc vui tươi, thiết kế hấp dẫn và nhiều chi tiết khác về những chiếc đồng hồ này chắc chắn sẽ mang đến sự vui tươi tràn đầy sức sống cho bạn khi mang nó trên tay
Về chức năng, những chiếc đồng hồ này đi kèm với những tính năng hữu ích như chống sốc mạnh và chống vô nước ở độ sâu 100 mét , ngay cả khi bạn đang bơi.
Hãy tạo nên một mùa hè rực rỡ sắc màu khi bạn diện chiếc đồng hồ BABY-G biển tươi mới.
', '2024-01-01 00:00:25', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BGA-320-4A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Tiếp nối thành công của dòng đồng hồ BABY-G dành cho phụ nữ năng động, sê-ri BGA-320 xoay quanh chủ đề "Một ngày nắng rực rỡ trên bãi biển mùa hè". 
Thiết kế của BGA-320 là vỏ mỏng và vạch chỉ giờ 3 chiều bằng kim loại.
Các mẫu mới xuất hiện với đa dạng màu sắc khác nhau như: xanh bạc hà từ đầm lầy, màu hồng hạc, màu cát trắng và màu vàng tươi ánh mặt trời.
Về thiết kế, sự chuyển màu của mặt số gợi nên hình ảnh của bãi biển hoàng hôn mùa hè. Kỹ thuật lắng đọng hơi kim loại (Metal Vapor Deposition - MVD) hoàn hảo dùng cho các vạch chỉ giờ gợi lên vẻ ngoài của những viên ngọc trai lấp lánh và vỏ sò như những món đồ trang sức biển. Kim phút được tạo hình như vây đuôi nàng tiên cá. Màu sắc vui tươi, thiết kế hấp dẫn và nhiều chi tiết khác về những chiếc đồng hồ này chắc chắn sẽ mang đến sự vui tươi tràn đầy sức sống cho bạn khi mang nó trên tay
Về chức năng, những chiếc đồng hồ này đi kèm với những tính năng hữu ích như chống sốc mạnh và chống vô nước ở độ sâu 100 mét , ngay cả khi bạn đang bơi.
Hãy tạo nên một mùa hè rực rỡ sắc màu khi bạn diện chiếc đồng hồ BABY-G biển tươi mới.
', '2024-01-01 00:00:26', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BGA-320-3A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Tiếp nối thành công của dòng đồng hồ BABY-G dành cho phụ nữ năng động, sê-ri BGA-320 xoay quanh chủ đề "Một ngày nắng rực rỡ trên bãi biển mùa hè". 
Thiết kế của BGA-320 là vỏ mỏng và vạch chỉ giờ 3 chiều bằng kim loại.
Các mẫu mới xuất hiện với đa dạng màu sắc khác nhau như: xanh bạc hà từ đầm lầy, màu hồng hạc, màu cát trắng và màu vàng tươi ánh mặt trời.
Về thiết kế, sự chuyển màu của mặt số gợi nên hình ảnh của bãi biển hoàng hôn mùa hè. Kỹ thuật lắng đọng hơi kim loại (Metal Vapor Deposition - MVD) hoàn hảo dùng cho các vạch chỉ giờ gợi lên vẻ ngoài của những viên ngọc trai lấp lánh và vỏ sò như những món đồ trang sức biển. Kim phút được tạo hình như vây đuôi nàng tiên cá. Màu sắc vui tươi, thiết kế hấp dẫn và nhiều chi tiết khác về những chiếc đồng hồ này chắc chắn sẽ mang đến sự vui tươi tràn đầy sức sống cho bạn khi mang nó trên tay
Về chức năng, những chiếc đồng hồ này đi kèm với những tính năng hữu ích như chống sốc mạnh và chống vô nước ở độ sâu 100 mét , ngay cả khi bạn đang bơi.
Hãy tạo nên một mùa hè rực rỡ sắc màu khi bạn diện chiếc đồng hồ BABY-G biển tươi mới.
', '2024-01-01 00:00:27', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL,'BG-169U-8BDR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập mới đến từ BABY-G, thương hiệu đồng hồ dành cho phái nữ năng động.
Bộ sưu tập đồng hồ BG-169 được trang bị càng bảo vệ ở mặt đồng hồ cũng là bộ phận chống va đập tích hợp với phần thân được bo tròn nhỏ gọn.
Một số chức năng hữu ích bao gồm chống nước đến độ sâu 200m, giờ thế giới, đồng hồ bấm giờ,...
Tất cả những mẫu đồng hồ BABY-G này đều là mẫu đồng hồ hợp thời trang cho cả khi đi làm hoặc khi đi chơi.
', '2024-01-01 00:00:28', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BG-169U-4BDR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập mới đến từ BABY-G, thương hiệu đồng hồ dành cho phái nữ năng động.
Bộ sưu tập đồng hồ BG-169 được trang bị càng bảo vệ ở mặt đồng hồ cũng là bộ phận chống va đập tích hợp với phần thân được bo tròn nhỏ gọn.
Một số chức năng hữu ích bao gồm chống nước đến độ sâu 200m, giờ thế giới, đồng hồ bấm giờ,...
Tất cả những mẫu đồng hồ BABY-G này đều là mẫu đồng hồ hợp thời trang cho cả khi đi làm hoặc khi đi chơi.
', '2024-01-01 00:00:29', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BG-169U-3DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập mới đến từ BABY-G, thương hiệu đồng hồ dành cho phái nữ năng động.
Bộ sưu tập đồng hồ BG-169 được trang bị càng bảo vệ ở mặt đồng hồ cũng là bộ phận chống va đập tích hợp với phần thân được bo tròn nhỏ gọn.
Một số chức năng hữu ích bao gồm chống nước đến độ sâu 200m, giờ thế giới, đồng hồ bấm giờ,...
Tất cả những mẫu đồng hồ BABY-G này đều là mẫu đồng hồ hợp thời trang cho cả khi đi làm hoặc khi đi chơi.
', '2024-01-01 00:00:30', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BG-169U-1CDR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập mới đến từ BABY-G, thương hiệu đồng hồ dành cho phái nữ năng động.
Bộ sưu tập đồng hồ BG-169 với phần thân được bo tròn nhỏ gọn, được trang bị càng bảo vệ ở mặt đồng hồ, có tác dụng chống va đập.
Một số chức năng hữu ích bao gồm chống nước đến độ sâu 200m, giờ thế giới, đồng hồ bấm giờ,...
Tất cả những mẫu đồng hồ BABY-G này đều là mẫu đồng hồ hợp thời trang cho cả khi đi làm hoặc khi đi chơi.
', '2024-01-01 00:00:31', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BG-169PB-7', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'BABY-G BG-169PB-7DR: MÀU TRẮNG - HỒNG DỊU MẮT, GỢI LIÊN TƯỞNG ĐẾN KHUNG CẢNH BÃI CÁT TRẮNG VỚI NHỮNG VỎ SÒ TÍ HON
Hòa chung không khí của mùa hè, Casio không làm fan-girl thất vọng khi cho ra mắt ngay bộ sưu tập các mẫu đồng hồ mới dành cho phái nữ mang màu sắc mát mắt của mùa hè. 
Bộ sưu tập lấy cảm hứng từ hình ảnh những bãi biển nhiệt đới trên khắp thế giới, BABY-G BG-169 có hẳn 3 lựa chọn màu sắc cho chị em: xanh dương, trắng và hồng. 
- Màu xanh dương lấy cảm hứng từ đá larimar - loại đá quý được tìm thấy duy nhất ở Bahamas (Cộng hòa Dominica) thuộc vùng biển Caribe. Chỉ với nguồn gốc đặc biệt này đã cho thấy được sự quý hiếm của đá Larimar so với các loại đá quý khác trên thị trường.
- Màu hồng san hô gợi lên hình ảnh những rặng san hô tràn đầy sức sống. 
- Màu hồng vỏ sò lấy cho chúng ta liên tưởng đến khung cảnh những bãi cát hồng của vùng biển Caribê.
Về chức năng, những chiếc đồng hồ này đi kèm với những tính năng hữu ích như khả năng chống sốc mạnh mẽ và chống nước ở độ sâu 200 mét, ngay cả khi đang bơi.
Các mẫu BABY-G mới này được thiết kế trẻ trung, màu sắc tươi sáng và tính năng hữu ích để phù hợp cho các hoạt động vui chơi trên biển.
', '2024-01-01 00:00:32', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BG-169PB-4', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'BABY-G BG-169PB-7DR: MÀU TRẮNG - HỒNG DỊU MẮT, GỢI LIÊN TƯỞNG ĐẾN KHUNG CẢNH BÃI CÁT TRẮNG VỚI NHỮNG VỎ SÒ TÍ HON
Hòa chung không khí của mùa hè, Casio không làm fan-girl thất vọng khi cho ra mắt ngay bộ sưu tập các mẫu đồng hồ mới dành cho phái nữ mang màu sắc mát mắt của mùa hè. 
Bộ sưu tập lấy cảm hứng từ hình ảnh những bãi biển nhiệt đới trên khắp thế giới, BABY-G BG-169 có hẳn 3 lựa chọn màu sắc cho chị em: xanh dương, trắng và hồng. 
- Màu xanh dương lấy cảm hứng từ đá larimar - loại đá quý được tìm thấy duy nhất ở Bahamas (Cộng hòa Dominica) thuộc vùng biển Caribe. Chỉ với nguồn gốc đặc biệt này đã cho thấy được sự quý hiếm của đá Larimar so với các loại đá quý khác trên thị trường.
- Màu hồng san hô gợi lên hình ảnh những rặng san hô tràn đầy sức sống. 
- Màu hồng vỏ sò lấy cho chúng ta liên tưởng đến khung cảnh những bãi cát hồng của vùng biển Caribê.
Về chức năng, những chiếc đồng hồ này đi kèm với những tính năng hữu ích như khả năng chống sốc mạnh mẽ và chống nước ở độ sâu 200 mét, ngay cả khi đang bơi.
Các mẫu BABY-G mới này được thiết kế trẻ trung, màu sắc tươi sáng và tính năng hữu ích để phù hợp cho các hoạt động vui chơi trên biển.
', '2024-01-01 00:00:33', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BA-110XBE-7ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Hãy đeo lên tay chiếc đồng hồ bắt mắt với màu sắc tươi tắn, thanh lịch, lấy cảm hứng từ thiết kế G-SHOCK GA-110 nổi tiếng. Sự kết hợp tinh xảo giữa mặt số, vạch chỉ giờ và các bộ phận khác tạo nên hình ảnh thiết bị cơ khí với điểm nhấn sắc nét tràn đầy năng lượng. Mẫu đồng hồ BABY-G mang phong cách thời trang đường phố nổi trội và có nhiều chức năng. Trải nghiệm các chức năng tiện dụng, đáng tin cậy như đèn LED và đồng hồ bấm giờ, bên cạnh khả năng chống va đập và chống nước.
', '2024-01-01 00:00:34', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BA-110X-7A1DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Hãy đeo lên tay chiếc đồng hồ bắt mắt với màu sắc tươi tắn, thanh lịch, lấy cảm hứng từ thiết kế G-SHOCK GA-110 nổi tiếng. Sự kết hợp tinh xảo giữa mặt số, vạch chỉ giờ và các bộ phận khác tạo nên hình ảnh thiết bị cơ khí với điểm nhấn sắc nét tràn đầy năng lượng. Mẫu đồng hồ BABY-G mang phong cách thời trang đường phố nổi trội và có nhiều chức năng. Trải nghiệm các chức năng tiện dụng, đáng tin cậy như đèn LED và đồng hồ bấm giờ, bên cạnh khả năng chống va đập và chống nước.
', '2024-01-01 00:00:35', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BGA-290DS-7ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng hồ BABY-G - Thương hiệu đồng hồ dành cho phái nữ năng động vừa trình làng bộ sưu tập mới với chủ để về mặt trăng và những ngôi sao lấp lánh trên bầu trời đêm.
Mẫu đồng hồ nguyên bản là mẫu BGA-290 có thiết kế mặt số rộng dễ đọc và bộ vỏ mỏng. Màu sắc đa dạng với những tông màu như hồng nhạt, xanh nhạt, và màu trắng. Mặt số được phủ một dải màu chuyển tượng trưng cho sự chuyển đổi màu sắc trên bầu trời.
Các mẫu mới này còn được trang trí thêm hình mặt trăng biểu thị cho sự trưởng thành cùng những ngôi sao để thể hiện cho sự may mắn và hạnh phúc. Vòng mặt số hoàn thiện bằng một lớp màng mỏng và phương pháp lắng đọng hơi để tạo cảm giác giống kim loại lấp lánh.
Bộ sưu tập mới này có cấu trúc chống sốc và chống nước đến 100 mét, nghĩa là bạn có thể đeo chúng đi đến bắt cứ nơi đâu trong cuộc sống thường ngày.
', '2024-01-01 00:00:36', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BA-110XWS-7ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'CASIO giới thiệu bộ sưu tập mùa đông phiên bản giới hạn năm 2023 với chủ đề "Mùa đông lấp lánh", gồm sáu mẫu khác nhau về màu sắc, kích thước và kiểu dáng. 
Những mẫu đồng hồ này không chỉ phù hợp cho các cặp đôi mà còn có thể trở thành món quà đặc biệt cho bạn bè, gia đình hoặc đối tác. 
- Cặp đôi GM-2100 với vỏ phủ kim loại và GM-S2100 phiên bản nhỏ hơn. 
- GA-2100 mặt bát giác phổ biến và GMA-S2100 nhỏ gọn.
- GA-110 với mặt số thiết kế 3D cùng các bộ phận khác được xếp thành nhiều lớp và BA-110 là phiên bản BABY-G của GA-110. 
Mặt số của các mẫu này trang trí bằng phương pháp lắng đọng hơi nước với nhiều màu sắc khác nhau, mỗi màu đều được lấy cảm hứng từ đồ trang trí và ánh sáng của mùa lễ hội. Phông chữ thiết kế giống như những chiếc nơ trên hộp quà ngày lễ, được sử dụng để in chữ WR20BAR trên mặt số đồng hồ G-SHOCK và WR10BAR trên BABY-G. Đây là thông số hiển thị khả năng chống nước ở độ sâu 200 mét và 100 mét tương ứng của mỗi mẫu. 
Mặt sau của mỗi chiếc đồng hồ khắc dấu đặc biệt dành riêng cho bộ sưu tập theo mùa với họa tiết dây thừng, tượng trưng cho sự gắn kết giữa mọi người.
Những chiếc đồng hồ cặp này là món quà hoàn hảo cho mùa lễ hội, dành tặng cho ai đó đặc biệt trong cuộc đời bạn.
', '2024-01-01 00:00:37', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BGD-565RP-2DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'BABY-G - Dòng đồng hồ dành cho phụ nữ năng động, nay giới thiệu bộ sưu tập mới với thiết kế và màu sắc nổi bật pha chút cổ điển. Mẫu nguyên bản là BGD-565 vốn được ưa chuộng với kích thước nhỏ gọn, gồm có các màu xanh navy, cam và trắng. 
Mặt đồng hồ được trang trí bằng họa tiết những cánh hoa, lấy cảm hứng từ hình ảnh hoa đua nở trên cánh đồng. Đặc biệt, những cánh hoa này còn hiện lên khi bật đèn nền. Những mẫu BABY-G mới này hứa hẹn sẽ "thêm gia vị" cho mọi trải nghiệm của bạn với thời trang ngoài trời. 
', '2024-01-01 00:00:38', 1, 2);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'BGA-310RP-9ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'CASIO giới thiệu bộ sưu tập đồng hồ màu sắc trẻ trung, nổi bật với chủ đề ngoài trời. Đây là bộ sưu tập mới nhất được thêm vào dòng đồng hồ BABY-G - Thương hiệu đồng hồ dành cho phái nữ năng động.
Mỗi mẫu được lựa chọn để thiết kế với những gam màu sống động, pha chút cổ điển như màu xanh lam, đỏ rượu hay vàng mù tạt, tạo điểm nhấn cho phong cách thời trang ngoài trời.
Kim chỉ giờ lớn và vạch chỉ giờ nổi ba chiều được đặt trên một mặt số rộng giúp dễ đọc. Kim giờ cũng được thiết kế theo hình chiếc đèn lồng, mang đến cảm giác mới lạ và thú vị. Một số bộ phận đồng hồ còn được phủ dạ quang để dễ nhìn ngay cả trong bóng tối. Các mấu gài giữa dây đeo và thân đồng hồ có khả năng di chuyển linh hoạt, mang đến cảm giác thoải mái, vừa vặn khi đeo trên cổ tay.
Vòng mặt số và dây đeo của mẫu BGA-310RP được làm từ vật liệu nhựa sinh học với hy vọng có thể làm giảm các tác động ảnh hưởng đến môi trường.
Về tính năng, các mẫu đồng hồ này chống sốc và chống nước lên đến 100 mét. Nút đèn phía trước dễ dàng chiếu sáng màn hình và rất hữu ích khi đi cắm trại. Bộ đôi đèn LED giúp chiếu sáng mặt đồng hồ và màn hình kỹ thuật số. Chức năng đèn tự động sẽ hoạt động ngay khi bạn nghiêng đồng hồ để xem giờ.
Bộ sưu tập mới này là một cách để BABY-G hỗ trợ phụ nữ năng động trong các hoạt động thường ngày trong nhà hoặc ngoài trời. 
', '2024-01-01 00:00:39', 1, 2);
--
-- EDIFICE-20
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-950MP-1ADF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Bộ sưu tập mới mang tên Racing Multicolor lấy ý tưởng dựa theo màu sắc trên vô lăng của những chiếc xe đua. Bốn sắc màu làm điểm nhấn trên mặt số của bộ sưu tập mới này được bố trí giống với cách phối màu nút trên vô lăng của những chiếc xe đua. Thiết kế của bộ sưu tập mới này mang đến tinh thần của môn đua xe thể thao chính là ra quyết định tức thời và hành động chính xác và nâng cao tính khả dụng của các chức năng khác. Kim giây và màn hình hiển thị giờ vòng được thiết kế giúp dễ đọc hơn. Dây nhựa mềm của các mẫu mới này cũng được thiết kế để mang đến sự thoải mái tuyệt đối cho người đeo. Mặt sau của đồng hồ được mạ ion màu đen , gờ được làm từ thép không gỉ và mạ inon màu đen tăng độ bền cũng như sự sang trọng cho chiếc đồng hồ . Tất cả những điều này và những điều khác hơn thế nữa đã được rèn giũa đến mức hoàn hảo dựa trên các phản hồi từ các môi trường đường đua thực tế.
Mẫu đồng hồ ECB-950MP, ECB-900MP, và ECB-40MP được trang bị khả năng kết nối với điện thoại thông qua Bluetooth để sử dụng trọn vẹn mọi tính năng  trong tầm tay nhằm hỗ trợ các đội đua. Đồng hồ có thể kết nối với một ứng dụng đặc biệt trên điện thoại để tự động điều chỉnh thời gian hiện hành. Chức năng liên kết điện thoại cũng có thể được sử dụng để lựa chọn hiển thị giờ thế giới, cài đặt báo thức và hẹn giờ, công cụ tìm điện thoại bằng cách nhấn vào nút đồng hồ để điện thoại đổ chuông ( nằm trong phạm vi Bluetooth ) và các hoạt động khác. Bạn cũng có thể gửi giờ vòng với đơn vị đo 1-1000 giây đến điện thoại và sử dụng ứng dụng để kiểm tra biểu đồ giờ vòng.
Mẫu ECB-950MP và ECB-900MP còn được trang bị hệ thống pin năng lượng mặt trời có thể sạc bằng đèn huỳnh quang hoặc ánh sáng mặt trời. Thời gian pin sạ 6 tháng với điều kiện ánh sáng bình thường không tiếp xúc với ánh sáng khi sạc và 19 tháng trong bóng tối. Điều này có nghĩa là bạn cứ tự tin đeo đồng hồ ở mọi lúc mọi nơi mà không cần quan tâm đến việc hết pin và giúp tiết kiệm năng lượng sau khi pin đã được sạc đầy. Ngoài ra thì có thêm các chức năng khác như đèn LED kép chiếu sáng cực mạng( gồm 1 đền LED cho mặt đồng hồ, 1 đền LED màn hình kĩ thuật số) dễ dàng xem giờ trong bóng tối.
', '2024-01-01 00:00:40', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-900MP-1ADF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Bộ sưu tập mới mang tên Racing Multicolor lấy ý tưởng dựa theo màu sắc trên vô lăng của những chiếc xe đua. Bốn sắc màu làm điểm nhấn trên mặt số của bộ sưu tập mới này được bố trí giống với cách phối màu nút trên vô lăng của những chiếc xe đua. Thiết kế của bộ sưu tập mới này mang đến tinh thần của môn đua xe thể thao chính là ra quyết định tức thời và hành động chính xác và nâng cao tính khả dụng của các chức năng khác. Kim giây và màn hình hiển thị giờ vòng được thiết kế giúp dễ đọc hơn. Dây nhựa mềm của các mẫu mới này cũng được thiết kế để mang đến sự thoải mái tuyệt đối cho người đeo. Mặt sau của đồng hồ được mạ ion màu đen , gờ được làm từ thép không gỉ và mạ inon màu đen tăng độ bền cũng như sự sang trọng cho chiếc đồng hồ . Tất cả những điều này và những điều khác hơn thế nữa đã được rèn giũa đến mức hoàn hảo dựa trên các phản hồi từ các môi trường đường đua thực tế.
Mẫu đồng hồ ECB-950MP, ECB-900MP, và ECB-40MP được trang bị khả năng kết nối với điện thoại thông qua Bluetooth để sử dụng trọn vẹn mọi tính năng  trong tầm tay nhằm hỗ trợ các đội đua. Đồng hồ có thể kết nối với một ứng dụng đặc biệt trên điện thoại để tự động điều chỉnh thời gian hiện hành. Chức năng liên kết điện thoại cũng có thể được sử dụng để lựa chọn hiển thị giờ thế giới, cài đặt báo thức và hẹn giờ, công cụ tìm điện thoại bằng cách nhấn vào nút đồng hồ để điện thoại đổ chuông ( nằm trong phạm vi Bluetooth ) và các hoạt động khác. Bạn cũng có thể gửi giờ vòng với đơn vị đo 1-1000 giây đến điện thoại và sử dụng ứng dụng để kiểm tra biểu đồ giờ vòng.
Mẫu ECB-950MP và ECB-900MP còn được trang bị hệ thống pin năng lượng mặt trời có thể sạc bằng đèn huỳnh quang hoặc ánh sáng mặt trời. Thời gian pin sạ 6 tháng với điều kiện ánh sáng bình thường không tiếp xúc với ánh sáng khi sạc và 19 tháng trong bóng tối. Điều này có nghĩa là bạn cứ tự tin đeo đồng hồ ở mọi lúc mọi nơi mà không cần quan tâm đến việc hết pin và giúp tiết kiệm năng lượng sau khi pin đã được sạc đầy. Ngoài ra thì có thêm các chức năng khác như đèn LED kép chiếu sáng cực mạng( gồm 1 đền LED cho mặt đồng hồ, 1 đền LED màn hình kĩ thuật số) dễ dàng xem giờ trong bóng tối.
', '2024-01-01 00:00:41', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-2000MFG-1A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Xin giới thiệu mẫu đồng hồ ECB-2000MFG đua xe thể thao có một không hai, hiệu suất cao. Hãng EDIFICE hợp tác với họa sĩ Shuichi Shigeno tạo nên mẫu thiết kế vô cùng đặc biệt. Ông là họa sĩ chấp bút cho hai bộ truyện manga chủ đề đua xe thể thao nổi tiếng: Initial D và MF GHOST. Tác phẩm Initial D nổi tiếng với các cuộc đua băng qua đèo dốc. Tác phẩm được xuất bản từ năm 1995 đến năm 2013 trên Tạp chí Young của nhà xuất bản Kodansha Ltd. và được người hâm mộ vô cùng yêu thích với hơn 56 triệu bản được bán ra. MF GHOST là bộ manga đua xe lấy bối cảnh đường phố của Shigeno. Tác phẩm xuất hiện trên cùng một tạp chí từ năm 2017, cùng một loạt anime truyền hình dự kiến ra mắt vào năm 2023. Mẫu hợp tác trong mơ này mô phỏng thế giới của hai bộ truyện Initial D và MF GHOST. Các chi tiết trong cả hai bộ truyện đều được đưa vào mẫu thiết kế đồng hồ dành riêng cho người chiến thắng này. Thiết kế màu đỏ và đen dựa trên chiếc Toyota GT86 do nhân vật chính Kanata Rivington trong bộ truyện MF GHOST điều khiển. Phần đế của mặt số và mặt dưới của dây da đều được đóng dấu ký tự Gyaaa (tiếng lốp xe rít trên đường) cắt ngang các trang sách của hai bộ truyện Initial D và MF GHOST. Mặt dưới của dây đeo cũng có dòng chữ “Cửa hàng đậu phụ Fujiwara (Xe của gia đình),” dòng chữ quen thuộc ở bên hông xe Toyota AE86 của Takumi Fujiwara, nhân vật chính trong truyện Initial D. Với tính năng kết nối với điện thoại thông minh qua Bluetooth giúp bạn thao tác dễ dàng và hệ thống sạc Tough Solar cung cấp năng lượng, chiếc đồng hồ hiệu suất cao này giúp bạn tự do tập trung vào con đường phía trước.
', '2024-01-01 00:00:42', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EQB-1200AT-1A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Phái mạnh có nhiều cách để thể hiện bản lĩnh của mình, một trong những cách dễ nhất có thể kể đến là một chiếc đồng hồ giúp thể hiện chất riêng của bạn.
Đồng hồ Edifice EQB-1200 mang đến vẻ đẹp hào nhoáng và tinh xảo khiến các chàng trai phải mê đắm.
Đây là chiếc đồng hồ nhiều kim, thông số kỹ thuật cao với Smartphone Link và công nghệ năng lượng mặt trời vượt trội, tất cả được gói gọn trong thiết kế mỏng 9,4 mm mang đến sự dễ dàng và thoải mái cho cổ tay của bạn.
Mặt số dạng lưới kim loại gợi lên hình ảnh tấm lưới phía trước xe thể thao để thể hiện tốc độ thể thao mạnh mẽ.
Mặt kính tinh thể saphia chống xước được phủ một lớp không phản quang để mang đến khả năng quan sát cao, Tough Solar hiện đại, kết nối với điện thoại thông minh của bạn qua Bluetooth® và chống nước 100m.
Đam mê thời trang, thể hiện bản thân thì EQB-1200 sẽ không làm bạn thất vọng. Dù đi làm hay đi chơi, sự kiện hay họp mặt bạn bè, đây sẽ là một phụ kiện không thể tách rời.
', '2024-01-01 00:00:43', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EFV-640L-2AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng hồ bấm giờ thể thao cổ điển với vỏ bezel hình bát giác Hiện đại - Mạnh mẽ - Chắc chắn.
', '2024-01-01 00:00:44', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EFV-640DC-3AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng hồ bấm giờ thể thao cổ điển với vỏ bezel hình bát giác Hiện đại - Mạnh mẽ - Chắc chắn.
', '2024-01-01 00:00:45', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EFV-640D-5AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng hồ bấm giờ thể thao cổ điển với vỏ bezel hình bát giác Hiện đại - Mạnh mẽ - Chắc chắn.
', '2024-01-01 00:00:46', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EFV-640D-2AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng hồ bấm giờ thể thao cổ điển với vỏ bezel hình bát giác Hiện đại - Mạnh mẽ - Chắc chắn.
', '2024-01-01 00:00:47', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EFV-640D-1AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng hồ bấm giờ thể thao cổ điển với vỏ bezel hình bát giác Hiện đại - Mạnh mẽ - Chắc chắn.
', '2024-01-01 00:00:48', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EFB-710D-7AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Những chiếc đồng hồ bấm giờ thể thao cổ điển này tạo thêm sự đẳng cấp cho phong cách đồng hồ hiện đại. 
Dây đồng hồ được tạo thành từ các mắc dây hình chữ H để vừa vặn ôm vào cổ tay. 
Mặt đồng hồ được bảo vệ bởi tinh thể sapphire chống trầy xước.
', '2024-01-01 00:00:49', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'EFB-710D-2AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Những chiếc đồng hồ bấm giờ thể thao cổ điển này tạo thêm sự đẳng cấp cho phong cách đồng hồ hiện đại. 
Dây đồng hồ được tạo thành từ các mắc dây hình chữ H để vừa vặn ôm vào cổ tay. 
Mặt đồng hồ được bảo vệ bởi tinh thể sapphire chống trầy xước.
', '2024-01-01 00:00:50', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-2000NIS-1A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'EDIFICE và NISMO vừa hợp tác để cho ra mắt "cực phẩm" đồng hồ Edifice thể thao mang tên "EDIFICE NISMO MY23 EDITION" - Phiên bản đặc biệt năm 2023, với nhiều tính năng hiện đại, chuyên dành riêng cho bộ môn đua xe. EDIFICE NISMO MY23 EDITION ra đời từ ý tưởng chiếc xe đua #23 Nissan Z (đây là một dòng xe thể thao của hãng Nissan và đã được sản xuất từ những năm 1960) trong giải đua SUPER GT. 
Từng bộ phận, đặc điểm trên chiếc xe đua #23 Nissan Z được thiết kế và lồng ghép một cách tinh tế trên mẫu đồng hồ Edifice.
Nếu trải dài phần dây và mặt đồng hồ, sẽ thấy được sự chuyển đổi màu sắc linh hoạt giữa 2 mảng màu: đen và đỏ, lấy cảm hứng theo sự chuyển đổi màu sắc khi nhìn từ bên hông thân xe của chiếc Nissan Z #23.  
Con số 23 màu đỏ nổi bật – Số hiệu của xe Nissan, đặt đúng vị trí phút 23, nhằm tôn vinh “Quân át chủ bài” của NISMO.  
Trên mặt số đồng hồ còn thể hiện một thiết kế đồ họa tương đồng với thiết kế bánh sau của xe đua, được tạo ra bằng cách sắp xếp các chữ “Z” lại với nhau.  
Logo NISMO được khắc trên vỏ bezel, móc dây và mặt sau. Vỏ được làm bằng nhựa gia cố carbon.  
ECB-2000NIS có thể kết nối Bluetooth với ứng dụng điện thoại đặc biệt để tự động sửa đổi thời gian, đảm bảo đồng hồ luôn hoạt động chính xác. Ngoài ra, ứng dụng này giúp người dùng dễ dàng cài đặt giờ thế giới, chuyển dữ liệu đo lường bằng đồng hồ bấm giờ với gia số 1/1000 giây qua điện thoại; công cụ tìm kiếm điện thoại.  
Thêm vào đó, ECB-2000NIS cũng có tính năng dùng năng lượng mặt trời và có tinh thể sapphire.
', '2024-01-01 00:00:51', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-950DB-2A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Bộ sưu tập mới mang tên Racing Multicolor lấy ý tưởng dựa theo màu sắc trên vô lăng của những chiếc xe đua. Bốn sắc màu làm điểm nhấn trên mặt số của bộ sưu tập mới này được bố trí giống với cách phối màu nút trên vô lăng của những chiếc xe đua. Thiết kế của bộ sưu tập mới này mang đến tinh thần của môn đua xe thể thao chính là ra quyết định tức thời và hành động chính xác và nâng cao tính khả dụng của các chức năng khác. Kim giây và màn hình hiển thị giờ vòng được thiết kế giúp dễ đọc hơn. Dây nhựa mềm của các mẫu mới này cũng được thiết kế để mang đến sự thoải mái tuyệt đối cho người đeo. Mặt sau của đồng hồ được mạ ion màu đen , gờ được làm từ thép không gỉ và mạ inon màu đen tăng độ bền cũng như sự sang trọng cho chiếc đồng hồ . Tất cả những điều này và những điều khác hơn thế nữa đã được rèn giũa đến mức hoàn hảo dựa trên các phản hồi từ các môi trường đường đua thực tế.
Mẫu đồng hồ ECB-950MP, ECB-900MP, và ECB-40MP được trang bị khả năng kết nối với điện thoại thông qua Bluetooth để sử dụng trọn vẹn mọi tính năng  trong tầm tay nhằm hỗ trợ các đội đua. Đồng hồ có thể kết nối với một ứng dụng đặc biệt trên điện thoại để tự động điều chỉnh thời gian hiện hành. Chức năng liên kết điện thoại cũng có thể được sử dụng để lựa chọn hiển thị giờ thế giới, cài đặt báo thức và hẹn giờ, công cụ tìm điện thoại bằng cách nhấn vào nút đồng hồ để điện thoại đổ chuông ( nằm trong phạm vi Bluetooth ) và các hoạt động khác. Bạn cũng có thể gửi giờ vòng với đơn vị đo 1/1000 giây đến điện thoại và sử dụng ứng dụng để kiểm tra biểu đồ giờ vòng.
Mẫu ECB-950MP và ECB-900MP còn được trang bị hệ thống pin năng lượng mặt trời có thể sạc bằng đèn huỳnh quang hoặc ánh sáng mặt trời. Thời gian pin sạ 6 tháng với điều kiện ánh sáng bình thường không tiếp xúc với ánh sáng khi sạc và 19 tháng trong bóng tối. Điều này có nghĩa là bạn cứ tự tin đeo đồng hồ ở mọi lúc mọi nơi mà không cần quan tâm đến việc hết pin và giúp tiết kiệm năng lượng sau khi pin đã được sạc đầy. Ngoài ra thì có thêm các chức năng khác như đèn LED kép chiếu sáng cực mạng( gồm 1 đền LED cho mặt đồng hồ, 1 đền LED màn hình kĩ thuật số) dễ dàng xem giờ trong bóng tối.
', '2024-01-01 00:00:52', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-40P-1ADF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu mẫu đồng hồ ECB-40 EDIFICE SOSPENSIONE được tích hợp khả năng kết nối điện thoại thông minh. Phần thiết kế lấy cảm hứng từ "cánh tay đòn - suspension arm design" của xe đua thể thao với chất liệu nhựa pha sợi carbon bền bỉ.
Mẫu gắn dây của mẫu đồng hồ này mang kiểu dáng của hai cánh tay đòn phía trước và phía sau. Chất liệu nhựa pha sợi carbon được sử dụng để làm mấu gài dây mang đến vẻ ngoài mạnh mẽ nhưng trọng lượng thì nhẹ.
Mỗi mẫu đồng hồ trong bộ sưu tập này đều tự động kết nối với điện thoại thông minh thông qua Bluetooth bất cứ khi nào hai thiết bị này được đặt gần nhau. Bạn không cần phải nhấn bất kỳ nút nào để kết nối. Tính năng này giúp đảm bảo hiệu chỉnh thời gian chính xác, đơn giản hóa việc xem giờ thế giới, và cho phép ghi dữ liệu thời gian bấm giờ đến 1/1000 giây cho tối đa 200 vòng lặp.
Tất cả những tính năng trên đây đều cần thiết phải sử dụng đối với đội đua. Đèn LED siêu sáng giúp chiếu sáng màn hình kỹ thuật số và mặt số trong bóng tối.
', '2024-01-01 00:00:53', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-40MP-1ADF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'EDIFICE, mẫu đồng hồ hiện đại luôn không ngừng theo đuổi sự độc đáo với thiết kế theo kiểu dáng xe đua thể thao đi cùng với các chức năng thông minh, tự hào giới thiệu bộ sưu tập mới mang tên Racing Multicolor lấy ý tưởng dựa theo màu sắc trên vô lăng của những chiếc xe đua. Bốn sắc màu làm điểm nhấn trên mặt số của bộ sưu tập mới này được bố trí giống với cách phối màu nút trên vô lăng của những chiếc xe đua. Thiết kế của bộ sưu tập mới này mang đến tinh thần của môn đua xe thể thao chính là ra quyết định tức thời và hành động chính xác và nâng cao tính khả dụng của các chức năng khác. Kim giây và màn hình hiển thị giờ vòng được thiết kế giúp dễ đọc hơn. Dây nhựa mềm của các mẫu mới này cũng được thiết kế để mang đến sự thoải mái tuyệt đối cho người đeo. Tất cả những điều này và những điều khác hơn thế nữa đã được rèn giũa đến mức hoàn hảo dựa trên các phản hồi từ các môi trường đường đua thực tế.
Mẫu đồng hồ ECB-950MP, ECB-900MP, và ECB-40MP được trang bị khả năng kết nối với điện thoại thông qua Bluetooth. Đồng hồ có thể kết nối với một ứng dụng đặc biệt trên điện thoại để tự động điều chỉnh thời gian hiện hành. Chức năng liên kết điện thoại cũng có thể được sử dụng để lựa chọn hiển thị giờ thế giới, cài đặt báo thức, và các hoạt động khác. Bạn cũng có thể gửi giờ vòng với đơn vị đo 1/1000 giây đến điện thoại và sử dụng ứng dụng để kiểm tra biểu đồ giờ vòng.
', '2024-01-01 00:00:54', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-40DB-1A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu mẫu đồng hồ ECB-40 EDIFICE SOSPENSIONE được tích hợp khả năng kết nối điện thoại thông minh bên trong một thiết kế lấy cảm hứng từ cánh tay đòn treo của xe đua thể thao với chất liệu nhựa pha sợi cacbon bền bỉ.
Mẫu gắn dây của những mẫu đồng hồ này mang kiểu dáng của hai cánh tay đòn treo ở phía trước và hai cánh tay đòn treo phía sau. Nhưa pha sợi cacbon được sử dụng để làm mấu gài dây mang đến sự kết hợp của sự mạnh mẽ nhưng lại có trọng lượng nhẹ.
Mỗi một mẫu đồng hồ trong bộ sưu tập này đều tự động kết nối với điện thoại thông minh được lựa chọn để kết đôi thông qua Bluetooth® bất cứ khi nào hai thiết bị này được đặt gần nhau. Bạn không cần phải nhấn bất kỳ nút nào để kết nối. Tính năng này giúp đảm bảo hiệu chỉnh thời gian chính xác, đơn giản hóa việc xem giờ thế giới, và cho phép ghi dữ liệu thời gian bấm giờ đến 1/1000 giây cho tối đa 200 vòng lặp.
Tất cả những tính năng trên đây đều là những điều cần thiết phải sử dụng đối với đội đua. Đèn LED siêu sáng giúp chiếu sáng màn hình kỹ thuật số và mặt số trong bóng tối.
', '2024-01-01 00:00:55', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-2200HTR-1ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đồng Hồ Casio Edifice ECB-2200HTR-1ADR phiên bản EDIFICE Honda TYPE R Edition, hợp tác cùng Honda Motor Company, tôn vinh dòng xe huyền thoại Honda Type R. Đồng hồ có một vòng gài dây đeo đôi bằng bạc và màu đen, gợi lên biển số serial được lắp ở Xe loại R.
', '2024-01-01 00:00:56', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-40MU-1ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu mẫu đồng hồ EDIFICE MUGEN EDITION là thành quả của sự hợp tác giữa MUGEN - Nhà sản xuất linh kiện ô tô nổi tiếng thế giới và EDIFICE - Thương hiệu đồng hồ thể thao đa chức năng.
MUGEN là sản xuất và bán các linh kiện hậu mãi cho các dòng xe ô tô của Honda, ngoài ra còn phát triển và sản xuất động cơ xe đua. Mẫu đồng hồ mới này đưa bản sắc của thương hiệu MUGEN vào thiết kế. Logo MUGEN là một điểm nhấn chính của thiết kế, bốn sắc màu đặc trưng của thương hiệu MUGEN bao gồm trắng, đỏ, vàng kim và đen xuất hiện không những trên mặt số mà còn được thể hiện trên dây và vòng đeo dây. Hình ảnh mang tính biểu tượng “Mugen Command Eye” được thể hiện trên dây đeo bằng chất liệu da Alcantar. Phông chữ chuẩn nguyên bản từ MUGEN được sử dụng cho các vạch số chỉ phút trên vòng mặt số.
Bộ vỏ làm từ nhựa gia cố sợi carbon và kiểu dáng của mấu gài dây được thiết kế lấy cảm hứng từ cánh tay đòn hệ thống treo của những chiếc xe đua công thức. Sau khi ghép đôi với điện thoại, đồng hồ sẽ tự động kết nối với điện thoại bất cứ khi nào chúng ở trong phạm vi kết nối của nhau và tự động hiệu chỉnh thời gian. Kết nối với điện thoại cho phép đồng hồ điều chỉnh giờ thế giới, báo thức và các chức năng khác bằng cách sử dụng ứng dụng CASIO WATCHES trên điện thoại.
Mẫu đồng hồ mới này còn được trang bị đèn siêu sáng, giúp chiếu sáng kim chỉ giờ và màn hình kỹ thuật số đi cùng với mặt kính Sapphire chống trầy.
MUGEN được thành lập từ năm 1973 bởi Hirotoshi Honda, người con lớn nhất của nhà sáng lập Honda, Soichiro Honda. Ngoài việc tham gia các cuộc đua trong nước và quốc tế như một đội đua chuyên nghiệp. Bên cạnh đó, MUGEN còn tham gia vào nhiều hoạt động đa dạng khác nhau liên quan đến môn thể thao đua xe, bao gồm thiết kế động cơ và mô-tơ cho những chiếc xe tham gia các cuộc đua. Ngoài ra, MUGEN còn phát triển, sản xuất và bán một số linh kiện và phụ kiện hoàn hảo chủ yếu dành cho xe 4 bánh. Từ năm 2006, M-TEC Corporation đã được vận hành dưới tên thương hiệu là MUGEN. MUGEN sẽ kỷ niệm 50 năm thành lập vào năm 2023.
', '2024-01-01 00:00:57', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-2200P-1ADF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu mẫu đồng hồ ECB-2200 WINDFLOW - Bộ sưu tập đồng hồ kim điện tử kết hợp hoàn toàn mới đến từ EDIFICE, lấy cảm hứng từ những luồng khí được tạo ra từ xe đua công thức.
Hai bên vỏ được thiết kế theo hình ảnh của dòng khí lưu thông qua hai bên khoang của chiếc xe đua công thức, kết hợp cùng mặt số nổi không gian ba chiều sắc nét, mang đến cho mẫu đồng hồ mới này một vẻ ngoài độc đáo. Bộ vỏ bằng nhựa gia cố sợi carbon vừa nhẹ, bền và vừa thoải mái khi đeo trên cổ tay. Bốn lỗ trên dây đeo bằng nhựa của mẫu ECB-2200P được thiết kế mô phỏng lại cửa thoát khí của xe ô tô.
Tất cả những mẫu đồng hồ này đều có thể kết nối với ứng dụng trên điện thoại thông qua Bluetooth và hỗ trợ nhiều chức năng hữu ích với đội đua.
Nhờ tính năng kết nối với điện thoại, đồng hồ có thể điều chỉnh và duy trì thời gian đúng đến từng giây. Nó còn đơn giản hóa việc cài đặt giờ thế giới và có thể chuyển dữ liệu đo đến 1/1000th giây bấm giờ. Đèn mặt số siêu sáng giúp dễ đọc trong bóng tối. Hệ thống sạc năng lượng mặt trời có thể chuyển hóa thành điện năng ngay cả khi mặt đồng hồ chỉ tiếp xúc với nguồn ánh sáng nhỏ, bao gồm cả ánh sáng huỳnh quang để sạc pin có thể sử dụng đến 7 tháng.
', '2024-01-01 00:00:58', 1, 3);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'ECB-2200DD-1ADF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu mẫu đồng hồ ECB-2200 WINDFLOW - Bộ sưu tập đồng hồ kim điện tử kết hợp hoàn toàn mới đến từ EDIFICE, lấy cảm hứng từ những luồng khí được tạo ra từ xe đua công thức.
Hai bên vỏ được thiết kế theo hình ảnh của dòng khí lưu thông qua hai bên khoang của chiếc xe đua công thức, kết hợp cùng mặt số nổi không gian ba chiều sắc nét, mang đến cho mẫu đồng hồ mới này một vẻ ngoài độc đáo. Bộ vỏ bằng nhựa gia cố sợi carbon vừa nhẹ, bền và vừa thoải mái khi đeo trên cổ tay. Bốn lỗ trên dây đeo bằng nhựa của mẫu ECB-2200P được thiết kế mô phỏng lại cửa thoát khí của xe ô tô.
Tất cả những mẫu đồng hồ này đều có thể kết nối với ứng dụng trên điện thoại thông qua Bluetooth và hỗ trợ nhiều chức năng hữu ích với đội đua.
Nhờ tính năng kết nối với điện thoại, đồng hồ có thể điều chỉnh và duy trì thời gian đúng đến từng giây. Nó còn đơn giản hóa việc cài đặt giờ thế giới và có thể chuyển dữ liệu đo đến 1/1000th giây bấm giờ. Đèn mặt số siêu sáng giúp dễ đọc trong bóng tối. Hệ thống sạc năng lượng mặt trời có thể chuyển hóa thành điện năng ngay cả khi mặt đồng hồ chỉ tiếp xúc với nguồn ánh sáng nhỏ, bao gồm cả ánh sáng huỳnh quang để sạc pin có thể sử dụng đến 7 tháng.
', '2024-01-01 00:00:59', 1, 3);
--
-- SHEEN-20
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4554PGL-8AUDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Bộ vỏ bát giác thời trang của bộ sưu tập đồng hồ SHEEN mới lần này được hoàn thiện bằng cách tạo nên một vẻ ngoài sang trọng quý phái. Bề mặt trên cùng của vòng mặt số phẳng được xử lý đánh bóng xước tạo điểm độc đáo và lấp lánh cho chiếc đồng hồ. Bề mặt dốc của vỏ được xử lý đánh bóng tráng gương. Bộ vỏ và vòng mặt số đa diệm kết hợp với vật liệu kim loại có lớp phủ bóng đã tạo nên một thiết kế đẹp tuyệt vời và làm cho mẫu đồng hồ trông giống như một phụ kiện thời trang đẳng cấp. Casio đã ứng dụng kĩ thuật tiên tiến thiết kế cho toàn bộ vỏ mỏng hơn chỉ còn 7.5 mm giúp cho người đeo cảm giác nhẹ nhàng khi đeo.  
SHE-4554PGL: Bộ vỏ mạ ion (IP) màu vàng hồng kết hợp hoàn hảo với màu đen của mặt số. Dây đeo dạng lưới nhuyễn mang đến cảm giác thoải mái khi đeo và giúp chiếc đồng hồ trở thành một phụ kiện thời trang trên cổ tay.
Các tính năng khác của những mã đồng hồ này bao gồm mặt kính saphia chống trầy, đi cùng với khả năng chống nươc đến 50 mét.
', '2024-01-01 00:01:00', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4541G-9A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Bổ sung phiên bản đồng hồ mang màu sắc dịu nhẹ, lung linh vào bộ sưu tập bảng màu của bạn. Chiếc đồng hồ đơn giản có diện mạo cổ điển với kim giờ, phút và giây nay trông rực rỡ hơn với đường gờ và dây đeo phủ lớp tráng gương lấp lánh. Mặt kính saphia chống xước và khả năng chống nước ở độ sâu lên đến 50 mét giúp bạn không phải lo lắng, trong khi màn hình hiển thị ngày dễ đọc và các chức năng tiện dụng khác mang đến cho bạn cuộc sống dễ dàng hơn. Kết hợp cả phong cách lẫn tính thực tiễn, đây là món phụ kiện tuyệt đẹp mà cổ tay bạn đang còn thiếu.
', '2024-01-01 00:01:01', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4539FPL-7A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trải nghiệm phong cách có đôi chút khác thường và lãng mạn với chiếc đồng hồ lấy cảm hứng từ những vòng hoa. Vòng hoa không có điểm kết thúc tượng trưng cho tình yêu vĩnh cửu và may mắn – những cảm xúc dường như bừng nở từ thiết kế vòng hoa của những chiếc đồng hồ này.
Lớp hoàn thiện một tông màu kết hợp hài hòa với màu sắc của mặt số, cùng viên pha lê duy nhất lấp lánh đầy tinh tế ở vị trí 7 giờ.
Vỏ và dây đeo đều được mạ ion cùng tông màu với mặt số, tạo nên diện mạo đơn sắc vô cùng tinh tế. Với mặt kính saphia chống xước và khả năng chống nước ở độ sâu lên đến 50 mét, những chiếc đồng hồ tuyệt đẹp mà vẫn đầy đủ chức năng này mang đến cho bạn niềm vui trong cuộc sống năng động.
', '2024-01-01 00:01:02', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4556SPG-5AUDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:03', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4556PGL-7AUDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:04', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4532PGL-7A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:05', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4057PGL-7B', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:06', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-3034PG-9A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:07', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-3034GL-7B', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:08', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-3034GL-7A2', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:09', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-3034GL-7A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:10', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-3034D-7A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:11', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-3028L-4A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:12', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-3028D-7A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:13', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHB-100D-4A', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:14', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHB-100CG-4ADR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ SHEEN sang trọng với nhiều sắc vàng hồng khác nhau để lựa chọn.
Các viên pha lê được viền xung quanh vòng mặt số tạo nên một điểm nhấn thời trang.
Một số chức năng bao gồm, mặt kính sapphire chống trầy và khả năng chống nước đến 50 mét giúp bảo vệ đồng hồ khi đi mưa.
', '2024-01-01 00:01:15', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4554GYM-8AUDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu SHEEN mới này có vỏ hình bát giác - gờ phẳng được hoàn thiện tỉ mỉ lớp xước tương phản với lớp tráng gương bóng sáng.
Vỏ và dây đeo được mạ ion (IP) và mặt số được hoàn thiện bằng tộng màu mờ phù hợp.
Có hai lựa chọn màu sắc: vàng hồng thời thượng và xám sang trọng.
Các tinh thể sapphire trong suốt chống trầy xước giúp dễ xem giờ.
Khả năng chống nước lên đến 50 mét, mang đến sự tiện dụng và an tâm cho việc sử dụng trong sinh hoạt hàng ngày (môi trường ẩm ướt).
', '2024-01-01 00:01:16', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4559G-8AUDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Những mẫu đồng hồ đẹp và thanh lịch này có bề mặt vỏ đơn giản nhưng vẫn có nét phá cách. Bao gồm mẫu đơn sắc màu vàng hồng và mẫu kim loại vàng với mặt số màu xám sành điệu. Mặt số sáng bóng với 4 vạch chỉ giờ tạo nên vẻ ngoài đơn giản thanh lịch.
Tinh thể sapphire chống trầy xước giúp tăng cường khả năng đọc thông tin. Lịch hiển thị ở vị trí 6 giờ. 
', '2024-01-01 00:01:17', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4559PG-4AUDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu SHEEN mới này có vỏ hình bát giác - gờ phẳng được hoàn thiện tỉ mỉ lớp xước tương phản với lớp tráng gương bóng sáng.
Vỏ và dây đeo được mạ ion (IP) và mặt số được hoàn thiện bằng tộng màu mờ phù hợp.
Có hai lựa chọn màu sắc: vàng hồng thời thượng và xám sang trọng.
Các tinh thể sapphire trong suốt chống trầy xước giúp dễ xem giờ.
Khả năng chống nước lên đến 50 mét, mang đến sự tiện dụng và an tâm cho việc sử dụng trong sinh hoạt hàng ngày (môi trường ẩm ướt).
', '2024-01-01 00:01:18', 1, 4);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'SHE-4560PG-4AUDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Tất cả những mẫu đồng hồ mới tuyệt đẹp này đều có mặt số sáng bóng như gương. Phần vỏ trơn láng và dây đeo độ mỏng vừa vặn, thoải mái với cổ tay.
Tinh thể sapphire chống trầy xước giúp tăng cường khả năng đọc thông tin. Ngoài ra, khả năng chống nước lên đến 50 mét giúp người dùng thoải mái sử dụng trong các hoạt động thường ngày.
', '2024-01-01 00:01:19', 1, 4);
--
-- GENERAL-20
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MQ-24S-8B', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Mẫu đồng hồ MQ-24 bán chạy nhất đã quay trở lại với phong cách thiết kế trong mờ rực rỡ! Những chiếc đồng hồ này có vỏ kim loại, mặt số mang ánh mặt trời và dây đeo kết hợp nhiều màu đơn sắc hài hòa. Mẫu đồng hồ tiện dụng, tạo cảm giác vừa vặn, thoải mái có trọng lượng nhẹ và thiết kế đơn giản với kim giờ, phút, giây và chế độ chống nước sử dụng hằng ngày.
', '2024-01-01 00:01:20', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'LF-10WH-1', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'"Những chiếc đồng hồ kỹ thuật số nhỏ gọn và nhẹ này được tạo ra bằng cách sử dụng nhựa sinh khối.( nhựa sinh khối là những loại vật liệu sinh học có nguồn gốc từ sinh vật, thực vật như phế phẩm từ nông nghiệp, lâm nghiệp (Rơm, bã cây, lá khô, vụn gỗ, giấy vụn,... ). Thiết kế đơn sắc liền khối giữa mặt số và dây đeo tăng thêm sự rắn chắc mạnh mẽ dù SP rất mỏng nhẹ
Dây urethane (Urethane là một nhóm các chất hữu cơ được sử dụng nhiều trong sản xuất công nghiệp hiện nay, rất nhẹ ) được làm bằng nhựa sinh khối thân thiện với môi trường giúp giảm bớt tác động môi trường bằng cách sử dụng hữu cơ tái tạo.  Những SP này giúp nâng cao lối sống có ý thức về giữ gìn sinh thái và bảo vệ môi trường tự nhiên.Các chức năng hữu ích bao gồm báo thức, đồng hồ bấm giờ và lịch tự động đầy đủ cùng với đèn nền LED để dễ đọc ngay cả trong
tối.  SP này an toàn khi đeo trong mưa"
', '2024-01-01 00:01:21', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'WS-1500H-5AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Thoả mãn con người phong cách và thực tiễn trong bạn với chiếc đồng hồ số đa năng mang thiết kế táo bạo, to bản và dễ đọc. Hoàn chỉnh với tuổi thọ pin 10 năm, khả năng chống nước lên đến 100 mét, đèn LED và chế độ hiển thị giờ kép, mẫu đồng hồ này luôn sẵn sàng cho bạn. Chỉ báo mực nước câu cá và tuần trăng chính là những gì bạn cần khi ra khơi.
', '2024-01-01 00:01:22', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'W-201-1BV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Những chiếc đồng hồ kỹ thuật số với thiết kế thể thao này có khả năng chống nước ở độ sâu 50 mét và tuổi thọ pin dài (W-201: khoảng 10 năm, W-218H: xấp xỉ 7 năm).
Ngoài ra, chúng còn được trang bị màn hình LCD có đèn nền LED giúp người dùng dễ xem giờ ngay cả trong bóng tối.
', '2024-01-01 00:01:23', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M305L-7AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:24', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M305L-2AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:25', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M305L-1AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:26', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M305D-7AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:27', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M300L-7AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:28', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M300L-1AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:29', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M300D-7AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:30', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-M300D-4AV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:31', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'LWA-300HB-1EV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu analog mới này có thiết kế đơn giản với Khả năng chống nước 100 mét.
', '2024-01-01 00:01:32', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'LWA-300H-7EV', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu analog mới này có thiết kế đơn giản với Khả năng chống nước 100 mét.
', '2024-01-01 00:01:33', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'F-200W-1ADF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Trân trọng giới thiệu bộ sưu tập đồng hồ mới có nhiều mặt số kim kết hợp với hình ảnh mặt trăng trong một thiết kế thời trang, biến mẫu đồng hồ trở thành món phụ kiện có thể sử dụng khi đi làm hoặc trong cuộc sống thường ngày.
Đồng hồ có khả năng chống nước đến 50 mét, có thể đeo đi mưa hoặc tiếp xúc nước thoải mái.
', '2024-01-01 00:01:34', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'F-94WA-9DG', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu analog mới này có thiết kế đơn giản với Khả năng chống nước 100 mét.
', '2024-01-01 00:01:35', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'F-91WS-7DF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu analog mới này có thiết kế đơn giản với Khả năng chống nước 100 mét.
', '2024-01-01 00:01:36', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-B160L-3BVDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Mặt số và dây đeo bằng chất liệu da của đồng hồ nổi bật trong thiết kế lấy tone màu tự nhiên của trái đất. Mặt đồng hồ 3 kim, có khả năng chống nước lên đến 50 mét. 
', '2024-01-01 00:01:37', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-B155C-1EVDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu đồng hồ có ba kim giúp người dùng dễ đọc thông số. Thiết kế viền vỏ mang kiểu dáng thể thao. Ngoài ra còn có tác tính năng như cửa sổ lịch ở vị trí 3 giờ, khả năng chống nước lên đến 50 mét,... 
', '2024-01-01 00:01:38', 1, 5);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'MTP-B155C-3EVDF', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mẫu đồng hồ có ba kim giúp người dùng dễ đọc thông số. Thiết kế viền vỏ mang kiểu dáng thể thao. Ngoài ra còn có tác tính năng như cửa sổ lịch ở vị trí 3 giờ, khả năng chống nước lên đến 50 mét,... 
', '2024-01-01 00:01:39', 1, 5);
--
-- PRO TREK-20
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-340-3DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Hòa mình vào không gian ngoài trời tuyệt vời với mẫu đồng hồ PRO TREK chạy bằng năng lượng mặt trời với các vật liệu thân thiện với môi trường nhằm thể hiện sự quan tâm đối với môi trường. Dòng phụ kiện PRO TREK nguyên bản ngoài trời dành cho những người yêu thiên nhiên giới thiệu mẫu đồng hồ PRG-340 kết hợp nhựa sinh học thân thiện với môi trường, mang lại cảm giác vừa vặn thoải mái cho cổ tay của bạn.
Vỏ và dây đeo uretan được chế tạo bằng nhựa sinh học làm từ dầu thầu dầu và dây đeo bằng nhựa sinh học làm từ ngô. Màn hình LCD hai mặt bố trí các lớp riêng biệt hiển thị đồ họa la bàn và các chức năng của đồng hồ, tạo nên màn hình la bàn lớn hơn giúp bạn đọc và chuyển hướng dễ hơn trong một thiết kế vừa đẹp mắt vừa đầy đủ chức năng. Đường gờ xoay giúp bạn dễ dàng ghi lại các chỉ số la bàn, trong khi hệ thống sạc Tough Solar duy trì chức năng cải tiến khi di chuyển.
Ra ngoài khám phá trên đôi chân mềm mại! Nhựa sinh học là các polyme được sản xuất bằng cách sử dụng các vật liệu hóa học hoặc sinh học tổng hợp từ các chất có nguồn gốc từ thực vật hoặc các chất hữu cơ tái tạo khác và được cho là có tác dụng làm giảm tác động môi trường và thúc đẩy chuyển dịch sang nền kinh tế tuần hoàn.
', '2024-01-01 00:01:40', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-30B-4', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Hòa mình vào không gian ngoài trời tuyệt vời với mẫu đồng hồ PRO TREK chạy bằng năng lượng mặt trời với các vật liệu thân thiện với môi trường nhằm thể hiện sự quan tâm đối với môi trường. Dòng phụ kiện PRO TREK nguyên bản ngoài trời dành cho những người yêu thiên nhiên giới thiệu mẫu đồng hồ PRG-30B kết hợp nhựa sinh học thân thiện với môi trường, mang lại cảm giác vừa vặn thoải mái cho cổ tay của bạn.
Vỏ và dây đeo uretan được chế tạo bằng nhựa sinh học làm từ dầu thầu dầu và dây đeo bằng nhựa sinh học làm từ ngô. Màn hình LCD hai mặt bố trí các lớp riêng biệt hiển thị đồ họa la bàn và các chức năng của đồng hồ, tạo nên màn hình la bàn lớn hơn giúp bạn đọc và chuyển hướng dễ hơn trong một thiết kế vừa đẹp mắt vừa đầy đủ chức năng. Đường gờ xoay giúp bạn dễ dàng ghi lại các chỉ số la bàn, trong khi hệ thống sạc Tough Solar duy trì chức năng cải tiến khi di chuyển.
Ra ngoài khám phá trên đôi chân mềm mại! Nhựa sinh học là các polyme được sản xuất bằng cách sử dụng các vật liệu hóa học hoặc sinh học tổng hợp từ các chất có nguồn gốc từ thực vật hoặc các chất hữu cơ tái tạo khác và được cho là có tác dụng làm giảm tác động môi trường và thúc đẩy chuyển dịch sang nền kinh tế tuần hoàn.
', '2024-01-01 00:01:41', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRT-B70BE-1', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Hòa mình vào không gian ngoài trời tuyệt vời với mẫu đồng hồ PRO TREK chạy bằng năng lượng mặt trời với các vật liệu thân thiện với môi trường nhằm thể hiện sự quan tâm đối với môi trường. Dòng phụ kiện PRO TREK nguyên bản ngoài trời dành cho những người yêu thiên nhiên giới thiệu mẫu đồng hồ PRT-B70BE kết hợp nhựa sinh học thân thiện với môi trường, mang lại cảm giác vừa vặn thoải mái cho cổ tay của bạn.
Vỏ và dây đeo uretan được chế tạo bằng nhựa sinh học làm từ dầu thầu dầu và dây đeo bằng nhựa sinh học làm từ ngô. Màn hình LCD hai mặt bố trí các lớp riêng biệt hiển thị đồ họa la bàn và các chức năng của đồng hồ, tạo nên màn hình la bàn lớn hơn giúp bạn đọc và chuyển hướng dễ hơn trong một thiết kế vừa đẹp mắt vừa đầy đủ chức năng. Đường gờ xoay giúp bạn dễ dàng ghi lại các chỉ số la bàn, trong khi hệ thống sạc Tough Solar duy trì chức năng cải tiến khi di chuyển.
Ra ngoài khám phá trên đôi chân mềm mại! Nhựa sinh học là các polyme được sản xuất bằng cách sử dụng các vật liệu hóa học hoặc sinh học tổng hợp từ các chất có nguồn gốc từ thực vật hoặc các chất hữu cơ tái tạo khác và được cho là có tác dụng làm giảm tác động môi trường và thúc đẩy chuyển dịch sang nền kinh tế tuần hoàn.
', '2024-01-01 00:01:42', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRW-6000SYT-1DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'PRO TREK Climber - Dòng thiết bị ngoài trời dành cho những người yêu thích thiên nhiên – phát hành mẫu dây đeo vải mới PRG-601YB, được làm bằng vật liệu thân thiện với môi trường.
Vạch chỉ giờ 3D trên mặt số. Chữ số font Ả Rập và khung bezel bằng thép không gỉ mạ ion IP.
Thiết kế kết hợp đơn giản giữa chiếc đồng hồ thông thường với vẻ ngoài táo bạo, phù hợp cho mọi hoạt động ngoài trời hàng ngày. Vỏ mặt trước và sau của đồng hồ được làm bằng vật liệu nhựa sinh học, dây vải được làm bằng vật liệu chai nhựa tái chế. Những vật liệu này được kỳ vọng sẽ đóng góp vào giảm thiệt hại cho môi trường.
PRG-601YB mới này đi kèm với bộ ba cảm biến phát hiện những thay đổi trong môi trường tự nhiên của bạn (phương vị, áp suất khí quyển/nhiệt độ) và tough solar , tạo ra năng lượng điện từ ánh sáng.
', '2024-01-01 00:01:43', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRW-6000SG-3', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'PRO TREK Climber - Dòng thiết bị ngoài trời dành cho những người yêu thích thiên nhiên – phát hành mẫu dây đeo vải mới PRG-601YB, được làm bằng vật liệu thân thiện với môi trường.
Vạch chỉ giờ 3D trên mặt số. Chữ số font Ả Rập và khung bezel bằng thép không gỉ mạ ion IP.
Thiết kế kết hợp đơn giản giữa chiếc đồng hồ thông thường với vẻ ngoài táo bạo, phù hợp cho mọi hoạt động ngoài trời hàng ngày. Vỏ mặt trước và sau của đồng hồ được làm bằng vật liệu nhựa sinh học, dây vải được làm bằng vật liệu chai nhựa tái chế. Những vật liệu này được kỳ vọng sẽ đóng góp vào giảm thiệt hại cho môi trường.
PRG-601YB mới này đi kèm với bộ ba cảm biến phát hiện những thay đổi trong môi trường tự nhiên của bạn (phương vị, áp suất khí quyển/nhiệt độ) và tough solar , tạo ra năng lượng điện từ ánh sáng.
', '2024-01-01 00:01:44', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRT-B50YT-1', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu mẫu đồng hồ dây đeo titan mới cho dòng sản phẩm PRT-B50 của PRO TREK cùng công nghệ Bộ tứ cảm biến (phương vị, độ cao/áp suất khí quyển, nhiệt độ, bộ đếm bước chân) và Kết nối điện thoại thông minh.
Dây đeo của mẫu đồng hồ mới được làm từ chất liệu hợp kim titan nhẹ, có khả năng chống gỉ cao và ít gây dị ứng kim loại. Đây là chiếc đồng hồ được thiết kế và chế tạo cho các hoạt động ngoài trời và cả trong cuộc sống thường ngày.
PRT-B50T sở hữu tông màu cơ bản, với điểm nhấn là kim giây và kim chỉ hướng bắc trên phần gờ lớn có màu cam, giúp tăng cường khả năng hiển thị và tạo nên nét phá cách thú vị.
Mặt đồng hồ đa chiều với các chữ số Ả Rập lớn cho phép người dùng đọc giờ một cách nhanh chóng trong khi các chi tiết bằng kim loại lại tạo nên ấn tượng về một vẻ ngoài đẳng cấp và sang trọng.
Phần nắp sau được chế tạo bằng chất liệu nhựa cao cấp pha lẫn sợi thủy tinh gọn nhẹ, chắc chắn cùng cấu trúc kết hợp các vấu lồi nối dây đeo và bộ phận bảo vệ nút chống lỗi thao tác. Cả hai tính năng này đều góp phần tạo nên vẻ ngoài mạnh mẽ cho mẫu đồng hồ. Gờ xoay lớn thuận tiện cho các hoạt động ngoài trời, ngay cả khi đeo găng tay, đồng thời tôn lên nét phóng khoáng, cá tính cho thiết kế.
', '2024-01-01 00:01:45', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRT-B50T-7', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu mẫu đồng hồ dây đeo titan mới cho dòng sản phẩm PRT-B50 của PRO TREK cùng công nghệ Bộ tứ cảm biến (phương vị, độ cao/áp suất khí quyển, nhiệt độ, bộ đếm bước chân) và Kết nối điện thoại thông minh.
Dây đeo của mẫu đồng hồ mới được làm từ chất liệu hợp kim titan nhẹ, có khả năng chống gỉ cao và ít gây dị ứng kim loại. Đây là chiếc đồng hồ được thiết kế và chế tạo cho các hoạt động ngoài trời và cả trong cuộc sống thường ngày.
PRT-B50T sở hữu tông màu cơ bản, với điểm nhấn là kim giây và kim chỉ hướng bắc trên phần gờ lớn có màu cam, giúp tăng cường khả năng hiển thị và tạo nên nét phá cách thú vị.
Mặt đồng hồ đa chiều với các chữ số Ả Rập lớn cho phép người dùng đọc giờ một cách nhanh chóng trong khi các chi tiết bằng kim loại lại tạo nên ấn tượng về một vẻ ngoài đẳng cấp và sang trọng.
Phần nắp sau được chế tạo bằng chất liệu nhựa cao cấp pha lẫn sợi thủy tinh gọn nhẹ, chắc chắn cùng cấu trúc kết hợp các vấu lồi nối dây đeo và bộ phận bảo vệ nút chống lỗi thao tác. Cả hai tính năng này đều góp phần tạo nên vẻ ngoài mạnh mẽ cho mẫu đồng hồ. Gờ xoay lớn thuận tiện cho các hoạt động ngoài trời, ngay cả khi đeo găng tay, đồng thời tôn lên nét phóng khoáng, cá tính cho thiết kế.
', '2024-01-01 00:01:46', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-650YL-3', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Mẫu đồng hồ theo chủ đề hang động này chính là sản phẩm mới nhất của PRO TREK, dòng đồng hồ ngoài trời không ngừng áp dụng những công nghệ mới nhất cùng thiết kế đột phá.
Mẫu đồng hồ này sở hữu sắc màu đen tuyền như bóng tối dưới lòng đất, với những điểm nhấn bằng màu cam và màu vàng thường xuất hiện trên những bộ quần áo thám hiểm hang động. Các vạch giờ và ký hiệu trên đường gờ được nhúng chất liệu dạ quang để bạn có thể dễ dàng đọc trong bóng tối. Vòng kẹp cố định dây đeo bằng kim loại thép không gỉ được mạ ion (IP) phù hợp với thiết kế màu đen của đồng hồ cũng như góp phần nâng cao độ bền.
Dây đeo của PRG-600YB được chế tạo từ chất liệu vải MAXIFRESH* giúp khử mùi hôi và sự hình thành vi khuẩn từ mồ hôi, giúp giảm đáng kể mùi mồ hôi khó chịu.
Các chức năng nâng cao bao gồm Cảm biến bộ ba (phương vị, độ cao/áp suất khí quyển, nhiệt độ) và nhiều hơn nữa.
', '2024-01-01 00:01:47', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-600YB-1', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Mẫu đồng hồ theo chủ đề hang động này chính là sản phẩm mới nhất của PRO TREK, dòng đồng hồ ngoài trời không ngừng áp dụng những công nghệ mới nhất cùng thiết kế đột phá.
Mẫu đồng hồ này sở hữu sắc màu đen tuyền như bóng tối dưới lòng đất, với những điểm nhấn bằng màu cam và màu vàng thường xuất hiện trên những bộ quần áo thám hiểm hang động. Các vạch giờ và ký hiệu trên đường gờ được nhúng chất liệu dạ quang để bạn có thể dễ dàng đọc trong bóng tối. Vòng kẹp cố định dây đeo bằng kim loại thép không gỉ được mạ ion (IP) phù hợp với thiết kế màu đen của đồng hồ cũng như góp phần nâng cao độ bền.
Dây đeo của PRG-600YB được chế tạo từ chất liệu vải MAXIFRESH* giúp khử mùi hôi và sự hình thành vi khuẩn từ mồ hôi, giúp giảm đáng kể mùi mồ hôi khó chịu.
Các chức năng nâng cao bao gồm Cảm biến bộ ba (phương vị, độ cao/áp suất khí quyển, nhiệt độ) và nhiều hơn nữa.
', '2024-01-01 00:01:48', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-300-1A2DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu Cảm biến bộ ba phiên bản 3, công nghệCASIOchính hãng tiên tiến giúp thu nhỏ cảm biến tới 95% so với các mẫu trước đó thành một loại PRO TREK nhỏ gọn hoàn toàn mới. Mặc dù kích cỡ bé hơn nhưng các cảm biến mới thuộc các mẫu này có khả năng đọc chính xác hơn và giúp tiết kiệm năng lượng hơn.
Những mẫu Cảm biến bộ ba này cung cấp các chỉ số về cao độ, áp suất khí quyển và hướng với độ chính xác cao hơn các mẫu trước đó và Cảnh báo xu hướng áp suất khí áp kế sẽ báo cho người đeo về những thay đổi chỉ số áp suất đột ngột.
Các đặc điểm thiết kế bao gồm một vỏ dành riêng cho trang thiết bị du lịch ngoài trời. Các nút bên lớn và khả năng truy cập một lần bấm vào các thông số la bàn số, áp suất khí quyển, cao độ và nhiệt độ, đảm bảo thông tin luôn sẵn sàng trong tầm tay bạn.
Các tính năng khác bao gồm Tough Solar , khả năng chống nước ở độ sâu 100 mét và nhiều tính năng khác nữa. Mọi thứ về các mẫu đồng hồ này được thiết kế và chế tạo sao cho chúng trở thành bộ phận thiết yếu phù hợp với trang thiết bị du lịch ngoài trời.
', '2024-01-01 00:01:49', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-260-2DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Các mô hình TRIPLE SENSOR mới này có các nút chuyên dụng cho phép truy cập vào hướng, phong vũ biểu và đọc độ cao chỉ bằng một nút bấm. Khung thép không gỉ tạo ra một thiết kế sắc nét và mạnh mẽ.
Các chức năng hữu ích khác bao gồm thời gian mặt trời mọc và mặt trời lặn, Giờ thế giới 48 thành phố, phát năng lượng mặt trời Tough từ ánh sáng có sẵn và tính năng Auto Light chiếu sáng màn hình mỗi khi đồng hồ nghiêng về phía mặt để đọc.
Chống nước 200m.
Tough Solar đảm bảo hoạt động ổn định ngay cả khi sử dụng các chức năng ngốn điện.
Bộ cảm biến ba: La bàn, áp kế / nhiệt kế, đo độ cao.
', '2024-01-01 00:01:50', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-240-5DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu các màu mới của mẫu PRG-240 Tough Solar và Cảm biến bộ ba cho dòng sản phẩm đồng hồ PRO TREK dành cho các hoạt động nghiêm túc ngoài trời.
Dây đeo tông màu trái đất kaki và màu be của cát tạo nên vẻ ngoài hoàn hảo cho đồng hồ đeo tay ngoài trời.
Sử dụng màu cam và màu vàng cho hai nút phía trước, và chọn phần chữ của gờ được lắp vào để hiển thị rõ hơn.
Một màn hình LCD hai lớp có thể hiển thị đồng thời các loại dữ liệu khác nhau kết hợp với một vòng bảo vệ để chỉ báo hướng đơn giản tạo nên một thiết kế thiết thực.
Tinh thể lỏng hai lớp giúp hiển thị con trỏ la bàn màu xanh dương phủ trên màn hình hiển thị giờ hiện hành hiện tại, cho tính linh hoạt vượt trội.
Các chức năng la bàn, đo áp suất khí quyển/độ cao và nhiệt độ chạy bằng hệ thống Tough Solar giúp duy trì hoạt động của các chức năng ngay cả khi chỉ tiếp xúc với lượng ánh sáng nhỏ.
Cải tiến cách sắp xếp các nút lớn kích hoạt la bàn, đo áp suất khí quyển/độ cao và nhiệt độ cho phép thao tác một chạm ngay cả khi đeo găng tay.
Bộ phận bảo vệ nút bao bọc bề mặt bên ngoài của nút bằng nhựa để tránh xảy ra hoạt động sai.
Ngoài tính thiết thực và vô cùng hữu dụng, các mẫu PRG-240 này còn được thiết kế để dễ dàng kết hợp với thời trang ngoài trời ngày nay.
', '2024-01-01 00:01:51', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-240-3DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Giới thiệu các màu mới của mẫu PRG-240 Tough Solar và Cảm biến bộ ba cho dòng sản phẩm đồng hồ PRO TREK dành cho các hoạt động nghiêm túc ngoài trời.
Dây đeo tông màu trái đất kaki và màu be của cát tạo nên vẻ ngoài hoàn hảo cho đồng hồ đeo tay ngoài trời.
Sử dụng màu cam và màu vàng cho hai nút phía trước, và chọn phần chữ của gờ được lắp vào để hiển thị rõ hơn.
Một màn hình LCD hai lớp có thể hiển thị đồng thời các loại dữ liệu khác nhau kết hợp với một vòng bảo vệ để chỉ báo hướng đơn giản tạo nên một thiết kế thiết thực.
Tinh thể lỏng hai lớp giúp hiển thị con trỏ la bàn màu xanh dương phủ trên màn hình hiển thị giờ hiện hành hiện tại, cho tính linh hoạt vượt trội.
Các chức năng la bàn, đo áp suất khí quyển/độ cao và nhiệt độ chạy bằng hệ thống Tough Solar giúp duy trì hoạt động của các chức năng ngay cả khi chỉ tiếp xúc với lượng ánh sáng nhỏ.
Cải tiến cách sắp xếp các nút lớn kích hoạt la bàn, đo áp suất khí quyển/độ cao và nhiệt độ cho phép thao tác một chạm ngay cả khi đeo găng tay.
Bộ phận bảo vệ nút bao bọc bề mặt bên ngoài của nút bằng nhựa để tránh xảy ra hoạt động sai.
Ngoài tính thiết thực và vô cùng hữu dụng, các mẫu PRG-240 này còn được thiết kế để dễ dàng kết hợp với thời trang ngoài trời ngày nay.
', '2024-01-01 00:01:52', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-30-5DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đây là ba mẫu bổ sung mới cỡ trung cho dòng đồng hồ đeo tay ngoài trời PRO TREK. Vẫn giữ lại chức năng Cảm biến bộ ba và Tough Solar (chạy bằng năng lượng mặt trời),kích thước và trọng lượng của các mẫu này đã được giảm bớt giúp bạn thoải mái hơn khi sử dụng trong thời gian dài.
Các nút truy cập trực tiếp vào các phép đo của Cảm biến bộ ba nằm dọc bên phải vỏ và tên chức năng cho từng nút được đánh dấu trên gờ giúp bạn thao tác trơn tru và không gặp lỗi.
Màn hình hiển thị sử dụng phông chữ đậm hơn giúp bạn dễ đọc thời gian hiện tại và các thông tin hiển thị khác hơn, ngay cả khi màn hình được chiếu sáng.
', '2024-01-01 00:01:53', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-30-2DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đây là ba mẫu bổ sung mới cỡ trung cho dòng đồng hồ đeo tay ngoài trời PRO TREK. Vẫn giữ lại chức năng Cảm biến bộ ba và Tough Solar (chạy bằng năng lượng mặt trời),kích thước và trọng lượng của các mẫu này đã được giảm bớt giúp bạn thoải mái hơn khi sử dụng trong thời gian dài.
Các nút truy cập trực tiếp vào các phép đo của Cảm biến bộ ba nằm dọc bên phải vỏ và tên chức năng cho từng nút được đánh dấu trên gờ giúp bạn thao tác trơn tru và không gặp lỗi.
Màn hình hiển thị sử dụng phông chữ đậm hơn giúp bạn dễ đọc thời gian hiện tại và các thông tin hiển thị khác hơn, ngay cả khi màn hình được chiếu sáng.
', '2024-01-01 00:01:54', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-30-1DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Đây là ba mẫu bổ sung mới cỡ trung cho dòng đồng hồ đeo tay ngoài trời PRO TREK. Vẫn giữ lại chức năng Cảm biến bộ ba và Tough Solar (chạy bằng năng lượng mặt trời),kích thước và trọng lượng của các mẫu này đã được giảm bớt giúp bạn thoải mái hơn khi sử dụng trong thời gian dài.
Các nút truy cập trực tiếp vào các phép đo của Cảm biến bộ ba nằm dọc bên phải vỏ và tên chức năng cho từng nút được đánh dấu trên gờ giúp bạn thao tác trơn tru và không gặp lỗi.
Màn hình hiển thị sử dụng phông chữ đậm hơn giúp bạn dễ đọc thời gian hiện tại và các thông tin hiển thị khác hơn, ngay cả khi màn hình được chiếu sáng.
', '2024-01-01 00:01:55', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-601YB-2DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'PRO TREK Climber - Dòng thiết bị ngoài trời dành cho những người yêu thích thiên nhiên – phát hành mẫu dây đeo vải mới PRG-601YB, được làm bằng vật liệu thân thiện với môi trường.
Vạch chỉ giờ 3D trên mặt số. Chữ số font Ả Rập và khung bezel bằng thép không gỉ mạ ion IP.
Thiết kế kết hợp đơn giản giữa chiếc đồng hồ thông thường với vẻ ngoài táo bạo, phù hợp cho mọi hoạt động ngoài trời hàng ngày. Vỏ mặt trước và sau của đồng hồ được làm bằng vật liệu nhựa sinh học, dây vải được làm bằng vật liệu chai nhựa tái chế. Những vật liệu này được kỳ vọng sẽ đóng góp vào giảm thiệt hại cho môi trường.
PRG-601YB mới này đi kèm với bộ ba cảm biến phát hiện những thay đổi trong môi trường tự nhiên của bạn (phương vị, áp suất khí quyển/nhiệt độ) và tough solar, tạo ra năng lượng điện từ ánh sáng.
', '2024-01-01 00:01:56', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-601YB-3DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'PRO TREK Climber - Dòng thiết bị ngoài trời dành cho những người yêu thích thiên nhiên – phát hành mẫu dây đeo vải mới PRG-601YB, được làm bằng vật liệu thân thiện với môi trường.
Vạch chỉ giờ 3D trên mặt số. Chữ số font Ả Rập và khung bezel bằng thép không gỉ mạ ion IP.
Thiết kế kết hợp đơn giản giữa chiếc đồng hồ thông thường với vẻ ngoài táo bạo, phù hợp cho mọi hoạt động ngoài trời hàng ngày. Vỏ mặt trước và sau của đồng hồ được làm bằng vật liệu nhựa sinh học, dây vải được làm bằng vật liệu chai nhựa tái chế. Những vật liệu này được kỳ vọng sẽ đóng góp vào giảm thiệt hại cho môi trường.
PRG-601YB mới này đi kèm với bộ ba cảm biến phát hiện những thay đổi trong môi trường tự nhiên của bạn (phương vị, áp suất khí quyển/nhiệt độ) và tough solar, tạo ra năng lượng điện từ ánh sáng.
', '2024-01-01 00:01:57', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRG-600YB-2DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'Từ dòng đồng hồ Cảm biến bộ ba PRO TREK PRG-600/650 cho phép bạn tiếp xúc với thế giới tự nhiên không ngừng biến đổi quanh mình, hãng đã cho ra mắt những mẫu này. Vỏ, dây đeo và các bộ phận chính khác có màu đen đồng nhất, trong khi những chi tiết còn lại có màu xanh hải quân.
Về chức năng, mẫu này kết hợp Cảm biến bộ ba Phiên bản 3 để cho phép độ chính xác của phép đo cao hơn và khoảng thời gian đo ngắn hơn. Các tính năng khác bao gồm: thông báo khí áp cảnh báo người đeo khi khí áp đột ngột tăng hoặc giảm đáng kể, hai đèn LED chiếu sáng riêng cho mặt đồng hồ và màn hình LCD, v.v.
Mẫu mới này bổ sung thêm hàng loạt cải tiến mới về thiết kế mà không ảnh hưởng đến bất kỳ chức năng nào của PRO TREK.
Mẫu PRG-600YB nổi bật với gờ mạ ion và có dây đeo màu xanh hải quân.
Mọi chi tiết của mẫu này đều được thiết kế và chế tạo để mang đến những chức năng và thiết kế phù hợp với hoạt động ngoài trời.
', '2024-01-01 00:01:58', 1, 6);
INSERT INTO SanPham(MaSP, TenSP, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
VALUES(NULL, 'PRT-B50-4DR', 20, 'Chiều cao x ngang vỏ: 42.5 mm x 45.9 mm', '56 g', 'Kính khoáng', 'Dây đeo bằng nhựa cao cấp', 'Chống nước ở độ sâu 200 mét', 'Quartz', 
'PRO TREK với khả năng kết hợp những thành tựu công nghệ xuất sắc nhất cùng thiết kế sáng tạo đã trở thành lựa chọn đồng hồ cho người leo núi, đi bộ đường dài, cắm trại và những người yêu thích các hoạt động ngoài trời khác. Giờ đây, dòng PRT-B50 còn bổ sung tính năng Bluetooth® cho phép trao đổi dữ liệu với điện thoại thông minh sử dụng ứng dụng PRO TREK Connected để đem lại sự tiện dụng tối ưu.
Hệ thống Bộ tứ cảm biến sử dụng các cảm biến nhỏ gọn, do vậy có thể gói gọn la bàn, cao độ kế/khí áp kế và thiết bị đo nhiệt độ, cùng với gia tốc kế theo dõi số bước chân, tất cả chỉ trong một hình dáng nhỏ gọn. Việc tính toán lượng calo sử dụng thông tin độ cao và số bước có đưa vào cả độ dốc lên và dốc xuống, và ứng dụng có ghi lại lượng calo đã đốt cháy. Ứng dụng tự động ghi lại dữ liệu độ cao mà đồng hồ đo được và thông tin về lộ trình từ hệ thống GPS của điện thoại thông minh, và bạn có thể đánh dấu điểm độ cao trong suốt lộ trình bằng tính năng Trekking Log theo cách thủ công.
Bạn cũng có thể thao tác với nút đồng hồ để ghi lại vị trí hiện tại của mình vào bộ nhớ. Sau khi bạn chuyển đến một địa điểm khác, Chỉ báo vị trí sẽ chỉ hướng và hiển thị khoảng cách đến vị trí đã đăng ký. Điều này giúp bạn dễ dàng xác định mối liên hệ giữa hai vị trí. Đây là điều rất cần thiết khi tham gia hoạt động ngoài trời.
Khả năng kết nối với điện thoại thông minh sẽ đơn giản hóa cấu hình cài đặt và tính năng Tự động điều chỉnh thời gian đảm bảo việc cài đặt thời gian luôn chính xác dù bạn đang ở đâu.
Nắp sau của đồng hồ được làm bằng nhựa nhúng sợi thủy tinh gọn nhẹ, chắc chắn có cấu trúc kết hợp các vấu lồi nối dây đeo và vỏ thành một bộ phận hợp nhất.
Đồng hồ có các bộ phận bảo vệ nút chống lỗi thao tác và được tăng cường độ bền vỏ, đây là những đặc điểm hết sức thiết yếu cho người đeo tham gia hoạt động ngoài trời.
Mặt đồng hồ rộng dùng số Ả Rập giúp người xem đọc số dễ dàng. Mặt đồng hồ kết hợp với gờ xoay lớn tạo nên thiết kế hấp dẫn cho những người yêu thích hoạt động mạo hiểm ngoài trời. Hình nón của chỉ báo phương vị cho thấy phương vị hiện tại của bạn được làm từ các bộ phận kim loại tạo nên điểm nhấn ngoài trời càng làm tôn lên thiết kế thể thao tổng thể.
Dây đeo bằng urethane có họa tiết 3D để giữ cho vòng dây đeo không bị trượt khỏi vị trí, đây cũng là một đặc điểm nữa khiến chiếc đồng hồ này phù hợp cho mục đích sử dụng ngoài trời.
Tính năng mới kết nối Bluetooth với điện thoại thông minh của PRT-B50 cùng khả năng tùy chỉnh chế độ khiến mẫu đồng hồ này là lựa chọn hoàn hảo cho các hoạt động ngoài trời.
', '2024-01-01 00:01:59', 1, 6);
--
-- GiaSanPham
-- G-Shock 20
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 9500000, 30, '2024-01-02', '2024-07-01', 1);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 10117000, 20, '2024-01-02', '2024-07-01', 2);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 12363000, 10, '2024-01-02', '2024-07-01', 3);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 19000000, 0, '2024-01-02', '2024-07-01', 4);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3628000, 0, '2024-01-02', '2024-07-01', 5);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3628000, 0, '2024-01-02', '2024-07-01', 6);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5256000, 0, '2024-01-02', '2024-07-01', 7);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5256000, 0, '2024-01-02', '2024-07-01', 8);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 6046000, 0, '2024-01-02', '2024-07-01', 9);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 19864000, 0, '2024-01-02', '2024-07-01', 10);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 19864000, 0, '2024-01-02', '2024-07-01', 11);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 19864000, 0, '2024-01-02', '2024-07-01', 12);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 19864000, 0, '2024-01-02', '2024-07-01', 13);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 10882000, 0, '2024-01-02', '2024-07-01', 14);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7872000, 0, '2024-01-02', '2024-07-01', 15);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 8119000, 0, '2024-01-02', '2024-07-01', 16);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5010000, 0, '2024-01-02', '2024-07-01', 17);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4072000, 0, '2024-01-02', '2024-07-01', 18);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5454000, 0, '2024-01-02', '2024-07-01', 19);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 45661000, 0, '2024-01-02', '2024-07-01', 20);
-- Baby-G 20
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4072000, 30, '2024-01-02', '2024-07-01', 21);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4145000, 20, '2024-01-02', '2024-07-01', 22);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4343000, 10, '2024-01-02', '2024-07-01', 23);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2937000, 0, '2024-01-02', '2024-07-01', 24);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3628000, 0, '2024-01-02', '2024-07-01', 25);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3628000, 0, '2024-01-02', '2024-07-01', 26);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3628000, 0, '2024-01-02', '2024-07-01', 27);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3628000, 0, '2024-01-02', '2024-07-01', 28);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2764000, 0, '2024-01-02', '2024-07-01', 29);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2764000, 0, '2024-01-02', '2024-07-01', 30);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2764000, 0, '2024-01-02', '2024-07-01', 31);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2764000, 0, '2024-01-02', '2024-07-01', 32);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2764000, 0, '2024-01-02', '2024-07-01', 33);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2764000, 0, '2024-01-02', '2024-07-01', 34);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4343000, 0, '2024-01-02', '2024-07-01', 35);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4343000, 0, '2024-01-02', '2024-07-01', 36);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3899000, 0, '2024-01-02', '2024-07-01', 37);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4136000, 0, '2024-01-02', '2024-07-01', 38);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2937000, 0, '2024-01-02', '2024-07-01', 39);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4145000, 0, '2024-01-02', '2024-07-01', 40);
-- Edifice 20
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 6909000, 30, '2024-01-02', '2024-07-01', 41);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 6909000, 20, '2024-01-02', '2024-07-01', 42);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 15545000, 10, '2024-01-02', '2024-07-01', 43);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 15545000, 0, '2024-01-02', '2024-07-01', 44);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3529000, 0, '2024-01-02', '2024-07-01', 45);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4713000, 0, '2024-01-02', '2024-07-01', 46);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3529000, 0, '2024-01-02', '2024-07-01', 47);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3529000, 0, '2024-01-02', '2024-07-01', 48);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3529000, 0, '2024-01-02', '2024-07-01', 49);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5182000, 0, '2024-01-02', '2024-07-01', 50);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5182000, 0, '2024-01-02', '2024-07-01', 51);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 15545000, 0, '2024-01-02', '2024-07-01', 52);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 6909000, 0, '2024-01-02', '2024-07-01', 53);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5182000, 0, '2024-01-02', '2024-07-01', 54);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5626000, 0, '2024-01-02', '2024-07-01', 55);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5626000, 0, '2024-01-02', '2024-07-01', 56);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 14805000, 0, '2024-01-02', '2024-07-01', 57);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 11116000, 0, '2024-01-02', '2024-07-01', 58);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 6909000, 0, '2024-01-02', '2024-07-01', 59);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7773000, 0, '2024-01-02', '2024-07-01', 60);
-- Sheen 20
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3973000, 30, '2024-01-02', '2024-07-01', 61);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 6564000, 20, '2024-01-02', '2024-07-01', 62);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3973000, 10, '2024-01-02', '2024-07-01', 63);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5971000, 0, '2024-01-02', '2024-07-01', 64);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5108000, 0, '2024-01-02', '2024-07-01', 65);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4491000, 0, '2024-01-02', '2024-07-01', 66);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4244000, 0, '2024-01-02', '2024-07-01', 67);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5898000, 0, '2024-01-02', '2024-07-01', 68);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5454000, 0, '2024-01-02', '2024-07-01', 69);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5454000, 0, '2024-01-02', '2024-07-01', 70);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5454000, 0, '2024-01-02', '2024-07-01', 71);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5454000, 0, '2024-01-02', '2024-07-01', 72);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5404000, 0, '2024-01-02', '2024-07-01', 73);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5873000, 0, '2024-01-02', '2024-07-01', 74);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5454000, 0, '2024-01-02', '2024-07-01', 75);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 18137000, 0, '2024-01-02', '2024-07-01', 76);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4836000, 0, '2024-01-02', '2024-07-01', 77);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5971000, 0, '2024-01-02', '2024-07-01', 78);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 5971000, 0, '2024-01-02', '2024-07-01', 79);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 4836000, 0, '2024-01-02', '2024-07-01', 80);
-- General 20
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 914000, 30, '2024-01-02', '2024-07-01', 81);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 1062000, 20, '2024-01-02', '2024-07-01', 82);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 1259000, 10, '2024-01-02', '2024-07-01', 83);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 691000, 0, '2024-01-02', '2024-07-01', 84);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3553000, 0, '2024-01-02', '2024-07-01', 85);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3553000, 0, '2024-01-02', '2024-07-01', 86);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3553000, 0, '2024-01-02', '2024-07-01', 87);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3652000, 0, '2024-01-02', '2024-07-01', 88);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3381000, 0, '2024-01-02', '2024-07-01', 89);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3381000, 0, '2024-01-02', '2024-07-01', 90);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3455000, 0, '2024-01-02', '2024-07-01', 91);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 3455000, 0, '2024-01-02', '2024-07-01', 92);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 1629000, 0, '2024-01-02', '2024-07-01', 93);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 1451000, 0, '2024-01-02', '2024-07-01', 94);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 466000, 0, '2024-01-02', '2024-07-01', 95);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 492000, 0, '2024-01-02', '2024-07-01', 96);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 907000, 0, '2024-01-02', '2024-07-01', 97);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2270000, 0, '2024-01-02', '2024-07-01', 98);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2641000, 0, '2024-01-02', '2024-07-01', 99);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 2641000, 0, '2024-01-02', '2024-07-01', 100);
-- Pro Trek 20
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7353000, 30, '2024-01-02', '2024-07-01', 101);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7353000, 20, '2024-01-02', '2024-07-01', 102);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 8636000, 10, '2024-01-02', '2024-07-01', 103);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 26970000, 0, '2024-01-02', '2024-07-01', 104);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7353000, 0, '2024-01-02', '2024-07-01', 105);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 12955000, 0, '2024-01-02', '2024-07-01', 106);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 9945000, 0, '2024-01-02', '2024-07-01', 107);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 12708000, 0, '2024-01-02', '2024-07-01', 108);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 12708000, 0, '2024-01-02', '2024-07-01', 109);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 8168000, 0, '2024-01-02', '2024-07-01', 110);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 10882000, 0, '2024-01-02', '2024-07-01', 111);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 8883000, 0, '2024-01-02', '2024-07-01', 112);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 8883000, 0, '2024-01-02', '2024-07-01', 113);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7181000, 0, '2024-01-02', '2024-07-01', 114);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7181000, 0, '2024-01-02', '2024-07-01', 115);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 7181000, 0, '2024-01-02', '2024-07-01', 116);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 12091000, 0, '2024-01-02', '2024-07-01', 117);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 12091000, 0, '2024-01-02', '2024-07-01', 118);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 12708000, 0, '2024-01-02', '2024-07-01', 119);
INSERT INTO GiaSanPham(MaGSP, GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP) VALUES(NULL, 6909000, 0, '2024-01-02', '2024-07-01', 120);
--
-- Quyen
INSERT INTO Quyen(MaQuyen, TenQuyen, TrangThai) VALUES(NULL, 'Quản trị hệ thống', 1);
INSERT INTO Quyen(MaQuyen, TenQuyen, TrangThai) VALUES(NULL, 'Nhân viên', 1);
INSERT INTO Quyen(MaQuyen, TenQuyen, TrangThai) VALUES(NULL, 'Khách hàng', 1);
--
-- NguoiDung
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'admin', 'e6e061838856bf47e1de730719fb2609', 'phuphamvan411@gmail.com', 'Phạm Văn Phú', '2002-11-24', 'Nam', 'Hải Dương', '0357717404', '2024-01-01', 1, 1);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'nhanvien1', 'cf3fb234ce7ff941cd195efb4314ffab', 'nhanvien1@gmail.com', 'Nguyễn Đức Sơn', '2002-01-01', 'Nam', 'Hà Nội', '0355555555', '2024-01-01', 1,  2);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'nhanvien2', 'cf3fb234ce7ff941cd195efb4314ffab', 'nhanvien2@gmail.com', 'Trần Thu Hương', '2002-01-02', 'Nữ', 'Hà Nội', '0355555555', '2024-01-01', 1,  2);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'nhanvien3', 'cf3fb234ce7ff941cd195efb4314ffab', 'nhanvien3@gmail.com', 'Nguyễn Văn Hải', '2002-01-03', 'Nam', 'Hà Nội', '0355555555', '2024-01-01', 1,  2);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'nhanvien4', 'cf3fb234ce7ff941cd195efb4314ffab', 'nhanvien4@gmail.com', 'Nguyễn Văn Test', '2002-01-03', 'Nam', 'Hà Nội', '0355555555', '2024-01-01', 1,  2);

INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'dung1', 'baa315d1a1f98129b71994166bdb6c59', 'dung1@gmail.com', 'Phùng Văn Dũng', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'trang1', '3c314176d50e6a32171d15abd2e1688e', 'trang1@gmail.com', 'Nguyễn Thị Trang', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-011', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'cuong1', 'fa29799a4f2bfebf830259941fd2f82d', 'cuong1@gmail.com', 'Nguyễn Văn Cường', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'trung1', 'b126b4afc691b312122a9035908215f8', 'trung1@gmail.com', 'Nguyễn Thành Trung', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'hoang1', 'efe9d7d8e75506117e50d4e15bd31e63', 'hoang1@gmail.com', 'Phạm Đức Hoàng', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'phuong1', 'e3d7ac0e6d3fc54f058b11b62cf01bf8', 'phuong1@gmail.com', 'Nguyễn Mai Phương', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'hoai1', '376ac6a23a0bd740fec0a541ad440305', 'hoai1@gmail.com', 'Nguyễn Thu Hoài', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'maihoa1', 'bb8ed11de38bd0e6448637d6c26ca07d', 'hoa1@gmail.com', 'Phí Mai Hoa', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'thanhdat1', '814ce77b4282dc6cb5b6c026765776ed', 'dat1@gmail.com', 'Nguyễn Thành Đạt', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'thang1', '1305a50d13fec3427d9b41b62ae5312e', 'thang1@gmail.com', 'Vũ Xuân Thắng', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'linh1', 'd625fb801b0d6ef506c31b7b98057379', 'linh1@gmail.com', 'Nguyễn Thị Linh', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
INSERT INTO NguoiDung(MaND, TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) VALUES(NULL, 'manh1', 'fcf6de84a0d7a0fad259002bbdcc2a2a', 'manh1@gmail.com', 'Bùi Văn Mạnh', '1970-01-01', 'Nam', 'Việt Nam', '0123456789', '2023-10-01', 1,  3);
--
-- TinTuc 20
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Điểm danh 6 mẫu đồng hồ Casio nữ dây da màu hồng cực ngọt', '2024-04-01 00:01:00', 'text', 1, 3, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Top 5 đồng hồ Casio có Bluetooth mới ra mắt năm 2021', '2024-04-01 00:02:00', 'text', 1, 2, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Đồng hồ Casio Bluetooth là gì, cách sử dụng như thế nào?', '2024-04-01 00:03:00', 'text', 1, 4, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Có gì ở 2 mẫu đồng hồ Casio vintage LA-11WR-5A và B640WMR-5A mới ra mắt?', '2024-04-01 00:04:00', 'text', 1, 3, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Gợi ý các mẫu đồng hồ điện tử giá rẻ dành cho nam, nữ sinh viên năng động', '2024-04-01 00:05:00', 'text', 1, 2, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Giới thiệu mẫu đồng hồ G-Shock hợp tác Rubik’s GAE-2100RC-1', '2024-04-01 00:06:00', 'text', 1, 4, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Bộ sưu tập đồng hồ Casio G-Squad GBD-h1000 không thể bỏ lỡ', '2024-04-01 00:07:00', 'text', 1, 3, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Chọn đồng hồ theo phong thủy: Đồng hồ cho người mệnh Kim', '2024-04-01 00:08:00', 'text', 1, 2, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Lộ diện các “Siêu chiến binh Saiya” sở hữu G-Shock Dragon Ball Z', '2024-04-01 00:09:00', 'text', 1, 4, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Giới thiệu 02 mẫu đồng hồ G-Shock GA-2100 mới ra mắt 2024', '2024-04-01 00:10:00', 'text', 1, 3, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Cực ngầu với đồng hồ G-Shock 35 năm đen nhám Big Bang Black', '2024-04-01 00:11:00', 'text', 1, 2, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Bộ sưu tập G-Shock Glacier Gold: đong đầy cảm xúc hoài cổ', '2024-04-01 00:12:00', 'text', 1, 4, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Casio ra mắt sự hợp tác của Quỹ G-Shock-Surfrider', '2024-04-01 00:13:00', 'text', 1, 3, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Mãn nhãn với màn trình diễn của biệt đội Tam Sư và Sư Tử Teranga', '2024-04-01 00:14:00', 'text', 1, 2, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Casio ra mắt Edifice mới kết hợp các tính năng thiết kế từ xe đua NISMO Ace', '2024-04-01 00:15:00', 'text', 1, 4, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Casio phát hành dòng G-Shock Recrystallized công nghệ deep-layer hardening trên thép không gỉ siêu bền chắc', '2024-04-01 00:16:00', 'text', 1, 3, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Casio phát hành G-Squad mới được trang bị máy đo nhịp tim, dựa trên kiểu dáng chiếc G-Shock đầu tiên', '2024-04-01 00:17:00', 'text', 1, 2, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Casio phát hành MR-G có thiết kế bất đối xứng', '2024-04-01 00:18:00', 'text', 1, 4, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Casio phát hành EDIFICE đầu tiên hợp tác cùng MUGEN', '2024-04-01 00:19:00', 'text', 1, 3, 3);
INSERT INTO TinTuc(MaTT, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(NULL, 'Bộ sưu tập đồng hồ thể thao G-Shock G-Squad mới nhất – DW-H5600', '2024-04-01 00:20:00', 'text', 1, 2, 3);
--
-- HoaDonNhap 10
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00 ', 1, 2, 1);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 2, 2);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 2, 3);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 3, 4);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 3, 5);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 3, 6);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 4, 7);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 4, 8);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 4, 9);
-- INSERT INTO HoaDonNhap(MaHDN, NgayNhap, TrangThai, MaND, MaNCC) VALUES(NULL, '2024-01-3 00:00:00', 1, 4, 10);
--
-- CTHoaDonNhap
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 1000000, 1, 1);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 2000000, 2, 2);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 1000000, 3, 3);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 2000000, 4, 4);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 1000000, 5, 5);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 2000000, 6, 6);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 1000000, 7, 7);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 2000000, 8, 8);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 1000000, 9, 9);
-- INSERT INTO CTHoaDonNhap(MaCTHDN, SoLuong, GiaNhap, MaSP, MaHDN) VALUES(NULL, 10, 2000000, 10, 10);
--
-- Setting 
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Tên website', 'NAME_WEB', 'Văn Phú Casio');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Favicon website', 'FAVICON', '');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Logo website', 'LOGO', '');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Email liên hệ', 'EMAIL', 'phuphamvan411@gmail.com');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Số điện thoại liên hệ', 'PHONE', '0357717404');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Địa chỉ liên hệ', 'ADDRESS', 'Số 2/24/441, Điện Biên Phủ, P. Bình Hàn, TP. Hải Dương');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Đường dẫn backend', 'LINK_BE', 'https://localhost:44301');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Mật khẩu nhân viên', 'PASSWORD_STAFF', 'nhanvien@123');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Thời gian làm việc', 'WORKING_TIME', 'Thứ Hai - Thứ Sáu / 8:00 - 18:00');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Bản quyền website', 'COPYRIGHT', 'Bản quyền thuộc về Văn Phú Casio - Developed by PHUVANDEV.');
INSERT INTO Setting(MaSetting, TenSetting, KyHieu, MoTa) VALUES (NULL, 'Tên miền', 'DOMAIN', 'https://casio.vanphu.com');
-- ----------------------------------------END--------------------------------------------------------------
-- ----------------------------------------END--------------------------------------------------------------
-- --------------------------------------THỦ TỤC------------------------------------------------------------
-- USE WebVPC;
-- Setting (getALL) - admin  --CALL sp_getall_setting_admin(1, 10, '');
DELIMITER // 
CREATE PROCEDURE sp_getall_setting_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenSetting VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM Setting s WHERE (p_TenSetting IS NULL OR s.TenSetting LIKE CONCAT('%', p_TenSetting, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY s.MaSetting DESC) AS RowNumber, s.* FROM Setting s
            WHERE  (p_TenSetting IS NULL OR s.TenSetting LIKE CONCAT('%', p_TenSetting, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
// 
DELIMITER ;
-- Setting (getone)
DELIMITER //
CREATE PROCEDURE sp_getone_setting(IN p_MaSetting INT)
BEGIN
    SELECT * FROM Setting WHERE MaSetting = p_MaSetting;
END;
//
DELIMITER ;
-- Setting (getbykyhieu) CALL sp_getbysign_setting('NAMEWEB');
DELIMITER //
CREATE PROCEDURE sp_getbysign_setting(IN p_KyHieu VARCHAR(20))
BEGIN
    SELECT * FROM Setting WHERE KyHieu = p_KyHieu;
END;
//
DELIMITER ;
-- Setting (create)
DELIMITER //
CREATE PROCEDURE sp_create_setting(IN p_TenSetting VARCHAR(100),
									IN p_KyHieu VARCHAR(20),
									IN p_Anh LONGBLOB,
									IN p_MoTa TEXT)
BEGIN
	INSERT INTO Setting(TenSetting, KyHieu, Anh, MoTa) VALUES (p_TenSetting, p_KyHieu, p_Anh, p_MoTa);
END;
//
DELIMITER ;
-- Setting (update)
DELIMITER //
CREATE PROCEDURE sp_update_setting(IN p_MaSetting INT,
									IN p_TenSetting VARCHAR(100),
                                    IN p_KyHieu VARCHAR(20),
									IN p_Anh LONGBLOB,
									IN p_MoTa TEXT)
BEGIN
    UPDATE Setting SET TenSetting = IFNULL(p_TenSetting, TenSetting),
						KyHieu = IFNULL(p_KyHieu, KyHieu),
						Anh = IFNULL(p_Anh, Anh),
						MoTa = IFNULL(p_MoTa, MoTa)
    WHERE MaSetting = p_MaSetting;
END;
//
DELIMITER ;
-- Setting (delete)
DELIMITER //
CREATE PROCEDURE sp_delete_setting(IN p_MaSetting INT)
BEGIN
    DELETE FROM Setting WHERE MaSetting = p_MaSetting;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- Menu (getAll) - client
DELIMITER //
CREATE PROCEDURE sp_getall_menu_client()
BEGIN
    SELECT * FROM Menu WHERE TrangThai = 1;
END;
//
DELIMITER ;
-- Menu (getAll) - admin
DELIMITER //
CREATE PROCEDURE sp_getall_menu_admin()
BEGIN
    SELECT * FROM Menu;
END;
//
DELIMITER ;
-- Menu (getone)
DELIMITER //
CREATE PROCEDURE sp_getone_menu(IN p_MaMenu INT)
BEGIN
	SELECT * FROM Menu
    WHERE MaMenu = p_MaMenu;
END;
//
DELIMITER ;
-- Menu (update)
DELIMITER //
CREATE PROCEDURE sp_update_menu(IN p_MaMenu INT,
								IN p_TenMenu VARCHAR(100),
                                IN p_Link TEXT,
                                IN p_TrangThai TINYINT)
BEGIN
    UPDATE Menu SET TenMenu = IFNULL(p_TenMenu, TenMenu),
					Link = IFNULL(p_Link, Link),
                    TrangThai = IFNULL(p_TrangThai, TrangThai)
    WHERE MaMenu = p_MaMenu;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- Slide (getAll) - client
DELIMITER // 
CREATE PROCEDURE sp_getall_slide_client()
BEGIN
    SELECT * FROM Slide WHERE TrangThai = 1;
END;
// 
DELIMITER ;
-- Slide (getAll) - admin
DELIMITER // 
CREATE PROCEDURE sp_getall_slide_admin()
BEGIN
    SELECT * FROM Slide;
END;
// 
DELIMITER ;
-- Slide (getone)
DELIMITER //
CREATE PROCEDURE sp_getone_slide(IN p_MaSlide INT)
BEGIN
	SELECT * FROM Slide WHERE MaSlide = p_MaSlide;
END;
//
DELIMITER ;
-- Slide (create)
DELIMITER //
CREATE PROCEDURE sp_create_slide(IN p_Anh LONGBLOB,
                                 IN p_TrangThai TINYINT)
BEGIN
	INSERT INTO Slide(Anh, TrangThai) VALUES(p_Anh, p_TrangThai);
END;
//
DELIMITER ;
-- Slide (update)
DELIMITER //
CREATE PROCEDURE sp_update_slide(IN p_MaSlide INT,
								 IN p_Anh LONGBLOB,
                                 IN p_TrangThai TINYINT)
BEGIN
    UPDATE Slide SET Anh = IFNULL(p_Anh, Anh),
                     TrangThai = IFNULL(p_TrangThai, TrangThai)
    WHERE MaSlide = p_MaSlide;
END;
//
DELIMITER ;
-- Slide (delete)
DELIMITER //
CREATE PROCEDURE sp_delete_slide(IN p_MaSlide INT)
BEGIN
    DELETE FROM Slide WHERE MaSlide = p_MaSlide;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- Banner (getAll) - client
DELIMITER // 
CREATE PROCEDURE sp_getall_banner_client()
BEGIN
    SELECT * FROM Banner WHERE TrangThai = 1;
END;
// 
DELIMITER ;
-- Banner (getAll) - admin
DELIMITER // 
CREATE PROCEDURE sp_getall_banner_admin()
BEGIN
    SELECT * FROM Banner;
END;
// 
DELIMITER ;
-- Banner (getone)
DELIMITER //
CREATE PROCEDURE sp_getone_banner(IN p_MaBanner INT)
BEGIN
	SELECT * FROM Banner WHERE MaBanner = p_MaBanner;
END;
//
DELIMITER ;
-- Banner (create)
DELIMITER //
CREATE PROCEDURE sp_create_banner(IN p_Anh LONGBLOB,
                                 IN p_Link TEXT,
                                 IN p_TrangThai TINYINT)
BEGIN
	INSERT INTO Banner(Anh, Link, TrangThai) VALUES(p_Anh, p_Link, p_TrangThai);
END;
//
DELIMITER ;
-- Banner (update)
DELIMITER //
CREATE PROCEDURE sp_update_banner(IN p_MaBanner INT,
								 IN p_Anh LONGBLOB,
                                 IN p_Link TEXT,
                                 IN p_TrangThai TINYINT)
BEGIN
    UPDATE Banner SET Anh = IFNULL(p_Anh, Anh),
					 Link = IFNULL(p_Link, Link),
                     TrangThai = IFNULL(p_TrangThai, TrangThai)
    WHERE MaBanner = p_MaBanner;
END;
//
DELIMITER ;
-- Banner (delete)
DELIMITER //
CREATE PROCEDURE sp_delete_banner(IN p_MaBanner INT)
BEGIN
    DELETE FROM Banner WHERE MaBanner = p_MaBanner;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- GioiThieu (get - client) CALL sp_get_gioithieu_client();
DELIMITER //
CREATE PROCEDURE sp_get_gioithieu_client()
BEGIN
	SELECT gt.TieuDe, gt.NoiDung FROM GioiThieu gt INNER JOIN Menu m ON gt.MaMenu = m.MaMenu
    WHERE gt.MaGT = 1 AND m.TrangThai = 1;
END;
//
DELIMITER ;
-- GioiThieu (get - admin) CALL sp_get_gioithieu_admin();
DELIMITER //
CREATE PROCEDURE sp_get_gioithieu_admin()
BEGIN
	SELECT TieuDe, NoiDung FROM GioiThieu WHERE MaGT = 1;
END;
//
DELIMITER ;
-- GioiThieu (update)
DELIMITER //
CREATE PROCEDURE sp_update_gioithieu(IN p_TieuDe VARCHAR(100),
									 IN p_NoiDung TEXT)
BEGIN
    UPDATE GioiThieu SET TieuDe = IFNULL(p_TieuDe, TieuDe),
						 NoiDung = IFNULL(p_NoiDung, NoiDung)
    WHERE MaGT = 1;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- LienHe (get - client) CALL sp_get_lienhe_client()
DELIMITER //
CREATE PROCEDURE sp_get_lienhe_client()
BEGIN
	SELECT lh.TieuDe, lh.GoogleMap, lh.NoiDung FROM LienHe lh INNER JOIN Menu m ON lh.MaMenu = m.MaMenu
    WHERE lh.MaLH = 1 AND m.TrangThai = 1;
END;
//
DELIMITER ;
-- LienHe (get - admin) CALL sp_get_lienhe_admin()
DELIMITER //
CREATE PROCEDURE sp_get_lienhe_admin()
BEGIN
	SELECT TieuDe, GoogleMap, NoiDung FROM LienHe
    WHERE MaLH = 1;
END;
//
DELIMITER ;
-- LienHe (update)
DELIMITER //
CREATE PROCEDURE sp_update_lienhe(IN p_TieuDe VARCHAR(100),
                                  IN p_GoogleMap TEXT,
								  IN p_NoiDung TEXT)
BEGIN
    UPDATE LienHe SET TieuDe = IFNULL(p_TieuDe, TieuDe),
					  GoogleMap = IFNULL(p_GoogleMap, GoogleMap),
					  NoiDung = IFNULL(p_NoiDung, NoiDung)
    WHERE MaLH = 1;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- NhaCungCap (getAll + paginate) - admin
DELIMITER //
CREATE PROCEDURE sp_getall_nhacungcap_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenNCC VARCHAR(100))
BEGIN
    DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM NhaCungCap ncc WHERE (p_TenNCC IS NULL OR ncc.TenNCC LIKE CONCAT('%', p_TenNCC, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY MaNCC DESC) AS RowNumber, 
                   ncc.*
            FROM NhaCungCap ncc
            WHERE  (p_TenNCC IS NULL OR ncc.TenNCC LIKE CONCAT('%', p_TenNCC, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END 
//
DELIMITER ;
-- CALL sp_getall_nhacungcap_admin(1, 4);
-- NhaCungCap (getone)
DELIMITER //
CREATE PROCEDURE sp_getone_nhacungcap(IN p_MaNCC INT)
BEGIN
	SELECT * FROM NhaCungCap WHERE MaNCC = p_MaNCC;
END;
//
DELIMITER ;
-- NhaCungCap (create)
DELIMITER //
CREATE PROCEDURE sp_create_nhacungcap(IN p_TenNCC VARCHAR(100),
									  IN p_DiaChi VARCHAR(255),
                                      IN p_SDT VARCHAR(10),
									  IN p_TrangThai TINYINT)
BEGIN
	INSERT INTO NhaCungCap(TenNCC, DiaChi, SDT, TrangThai) VALUES (p_TenNCC, p_DiaChi, p_SDT, p_TrangThai);
END;
//
DELIMITER ;
-- NhaCungCap (update)
DELIMITER //
CREATE PROCEDURE sp_update_nhacungcap(IN p_MaNCC INT,
									  IN p_TenNCC VARCHAR(100),
									  IN p_DiaChi VARCHAR(255),
                                      IN p_SDT VARCHAR(10),
									  IN p_TrangThai TINYINT)
BEGIN
    UPDATE NhaCungCap SET TenNCC = IFNULL(p_TenNCC, TenNCC),
						  DiaChi = IFNULL(p_DiaChi, DiaChi),
                          SDT = IFNULL(p_SDT, SDT),
                          TrangThai = IFNULL(p_TrangThai, TrangThai)
    WHERE MaNCC = p_MaNCC;
END;
//
DELIMITER ;
-- NhaCungCap (delete)
DELIMITER //
CREATE PROCEDURE sp_delete_nhacungcap(IN p_MaNCC INT)
BEGIN
    DELETE FROM NhaCungCap WHERE MaNCC = p_MaNCC;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- DongSanPham (getALL) - client
DELIMITER // 
CREATE PROCEDURE sp_getall_dongsanpham_client()
BEGIN
    SELECT * FROM DongSanPham WHERE TrangThai = 1;
END;
// 
DELIMITER ;
-- DongSanPham (getALL) - admin  --CALL sp_getall_dongsanpham_admin(2, 4)
DELIMITER // 
CREATE PROCEDURE sp_getall_dongsanpham_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenDSP VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM DongSanPham dsp WHERE (p_TenDSP IS NULL OR dsp.TenDSP LIKE CONCAT('%', p_TenDSP, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY dsp.MaDSP DESC) AS RowNumber, dsp.* FROM DongSanPham dsp
            WHERE  (p_TenDSP IS NULL OR dsp.TenDSP LIKE CONCAT('%', p_TenDSP, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
// 
DELIMITER ;
-- DongSanPham (getone) CALL sp_getone_dongsanpham(5)
DELIMITER //
CREATE PROCEDURE sp_getone_dongsanpham(IN p_MaDSP INT)
BEGIN
    SELECT * FROM DongSanPham WHERE MaDSP = p_MaDSP AND TrangThai = 1;
END;
//
DELIMITER ;
-- DongSanPham (create)
DELIMITER //
CREATE PROCEDURE sp_create_dongsanpham(IN p_TenDSP VARCHAR(100),
									   IN p_Logo LONGBLOB,
                                       IN p_TrangThai TINYINT)
BEGIN
	INSERT INTO DongSanPham(TenDSP, Logo, TrangThai) VALUES (p_TenDSP, p_Logo, p_TrangThai);
END;
//
DELIMITER ;
-- DongSanPham (update)
DELIMITER //
CREATE PROCEDURE sp_update_dongsanpham(IN p_MaDSP INT,
									   IN p_TenDSP VARCHAR(100),
									   IN p_Logo LONGBLOB,
                                       IN p_TrangThai TINYINT)
BEGIN
    UPDATE DongSanPham SET TenDSP = IFNULL(p_TenDSP, TenDSP),
						   Logo = IFNULL(p_Logo, Logo),
						   TrangThai = IFNULL(p_TrangThai, TrangThai)
    WHERE MaDSP = p_MaDSP;
END;
//
DELIMITER ;
-- DongSanPham (delete)
DELIMITER //
CREATE PROCEDURE sp_delete_dongsanpham(IN p_MaDSP INT)
BEGIN
    DELETE FROM DongSanPham WHERE MaDSP = p_MaDSP;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- SanPham (getAll + paginate) - admin
DELIMITER //
CREATE PROCEDURE sp_getall_sanpham_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenSP VARCHAR(100))
BEGIN
    DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM SanPham s WHERE (p_TenSP IS NULL OR s.TenSP LIKE CONCAT('%', p_TenSP, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY s.MaSP DESC) AS RowNumber, s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.KichThuoc, s.TrongLuong, s.MatKinh, s.ChatLieuDay, s.ChongNuoc, s.LoaiMay, s.MoTa, s.NgayTao, s.TrangThai, s.MaDSP, d.TenDSP, gsp.GiaBan,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
						ELSE 0
					END AS PhanTramGiamGia,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
						ELSE gsp.GiaBan
					END AS GiaSauGiam
            FROM SanPham s INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
							LEFT JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
            WHERE  (p_TenSP IS NULL OR s.TenSP LIKE CONCAT('%', p_TenSP, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- SanPham (getone) CALL sp_getone_sanpham(1)
DELIMITER //
CREATE PROCEDURE sp_getone_sanpham(IN p_MaSP INT)
BEGIN
    SELECT s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.KichThuoc, s.TrongLuong, s.MatKinh, s.ChatLieuDay, s.ChongNuoc, s.LoaiMay, s.MoTa, s.NgayTao, s.TrangThai, s.MaDSP, d.TenDSP, gsp.GiaBan,
        CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
			ELSE 0
		END AS PhanTramGiamGia,
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
			ELSE gsp.GiaBan
		END AS GiaSauGiam
    FROM SanPham s LEFT JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
                   INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
    WHERE s.MaSP = p_MaSP AND d.TrangThai = 1 AND s.SoLuong != 0 AND s.TrangThai = 1;
END;
//
DELIMITER ;
-- SanPham (getoneadmin) CALL sp_getone_sanpham_admin(1)
DELIMITER //
CREATE PROCEDURE sp_getone_sanpham_admin(IN p_MaSP INT)
BEGIN
    SELECT s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.KichThuoc, s.TrongLuong, s.MatKinh, s.ChatLieuDay, s.ChongNuoc, s.LoaiMay, s.MoTa, s.NgayTao, s.TrangThai, s.MaDSP, d.TenDSP, gsp.GiaBan,
        CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
			ELSE 0
		END AS PhanTramGiamGia,
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
			ELSE gsp.GiaBan
		END AS GiaSauGiam
    FROM SanPham s LEFT JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
                   INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
    WHERE s.MaSP = p_MaSP;
END;
//
DELIMITER ;
-- SanPham (getnew)
DELIMITER // 
CREATE PROCEDURE sp_getnew_sanpham(IN p_SoLuong INT)
BEGIN
    SELECT s.MaSP, s.TenSP, s. AnhDaiDien, s.SoLuong, s.TrangThai, s.MaDSP, gsp.GiaBan, 
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
			ELSE 0
		END AS PhanTramGiamGia,
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
			ELSE gsp.GiaBan
		END AS GiaSauGiam
    FROM SanPham s INNER JOIN GiaSanPham gsp ON s.MaSP  = gsp.MaSP
                    INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP		
	WHERE d.TrangThai = 1 AND s.TrangThai = 1 AND s.SoLuong != 0
    ORDER BY s.NgayTao DESC
    LIMIT p_SoLuong;
END;
//
DELIMITER ;
-- SanPham (gethot) - bán chạy
DELIMITER //
CREATE PROCEDURE sp_gethot_sanpham(IN p_SoLuong INT)
BEGIN
    SELECT s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.TrangThai, s.MaDSP, gsp.GiaBan, 
        CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
			ELSE 0
		END AS PhanTramGiamGia,
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
			ELSE gsp.GiaBan
		END AS GiaSauGiam,
        IFNULL(ct.TongSLMua, 0) AS TongSLMua
	FROM SanPham s  INNER JOIN (SELECT MaSP, SUM(SoLuong) AS TongSLMua FROM CTDonHang ctdh JOIN DonHang dh ON ctdh.MaDH = dh.MaDH
								WHERE dh.TrangThai = 5 -- Đã hoàn thành
								GROUP BY MaSP) ct ON s.MaSP = ct.MaSP -- bảng tạm ct
                    INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
                    INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
	WHERE d.TrangThai = 1 AND s.TrangThai = 1 AND s.SoLuong != 0
	ORDER BY TongSLMua DESC
	LIMIT p_SoLuong;
END; 
//
DELIMITER ;
-- SanPham (getsale) - khuyến mãi
DELIMITER //
CREATE PROCEDURE sp_getsale_sanpham(IN p_SoLuong INT)
BEGIN
    SELECT s.MaSP, s.TenSP, s. AnhDaiDien, s.SoLuong, s.TrangThai, s.MaDSP, gsp.GiaBan, 
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
			ELSE 0
		END AS PhanTramGiamGia,
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
			ELSE gsp.GiaBan
		END AS GiaSauGiam
    FROM SanPham s 	INNER JOIN GiaSanPham gsp ON s.MaSP  = gsp.MaSP
                    INNER JOIN DongSanPham  d ON s.MaDSP = d.MaDSP	
	WHERE d.TrangThai = 1 AND s.TrangThai = 1 AND s.SoLuong != 0
	ORDER BY gsp.PhanTramGiamGia DESC, s.NgayTao DESC
	LIMIT p_SoLuong;
END
//
DELIMITER ;
-- SanPham (sameCategory) call sp_getsamecategory_sanpham(6)
DELIMITER // 
CREATE PROCEDURE sp_getsamecategory_sanpham(IN p_MaDSP INT,
											IN p_MaSP INT)
BEGIN
    SELECT s.MaSP, s.TenSP, s. AnhDaiDien, s.SoLuong, s.TrangThai, s.MaDSP, gsp.GiaBan, 
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
			ELSE 0
		END AS PhanTramGiamGia,
		CASE
			WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
			ELSE gsp.GiaBan
		END AS GiaSauGiam
    FROM SanPham s INNER JOIN GiaSanPham gsp ON s.MaSP  = gsp.MaSP
                    INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP		
	WHERE s.TrangThai = 1 AND s.SoLuong != 0 AND s.MaSP != p_MaSP AND s.MaDSP = p_MaDSP AND d.TrangThai = 1
    ORDER BY s.NgayTao DESC
    LIMIT 8;
END;
//
DELIMITER ;
-- SanPham (search)
DELIMITER // 
CREATE PROCEDURE sp_search_sanpham(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenSP VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM SanPham s INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
						WHERE (p_TenSP IS NULL OR s.TenSP LIKE CONCAT('%', p_TenSP, '%')) AND s.TrangThai = 1 AND s.SoLuong != 0 AND d.TrangThai = 1);
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY s.NgayTao DESC) AS RowNumber, s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.TrangThai, s.MaDSP, d.TenDSP, gsp.GiaBan,  
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
						ELSE 0
					END AS PhanTramGiamGia,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
						ELSE gsp.GiaBan
					END AS GiaSauGiam
            FROM SanPham s INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
							INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
			WHERE  (p_TenSP IS NULL OR s.TenSP LIKE CONCAT('%', p_TenSP, '%')) AND s.TrangThai = 1 AND s.SoLuong != 0 AND d.TrangThai = 1
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- SanPham (getByDsp + paginate) CALL sp_get_sanpham_by_dongsanpham(1, 10, 1, 10000000, null, 'Đi tắm (5 ATM)');
DELIMITER //
CREATE PROCEDURE sp_get_sanpham_by_dongsanpham(
    IN p_pageIndex INT, 
    IN p_pageSize INT, 
    IN p_MaDSP INT,
    IN p_MinGia INT,
    IN p_MaxGia INT,
    IN p_ChongNuoc VARCHAR(100)
)
BEGIN
    DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    
    SET RecordCount = (SELECT COUNT(*) 
                       FROM SanPham s 
                       INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
                       INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP 
                       WHERE s.MaDSP = p_MaDSP 
						 AND d.TrangThai = 1
                         AND s.TrangThai = 1 
                         AND s.SoLuong != 0
                         AND (
                             (p_MinGia IS NULL AND p_MaxGia IS NULL) OR
                             (p_MinGia IS NOT NULL AND p_MaxGia IS NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) >= p_MinGia) OR
                             (p_MinGia IS NULL AND p_MaxGia IS NOT NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) <= p_MaxGia) OR
                             ((gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) BETWEEN p_MinGia AND p_MaxGia)
                         )
                         AND (p_ChongNuoc IS NULL OR s.ChongNuoc LIKE CONCAT('%', p_ChongNuoc, '%'))
                      );

    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;

        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY s.NgayTao DESC) AS RowNumber, 
                   s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.ChongNuoc, s.TrangThai, s.MaDSP, gsp.GiaBan,
                   CASE
                       WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
                       ELSE 0
                   END AS PhanTramGiamGia,
                   CASE
                       WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
                       ELSE gsp.GiaBan
                   END AS GiaSauGiam
            FROM SanPham s 
            INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
            INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
            WHERE s.MaDSP = p_MaDSP 
			  AND d.TrangThai = 1
              AND s.TrangThai = 1 
              AND s.SoLuong != 0
              AND (
                  (p_MinGia IS NULL AND p_MaxGia IS NULL) OR
                  (p_MinGia IS NOT NULL AND p_MaxGia IS NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) >= p_MinGia) OR
                  (p_MinGia IS NULL AND p_MaxGia IS NOT NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) <= p_MaxGia) OR
                  ((gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) BETWEEN p_MinGia AND p_MaxGia)
              )
              AND (p_ChongNuoc IS NULL OR s.ChongNuoc LIKE CONCAT('%', p_ChongNuoc, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- SanPham (filterbypriceasc)
DELIMITER // 
CREATE PROCEDURE sp_filterbypriceasc(IN p_pageIndex INT, 
									IN p_pageSize INT,
                                    IN p_MaDSP INT,
									IN p_MinGia INT,
									IN p_MaxGia INT,
									IN p_ChongNuoc VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM SanPham s INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP 
														INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP WHERE s.MaDSP = p_MaDSP 
																											AND d.TrangThai = 1
																											AND s.TrangThai = 1 
																											AND s.SoLuong != 0
																											AND (
																												 (p_MinGia IS NULL AND p_MaxGia IS NULL) OR
																												 (p_MinGia IS NOT NULL AND p_MaxGia IS NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) >= p_MinGia) OR
																												 (p_MinGia IS NULL AND p_MaxGia IS NOT NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) <= p_MaxGia) OR
																												 ((gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) BETWEEN p_MinGia AND p_MaxGia)
																											 )
																											 AND (p_ChongNuoc IS NULL OR s.ChongNuoc LIKE CONCAT('%', p_ChongNuoc, '%'))
																										  );
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY 
                CASE
                    WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
                    ELSE gsp.GiaBan
                END ASC
            ) AS RowNumber, 
            s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.ChongNuoc, s.TrangThai, s.MaDSP, d.TenDSP, gsp.GiaBan,  
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
						ELSE 0
					END AS PhanTramGiamGia,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
						ELSE gsp.GiaBan
					END AS GiaSauGiam
            FROM SanPham s INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
							INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
			WHERE 		s.MaDSP = p_MaDSP 
					AND d.TrangThai = 1
					AND s.TrangThai = 1 
					AND s.SoLuong != 0
					AND (
						  (p_MinGia IS NULL AND p_MaxGia IS NULL) OR
						  (p_MinGia IS NOT NULL AND p_MaxGia IS NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) >= p_MinGia) OR
						  (p_MinGia IS NULL AND p_MaxGia IS NOT NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) <= p_MaxGia) OR
						  ((gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) BETWEEN p_MinGia AND p_MaxGia)
					  )
					  AND (p_ChongNuoc IS NULL OR s.ChongNuoc LIKE CONCAT('%', p_ChongNuoc, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- SanPham (filterbypricedesc)
DELIMITER // 
CREATE PROCEDURE sp_filterbypricedesc(IN p_pageIndex INT, 
									IN p_pageSize INT,
                                    IN p_MaDSP INT,
									IN p_MinGia INT,
									IN p_MaxGia INT,
									IN p_ChongNuoc VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM SanPham s INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
													  INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP WHERE s.MaDSP = p_MaDSP 
																											AND d.TrangThai = 1
																											AND s.TrangThai = 1 
																											AND s.SoLuong != 0
																											AND (
																												 (p_MinGia IS NULL AND p_MaxGia IS NULL) OR
																												 (p_MinGia IS NOT NULL AND p_MaxGia IS NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) >= p_MinGia) OR
																												 (p_MinGia IS NULL AND p_MaxGia IS NOT NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) <= p_MaxGia) OR
																												 ((gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) BETWEEN p_MinGia AND p_MaxGia)
																											 )
																											 AND (p_ChongNuoc IS NULL OR s.ChongNuoc LIKE CONCAT('%', p_ChongNuoc, '%'))
																											);
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY 
                CASE
                    WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
                    ELSE gsp.GiaBan
                END DESC
            ) AS RowNumber,
            s.MaSP, s.TenSP, s.AnhDaiDien, s.SoLuong, s.ChongNuoc, s.TrangThai, s.MaDSP, d.TenDSP, gsp.GiaBan,  
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
						ELSE 0
					END AS PhanTramGiamGia,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
						ELSE gsp.GiaBan
					END AS GiaSauGiam
            FROM SanPham s INNER JOIN DongSanPham d ON s.MaDSP = d.MaDSP
							INNER JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
			WHERE 		s.MaDSP = p_MaDSP 
					AND d.TrangThai = 1
					AND s.TrangThai = 1 
					AND s.SoLuong != 0
					AND (
						  (p_MinGia IS NULL AND p_MaxGia IS NULL) OR
						  (p_MinGia IS NOT NULL AND p_MaxGia IS NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) >= p_MinGia) OR
						  (p_MinGia IS NULL AND p_MaxGia IS NOT NULL AND (gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) <= p_MaxGia) OR
						  ((gsp.GiaBan * (100 - gsp.PhanTramGiamGia) / 100) BETWEEN p_MinGia AND p_MaxGia)
					  )
					  AND (p_ChongNuoc IS NULL OR s.ChongNuoc LIKE CONCAT('%', p_ChongNuoc, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;


-- SanPham (getwithoutprice) CALL sp_getwithoutprice_sanpham(1, 10, '');
DELIMITER // 
CREATE PROCEDURE sp_getwithoutprice_sanpham(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenSP VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM SanPham s LEFT JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP WHERE gsp.MaGSP IS NULL);
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY s.MaSP DESC) AS RowNumber, s.MaSP, s.TenSP, gsp.GiaBan,  
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
						ELSE 0
					END AS PhanTramGiamGia,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
						ELSE gsp.GiaBan
					END AS GiaSauGiam
            FROM SanPham s LEFT JOIN GiaSanPham gsp ON s.MaSP = gsp.MaSP
			WHERE  (p_TenSP IS NULL OR s.TenSP LIKE CONCAT('%', p_TenSP, '%')) AND gsp.MaGSP IS NULL
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- SanPham(create)
DELIMITER //
CREATE PROCEDURE sp_create_sanpham(p_TenSP VARCHAR(100), p_AnhDaiDien LONGBLOB, p_KichThuoc VARCHAR(100), p_TrongLuong VARCHAR(100),
                                   p_MatKinh VARCHAR(100), p_ChatLieuDay VARCHAR(100), p_ChongNuoc VARCHAR(100), p_LoaiMay VARCHAR(100),
								   p_MoTa TEXT, p_TrangThai TINYINT, p_MaDSP INT)
BEGIN
	INSERT INTO SanPham(TenSP, AnhDaiDien, SoLuong, KichThuoc, TrongLuong, MatKinh, ChatLieuDay, ChongNuoc, LoaiMay, MoTa, NgayTao, TrangThai, MaDSP)
	VALUES (p_TenSP, p_AnhDaiDien, 0, p_KichThuoc, p_TrongLuong, p_MatKinh, p_ChatLieuDay, p_ChongNuoc, p_LoaiMay, p_MoTa, NOW(), p_TrangThai, p_MaDSP);
END;
//
DELIMITER ;
-- SanPham(update)
DELIMITER //
CREATE PROCEDURE sp_update_sanpham(p_MaSP INT, p_TenSP VARCHAR(100), p_AnhDaiDien LONGBLOB, p_KichThuoc VARCHAR(100), p_TrongLuong VARCHAR(100),
                                   p_MatKinh VARCHAR(100), p_ChatLieuDay VARCHAR(100), p_ChongNuoc VARCHAR(100), p_LoaiMay VARCHAR(100),
								   p_MoTa TEXT, p_TrangThai TINYINT, p_MaDSP INT)
BEGIN
	UPDATE  SanPham SET TenSP = IFNULL(p_TenSP, TenSP),
						AnhDaiDien = IFNULL(p_AnhDaiDien, AnhDaiDien),
                        KichThuoc = IFNULL(p_KichThuoc, KichThuoc),
                        TrongLuong = IFNULL(p_TrongLuong, TrongLuong),
                        MatKinh = IFNULL(p_MatKinh, MatKinh),
                        ChatLieuDay = IFNULL(p_ChatLieuDay, ChatLieuDay),
                        ChongNuoc = IFNULL(p_ChongNuoc, ChongNuoc),
                        LoaiMay = IFNULL(p_LoaiMay, LoaiMay),
						MoTa = IFNULL(p_MoTa, MoTa),
						TrangThai = IFNULL(p_TrangThai, TrangThai),
						MaDSP = IFNULL(p_MaDSP, MaDSP)
    WHERE MaSP = p_MaSP;
END;
//
DELIMITER ;
-- SanPham(delete)
DELIMITER //
CREATE PROCEDURE sp_delete_sanpham(p_MaSP INT)
BEGIN
	DELETE FROM SanPham WHERE MaSP = p_MaSP;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- GiaSanPham (getAll + paginate) - admin CALL sp_getall_giasanpham_admin(1, 4, 'ga')
DELIMITER //
CREATE PROCEDURE sp_getall_giasanpham_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenSP VARCHAR(100))
BEGIN
    DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM GiaSanPham gsp INNER JOIN SanPham s ON gsp.MaSP = s.MaSP
						WHERE  (p_TenSP IS NULL OR s.TenSP LIKE CONCAT('%', p_TenSP, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY gsp.MaGSP DESC) AS RowNumber, gsp.MaGSP, s.MaSP, s.TenSP, s.AnhDaiDien, gsp.GiaBan, gsp.NgayBD, gsp.NgayKT,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN gsp.PhanTramGiamGia
						ELSE 0
					END AS PhanTramGiamGia,
					CASE
						WHEN gsp.PhanTramGiamGia IS NOT NULL AND NOW() BETWEEN gsp.NgayBD AND gsp.NgayKT THEN ROUND(gsp.GiaBan * ((100 - gsp.PhanTramGiamGia) / 100), 0)
						ELSE gsp.GiaBan
					END AS GiaSauGiam
            FROM GiaSanPham gsp INNER JOIN SanPham s ON gsp.MaSP = s.MaSP
            WHERE  (p_TenSP IS NULL OR s.TenSP LIKE CONCAT('%', p_TenSP, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- GiaSanPham(create)
DELIMITER //
CREATE PROCEDURE sp_create_giasanpham (p_GiaBan INT,
									   p_PhanTramGiamGia INT,
									   p_NgayBD DATETIME,
                                       p_NgayKT DATETIME,
									   p_MaSP INT)
BEGIN
	INSERT INTO GiaSanPham(GiaBan, PhanTramGiamGia, NgayBD, NgayKT, MaSP)
	VALUES (p_GiaBan, p_PhanTramGiamGia, p_NgayBD, p_NgayKT, p_MaSP);
END;
//
DELIMITER ;
-- GiaSanPham(update)
DELIMITER //
CREATE PROCEDURE sp_update_giasanpham (p_MaGSP	INT, 
									   p_GiaBan INT,
									   p_PhanTramGiamGia INT,
									   p_NgayBD DATETIME,
                                       p_NgayKT DATETIME,
									   p_MaSP INT)
BEGIN
	UPDATE  GiaSanPham SET  GiaBan = IFNULL(p_GiaBan, GiaBan),
							PhanTramGiamGia = IFNULL(p_PhanTramGiamGia, PhanTramGiamGia),
							NgayBD = IFNULL(p_NgayBD, NULL),
							NgayKT = IFNULL(p_NgayKT, NULL),
							MaSP = IFNULL(p_MaSP, MaSP)
    WHERE MaGSP = p_MaGSP;
END;
//
DELIMITER ;
-- GiaSanPham(delete)
DELIMITER //
CREATE PROCEDURE sp_delete_giasanpham(p_MaGSP INT)
BEGIN
	DELETE FROM GiaSanPham WHERE MaGSP = p_MaGSP;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- TinTuc (getAll + paginate) - client CALL sp_getall_tintuc_client(1, 10)
DELIMITER //
CREATE PROCEDURE sp_getall_tintuc_client(IN p_pageIndex INT, IN p_pageSize INT)
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM TinTuc tt INNER JOIN Menu m ON tt.MaMenu = m.MaMenu
										WHERE tt.TrangThai = 1 AND m.TrangThai = 1);
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY tt.NgayDang DESC) AS RowNumber, tt.MaTT, tt.AnhDaiDien, tt.TieuDe, tt.NgayDang, tt.NoiDung, tt.TrangThai, nd.HoTen
            FROM TinTuc tt INNER JOIN NguoiDung nd ON tt.MaND = nd.MaND
							INNER JOIN Menu m ON tt.MaMenu = m.MaMenu
            WHERE tt.TrangThai = 1 AND m.TrangThai = 1
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- TinTuc (getAll + paginate) - admin
DELIMITER // 
CREATE PROCEDURE sp_getall_tintuc_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_TieuDe VARCHAR(200))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM TinTuc tt WHERE (p_TieuDe IS NULL OR tt.TieuDe LIKE CONCAT('%', p_TieuDe, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY tt.MaTT DESC) AS RowNumber, tt.MaTT, tt.AnhDaiDien, tt.TieuDe, tt.NgayDang, tt.NoiDung, tt.TrangThai, nd.HoTen
            FROM TinTuc tt INNER JOIN NguoiDung nd ON tt.MaND = nd.MaND
            WHERE  (p_TieuDe IS NULL OR tt.TieuDe LIKE CONCAT('%', p_TieuDe, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- TinTuc (getOne) CALL sp_getone_tintuc(1)
DELIMITER //
CREATE PROCEDURE sp_getone_tintuc(IN p_MaTT INT)
BEGIN
    SELECT tt.MaTT, tt.AnhDaiDien, tt.TieuDe, tt.NgayDang, tt.NoiDung, tt.TrangThai, nd.HoTen
	FROM TinTuc tt INNER JOIN NguoiDung nd ON tt.MaND  = nd.MaND	
					INNER JOIN Menu m ON tt.MaMenu = m.MaMenu
    WHERE  tt.MaTT = p_MaTT AND tt.TrangThai = 1 AND m.TrangThai = 1;
END;
//
DELIMITER ;
-- TinTuc (random) call sp_getrandom_tintuc(6, 4)
DELIMITER // 
CREATE PROCEDURE sp_getrandom_tintuc(IN p_MaTT INT, IN p_SoLuong INT)
BEGIN
    SELECT tt.MaTT, tt.AnhDaiDien, tt.TieuDe, tt.NgayDang, nd.HoTen
    FROM TinTuc tt INNER JOIN NguoiDung nd ON tt.MaND  = nd.MaND	
					INNER JOIN Menu m ON tt.MaMenu = m.MaMenu
    WHERE tt.TrangThai = 1 AND m.TrangThai = 1 AND tt.MaTT != p_MaTT
    ORDER BY RAND()
    LIMIT p_SoLuong;
END;
//
DELIMITER ;
-- TinTuc (create)
DELIMITER //
CREATE PROCEDURE sp_create_tintuc(IN p_AnhDaiDien LONGBLOB,
                                  IN p_TieuDe VARCHAR(200),
                                  IN p_NoiDung TEXT,
                                  IN p_TrangThai TINYINT,
                                  IN p_MaND INT)
BEGIN
	INSERT INTO TinTuc(AnhDaiDien, TieuDe, NgayDang, NoiDung, TrangThai, MaND, MaMenu) VALUES(p_AnhDaiDien, p_TieuDe, NOW(), p_NoiDung, p_TrangThai, p_MaND, 3);
END;
//
DELIMITER ;
-- TinTuc (update)
DELIMITER //
CREATE PROCEDURE sp_update_tintuc(IN p_MaTT INT,
								  IN p_AnhDaiDien LONGBLOB,
                                  IN p_TieuDe VARCHAR(200),
                                  IN p_NoiDung TEXT,
                                  IN p_TrangThai TINYINT,
                                  IN p_MaND INT)
BEGIN
    UPDATE TinTuc SET AnhDaiDien = IFNULL(p_AnhDaiDien, AnhDaiDien),
					  TieuDe = IFNULL(p_TieuDe, TieuDe),
                      NoiDung = IFNULL(p_NoiDung, NoiDung),
					  TrangThai = IFNULL(p_TrangThai, TrangThai),
                      MaND = IFNULL(p_MaND, MaND)
    WHERE MaTT = p_MaTT;
END;
//
DELIMITER ;
-- TinTuc (delete)
DELIMITER //
CREATE PROCEDURE sp_delete_tintuc(IN p_MaTT INT)
BEGIN
    DELETE FROM TinTuc WHERE MaTT = p_MaTT;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- DonHang (getAll + paginate) CALL sp_getall_donhang_admin(1, 5, '');
DELIMITER //
CREATE PROCEDURE sp_getall_donhang_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_TenKH VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM DonHang dh WHERE (p_TenKH IS NULL OR dh.TenKH LIKE CONCAT('%', p_TenKH, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY dh.MaDH DESC) AS RowNumber, dh.*, 
            CAST(SUM(ctdh.SoLuong * ctdh.GiaBan) AS signed) AS TongTien
            FROM DonHang dh INNER JOIN CTDonHang ctdh ON dh.MaDH = ctdh.MaDH
            WHERE  (p_TenKH IS NULL OR dh.TenKH LIKE CONCAT('%', p_TenKH, '%'))
			GROUP BY dh.MaDH
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- DonHang (create) -- TrangThai 0: chưa xác thực, 1: đã xác thực, 2: đã hủy, 3: đã thanh toán, 4: đang vận chuyển, 5: đã hoàn thành
DELIMITER //
CREATE PROCEDURE sp_create_donhang (IN p_TenKH VARCHAR(100),  
									IN p_Email VARCHAR(100),
									IN p_DiaChiGiaoHang VARCHAR(255),
                                    IN p_SDT VARCHAR(10),
                                    IN p_GhiChu TEXT,
                                    IN p_PhuongThucThanhToan VARCHAR(100),
                                    IN p_TrangThai TINYINT,
                                    IN p_MaND INT,
                                    IN p_listjson_chitietdonhang JSON)
BEGIN
	DECLARE p_DonHangID INT;
    INSERT INTO DonHang(TenKH, Email, DiaChiGiaoHang, SDT, GhiChu, NgayDat, PhuongThucThanhToan, TrangThai, MaND) 
    VALUES (p_TenKH, p_Email, p_DiaChiGiaoHang, p_SDT, p_GhiChu, NOW(), p_PhuongThucThanhToan, p_TrangThai, p_MaND);             
	SET p_DonHangID = (SELECT LAST_INSERT_ID());
    --
    IF p_listjson_chitietdonhang IS NOT NULL THEN
    DROP TABLE IF EXISTS Results;
	CREATE TEMPORARY TABLE Results AS
		SELECT   	
			JSON_VALUE(p.value, '$.soLuong') soLuong,
			JSON_VALUE(p.value, '$.giaBan') giaBan,
            JSON_VALUE(p.value, '$.maSP') maSP
			FROM JSON_TABLE( p_listjson_chitietdonhang, '$[*]' COLUMNS (value JSON PATH '$')) AS p	;	
		 
		INSERT INTO CTDonHang(SoLuong, GiaBan, MaSP, MaDH)
			SELECT p.soLuong, p.giaBan, p.maSP, p_DonHangID FROM Results p;       
		DROP TABLE Results;  
	END IF;             
END;
//
DELIMITER ;
-- DonHang (getOneNew)
DELIMITER //
CREATE PROCEDURE sp_getonenew_donhang()
BEGIN
	SELECT MaDH FROM DonHang ORDER BY MaDH DESC LIMIT 1;
END;
//
DELIMITER ;
-- Nhân viên xác thực đơn hàng
DELIMITER // 
CREATE PROCEDURE sp_check_donhang(IN p_MaDH INT,
								  IN p_TrangThai TINYINT)
BEGIN
    UPDATE DonHang SET TrangThai = IFNULL(p_TrangThai, TrangThai)
    WHERE MaDH = p_MaDH;
END;
// 
DELIMITER ;
-- Tài khoản -> lịch sử mua hàng (getByNguoiDung) CALL sp_get_purchase_history_by_nguoidung(1, 10, 5);
DELIMITER //
CREATE PROCEDURE sp_get_purchase_history_by_nguoidung(IN p_pageIndex INT, IN p_pageSize INT, IN p_MaND INT)
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM DonHang dh INNER JOIN NguoiDung nd ON dh.MaND = nd.MaND
										WHERE nd.MaND = p_MaND);
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY dh.MaDH DESC) AS RowNumber, dh.MaDH, dh.TenKH, dh.Email, dh.DiaChiGiaoHang, dh.SDT, dh.GhiChu, dh.NgayDat, dh.PhuongThucThanhToan,
			CAST(SUM(ctdh.SoLuong * ctdh.GiaBan) AS signed) AS TongTien, dh.TrangThai
			FROM DonHang dh INNER JOIN NguoiDung nd ON dh.MaND = nd.MaND
							INNER JOIN CTDonHang ctdh ON dh.MaDH = ctdh.MaDH
			WHERE nd.MaND = p_MaND
			GROUP BY dh.MaDH, dh.TenKH, dh.Email, dh.DiaChiGiaoHang, dh.SDT, dh.GhiChu, dh.NgayDat, dh.PhuongThucThanhToan, dh.TrangThai 
			ORDER BY dh.NgayDat DESC
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- DonHang (getOne) CALL sp_getone_donhang(15)
DELIMITER //
CREATE PROCEDURE sp_getone_donhang(IN p_MaDH INT)
BEGIN
    SELECT dh.* ,
    CAST(SUM(ctdh.SoLuong * ctdh.GiaBan) AS signed) AS TongTien FROM DonHang dh INNER JOIN CTDonHang ctdh ON dh.MaDH = ctdh.MaDH
    WHERE dh.MaDH = p_MaDH
    GROUP BY dh.MaDH;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- CTDonHang (getByDonHang) CALL sp_get_ctdonhang_by_donhang(1)
DELIMITER // 
CREATE PROCEDURE sp_get_ctdonhang_by_donhang(IN p_MaDH INT)
BEGIN
    SELECT dh.MaDH, dh.TenKH, dh.Email, dh.DiaChiGiaoHang, dh.SDT, dh.GhiChu, dh.NgayDat, dh.PhuongThucThanhToan, dh.TrangThai,
		   ctdh.MaCTDH, ctdh.SoLuong, ctdh.GiaBan, ctdh.MaSP, sp.TenSP, sp.AnhDaiDien,
           (SELECT SUM(SoLuong) FROM CTDonHang WHERE dh.MaDH = p_MaDH) AS TongSoLuong
	FROM CTDonHang ctdh INNER JOIN DonHang dh ON ctdh.MaDH = dh.MaDH
						INNER JOIN SanPham sp ON ctdh.MaSP = sp.MaSP
	WHERE dh.MaDH = p_MaDH;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- HoaDonNhap (getALL + paginate) CALL sp_getall_hoadonnhap_admin(1, 10, '')
DELIMITER // 
CREATE PROCEDURE sp_getall_hoadonnhap_admin(IN p_pageIndex INT, 
											IN p_pageSize INT, 
                                            IN p_TenNCC VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
                        
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM HoaDonNhap hdn INNER JOIN NhaCungCap ncc ON hdn.MaNCC = ncc.MaNCC
						WHERE (p_TenNCC IS NULL OR ncc.TenNCC LIKE CONCAT('%', p_TenNCC, '%')));
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY hdn.MaHDN DESC) AS RowNumber, hdn.*, nd.HoTen, ncc.TenNCC,
										CAST(SUM(cthdn.SoLuong * cthdn.GiaNhap) AS signed) AS TongTien
            FROM HoaDonNhap hdn INNER JOIN NguoiDung nd ON hdn.MaND = nd.MaND
								INNER JOIN NhaCungCap ncc ON hdn.MaNCC = ncc.MaNCC
                                INNER JOIN CTHoaDonNhap cthdn ON hdn.MaHDN = cthdn.MaHDN
            WHERE  (p_TenNCC IS NULL OR ncc.TenNCC LIKE CONCAT('%', p_TenNCC, '%'))
            GROUP BY hdn.MaHDN
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
// 
DELIMITER ;
-- HoaDonNhap (create) 
DELIMITER //
CREATE PROCEDURE sp_create_hoadonnhap (IN p_MaND INT,
									   IN p_MaNCC INT,
                                       IN p_listjson_chitiethoadonnhap JSON)
BEGIN
	DECLARE p_HoaDonNhapID INT;
    
    INSERT INTO HoaDonNhap(NgayNhap, TrangThai, MaND, MaNCC) VALUES (NOW(), 1, p_MaND, p_MaNCC);             
    SET p_HoaDonNhapID = (SELECT LAST_INSERT_ID());
    --
    IF p_listjson_chitiethoadonnhap IS NOT NULL THEN
    DROP TABLE IF EXISTS Results;
	CREATE TEMPORARY TABLE Results AS
		SELECT   	
			JSON_VALUE(p.value, '$.soLuong') soLuong,
			JSON_VALUE(p.value, '$.giaNhap') giaNhap,
            JSON_VALUE(p.value, '$.maSP') maSP
			FROM JSON_TABLE(p_listjson_chitiethoadonnhap, '$[*]' COLUMNS (value JSON PATH '$')) AS p;

		INSERT INTO CTHoaDonNhap(SoLuong, GiaNhap, MaSP, MaHDN)
			SELECT p.soLuong, p.giaNhap, p.maSP, p_HoaDonNhapID FROM Results p;
		DROP TABLE Results;
	END IF;    
END;
//
DELIMITER ;
-- HoaDonNhap (getOne)
DELIMITER //
CREATE PROCEDURE sp_getone_hoadonnhap(IN p_MaHDN INT) 
BEGIN
	SELECT * FROM HoaDonNhap WHERE MaHDN = p_MaHDN;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- CTHoaDonNhap(getByHDN) CALL sp_get_cthoadonnhap_by_hoadonnhap(2)
DELIMITER //
CREATE PROCEDURE sp_get_cthoadonnhap_by_hoadonnhap(p_MaHDN INT)
BEGIN
	SELECT cthdn.*, s.TenSP, s.AnhDaiDien 
    FROM CTHoaDonNhap cthdn INNER JOIN SanPham s ON cthdn.MaSP = s.MaSP
	WHERE MaHDN = p_MaHDN;
END; 
//
DELIMITER ;
-- -----------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- DangNhap CALL sp_login('admin', 'e6e061838856bf47e1de730719fb2609');
DELIMITER //
CREATE PROCEDURE sp_login(IN p_TaiKhoan VARCHAR(100),
						  IN p_MatKhau VARCHAR(255))
BEGIN
	SELECT * FROM NguoiDung 
    WHERE Taikhoan = p_TaiKhoan AND MatKhau = p_MatKhau;
END;
//
DELIMITER ;
-- NguoiDung(register) - Đăng ký cho khách hàng
DELIMITER //
CREATE PROCEDURE sp_register  (IN p_TaiKhoan VARCHAR(100),
							   IN p_MatKhau VARCHAR(255),
							   IN p_Email VARCHAR(100),
							   IN p_HoTen VARCHAR(100),
							   IN p_SDT VARCHAR(10))
BEGIN
	INSERT INTO NguoiDung(TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) 
    VALUES (p_TaiKhoan, p_MatKhau, p_Email, p_HoTen, '1970-01-01', 'Nam', 'Việt Nam', p_SDT, NOW(), 1, 3);
END;
//
DELIMITER ;
-- Kiểm tra tài khoản tồn tại
DELIMITER //
CREATE PROCEDURE sp_check_exist_register(IN p_TaiKhoan VARCHAR(100),
										IN p_Email VARCHAR(100))
BEGIN
	SELECT TaiKhoan, Email FROM NguoiDung WHERE TaiKhoan = p_TaiKhoan OR Email = p_Email;
END;
//
DELIMITER ;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- Quyen (getAll)
DELIMITER //
CREATE PROCEDURE sp_getall_quyen_admin()
BEGIN
	SELECT * FROM Quyen;
END;
//
DELIMITER ;
-- Quyen (getOne)
DELIMITER //
CREATE PROCEDURE sp_getone_quyen(IN p_MaQuyen INT)
BEGIN
	SELECT * FROM Quyen WHERE MaQuyen = p_MaQuyen;
END;
//
DELIMITER ;
-- Quyen (create)
DELIMITER //
CREATE PROCEDURE sp_create_quyen (IN p_TenQuyen VARCHAR(100), IN p_TrangThai TINYINT)
BEGIN
	INSERT INTO Quyen(TenQuyen, TrangThai) VALUES (p_TenQuyen, p_TrangThai);
END;
//
DELIMITER ;
-- Quyen (update) 
DELIMITER //
CREATE PROCEDURE sp_update_quyen (IN p_MaQuyen INT,
								  IN p_TenQuyen VARCHAR(100),
								  IN p_TrangThai TINYINT)
BEGIN
    UPDATE Quyen SET TenQuyen = IFNULL(p_TenQuyen, TenQuyen),
					     TrangThai = IFNULL(p_TrangThai, TrangThai)
    WHERE MaQuyen = p_MaQuyen;
END;
//
DELIMITER ;
-- Quyen (delete)
DELIMITER //
CREATE PROCEDURE sp_delete_quyen(IN p_MaQuyen INT)
BEGIN
    DELETE FROM Quyen WHERE MaQuyen = p_MaQuyen;
END;
//
DELIMITER ;
-- -----------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- NguoiDung (getAll + paginate) CALL sp_getall_khachhang_admin(1, 10, '')
DELIMITER //
CREATE PROCEDURE sp_getall_khachhang_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_HoTen VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM NguoiDung nd INNER JOIN Quyen q ON nd.MaQuyen = q.MaQuyen 
										WHERE q.TenQuyen = 'Khách hàng' AND (p_HoTen IS NULL OR nd.HoTen LIKE CONCAT('%', p_HoTen, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY nd.MaND DESC) AS RowNumber, nd.*, q.TenQuyen
            FROM NguoiDung nd INNER JOIN Quyen q ON nd.MaQuyen = q.MaQuyen
            WHERE  q.TenQuyen = 'Khách hàng' AND (p_HoTen IS NULL OR nd.HoTen LIKE CONCAT('%', p_HoTen, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- Nhân viên CALL sp_getall_nhanvien_admin(1, 10, '')
DELIMITER //
CREATE PROCEDURE sp_getall_nhanvien_admin(IN p_pageIndex INT, IN p_pageSize INT, IN p_HoTen VARCHAR(100))
BEGIN
	DECLARE startIndex INT;
    DECLARE endIndex INT;
    
    DECLARE RecordCount BIGINT;
    SET RecordCount = (SELECT COUNT(*) FROM NguoiDung nd INNER JOIN Quyen q ON nd.MaQuyen = q.MaQuyen 
										WHERE q.TenQuyen = 'Nhân viên' AND (p_HoTen IS NULL OR nd.HoTen LIKE CONCAT('%', p_HoTen, '%')));
    
    IF p_pageSize != 0 THEN
        SET startIndex = (p_pageIndex - 1) * p_pageSize;
        SET endIndex = startIndex + p_pageSize;
        
        SELECT *, RecordCount AS RecordCount
        FROM (
            SELECT ROW_NUMBER() OVER(ORDER BY nd.MaND DESC) AS RowNumber, nd.*, q.TenQuyen
            FROM NguoiDung nd INNER JOIN Quyen q ON nd.MaQuyen = q.MaQuyen
            WHERE  q.TenQuyen = 'Nhân viên' AND (p_HoTen IS NULL OR nd.HoTen LIKE CONCAT('%', p_HoTen, '%'))
        ) AS Results1
        WHERE RowNumber BETWEEN startIndex + 1 AND endIndex;
    END IF;
END;
//
DELIMITER ;
-- NguoiDung (getone) 
DELIMITER //
CREATE PROCEDURE sp_getone_nguoidung(IN p_MaND INT)
BEGIN
    SELECT * FROM NguoiDung WHERE MaND = p_MaND;
END;
//
DELIMITER ;
-- NguoiDung(create)
DELIMITER //
CREATE PROCEDURE sp_create_nguoidung  (IN p_TaiKhoan VARCHAR(100),
									   IN p_MatKhau VARCHAR(255),
									   IN p_Email VARCHAR(100),
									   IN p_HoTen VARCHAR(100),
                                       IN p_NgaySinh DATETIME,
                                       IN p_GioiTinh VARCHAR(100),
                                       IN p_AnhDaiDien LONGBLOB,
                                       IN p_DiaChi VARCHAR(255),
									   IN p_SDT VARCHAR(10),
                                       IN p_TrangThai INT,
                                       IN p_MaQuyen INT)
BEGIN
	INSERT INTO NguoiDung(TaiKhoan, MatKhau, Email, HoTen, NgaySinh, GioiTinh, AnhDaiDien, DiaChi, SDT, NgayThamGia, TrangThai, MaQuyen) 
    VALUES (p_TaiKhoan, p_MatKhau, p_Email, p_HoTen, p_NgaySinh, p_GioiTinh, p_AnhDaiDien, p_DiaChi, p_SDT, NOW(), p_TrangThai, p_MaQuyen);
END;
//
DELIMITER ;
-- NguoiDung(update)
DELIMITER //
CREATE PROCEDURE sp_update_nguoidung (IN p_MaND INT,
									  IN p_MatKhau VARCHAR(255),
								      IN p_HoTen VARCHAR(100),
								      IN p_NgaySinh DATETIME,
								      IN p_GioiTinh VARCHAR(100),
								      IN p_AnhDaiDien LONGBLOB,
								      IN p_DiaChi VARCHAR(255),
								      IN p_SDT VARCHAR(10),
								      IN p_TrangThai TINYINT,
								      IN p_MaQuyen INT)
BEGIN
	UPDATE  NguoiDung SET  	MatKhau = IFNULL(p_MatKhau, MatKhau),
							HoTen = IFNULL(p_HoTen, HoTen),
                            NgaySinh = IFNULL(p_NgaySinh, NgaySinh),
                            GioiTinh = IFNULL(p_GioiTinh, GioiTinh),
                            AnhDaiDien = IFNULL(p_AnhDaiDien, AnhDaiDien),
                            DiaChi = IFNULL(p_DiaChi, DiaChi),
                            SDT = IFNULL(p_SDT, SDT),
                            TrangThai = IFNULL(p_TrangThai, TrangThai),
                            MaQuyen = IFNULL(p_MaQuyen, MaQuyen)
    WHERE MaND = p_MaND;
END;
//
DELIMITER ;
-- NguoiDung(delete) 
DELIMITER //
CREATE PROCEDURE sp_delete_nguoidung (IN p_MaND INT) 
BEGIN
	DELETE FROM NguoiDung WHERE MaND = p_MaND;
END;
//
DELIMITER ;
-- -----------------------------------------------------------------------------------------------
-- --------------------------------ThongKe: statistic---------------------------------------------
-- Số lượng sp, kh, đhđtt, đhcxt, ds
DELIMITER //
CREATE PROCEDURE sp_statistic_soluong()
BEGIN
    DECLARE SoLuongSP INT;
    DECLARE SoLuongKH INT;
    
	DECLARE SoLuongDHDaHoanThanh INT;
    DECLARE SoLuongDHChuaXacThuc INT;
    
	DECLARE DoanhSo INT;
    DECLARE NamHienTai INT;
-- --
    SELECT COUNT(MaSP) INTO SoLuongSP FROM SanPham 
    WHERE SoLuong != 0 AND TrangThai = 1;
    
    SELECT COUNT(MaND) INTO SoLuongKH 
    FROM NguoiDung nd INNER JOIN Quyen q ON nd.MaQuyen = q.MaQuyen
    WHERE nd.TrangThai = 1 AND q.TenQuyen = 'Khách hàng';
    
	SELECT COUNT(MaDH) INTO SoLuongDHDaHoanThanh FROM DonHang WHERE TrangThai = 5;
    SELECT COUNT(MaDH) INTO SoLuongDHChuaXacThuc FROM DonHang WHERE TrangThai = 0;
		
	SELECT SUM(ctdh.SoLuong * ctdh.GiaBan) INTO DoanhSo 
    FROM DonHang dh INNER JOIN CTDonHang ctdh ON dh.MaDH = ctdh.MaDH
    WHERE dh.TrangThai = 5 AND YEAR(dh.NgayDat) = YEAR(CURRENT_DATE);
    SET NamHienTai = YEAR(CURRENT_DATE);

    SELECT SoLuongSP AS SoLuongSP, SoLuongKH AS SoLuongKH, SoLuongDHDaHoanThanh AS SoLuongDHDaHoanThanh, SoLuongDHChuaXacThuc AS SoLuongDHChuaXacThuc, DoanhSo AS DoanhSo, NamHienTai AS NamHienTai;
END;
//
DELIMITER ;
-- Doanh thu 12 tháng CALL sp_statistic_doanhthuthang()
DELIMITER //
CREATE PROCEDURE sp_statistic_doanhthu_12month()
BEGIN
    SELECT 
        CONCAT(MONTH(d.NgayDat), '/', YEAR(d.NgayDat)) AS ThangNam, -- CONCAT: hàm kết hợp các chuỗi
        SUM(ct.SoLuong * ct.GiaBan) AS DoanhThu
    FROM DonHang d INNER JOIN CTDonHang ct ON d.MaDH = ct.MaDH
    WHERE d.TrangThai = 5 AND d.NgayDat >= DATE_SUB(NOW(), INTERVAL 12 MONTH) -- Từ ngày hiện tại đến 12 tháng gần nhất
    GROUP BY YEAR(d.Ngaydat), MONTH(d.NgayDat), ThangNam
	ORDER BY YEAR(d.NgayDat) ASC, MONTH(d.NgayDat) ASC;
END;
//
DELIMITER ;
-- Doanh thu năm CALL sp_statistic_doanhthunam()
DELIMITER //
CREATE PROCEDURE sp_statistic_doanhthu_5year()
BEGIN
    SELECT 
        YEAR(d.NgayDat) AS Nam,
        SUM(ct.SoLuong * ct.GiaBan) AS DoanhThuNam,
        COUNT(ct.MaCTDH) AS SLSanPhamBanRa
    FROM DonHang d 
    INNER JOIN CTDonHang ct ON d.MaDH = ct.MaDH
    WHERE d.TrangThai = 5
        AND d.NgayDat >= DATE_SUB(NOW(), INTERVAL 5 YEAR) -- Từ năm hiện tại trở lại 5 năm trước
    GROUP BY YEAR(d.NgayDat)
    ORDER BY YEAR(d.NgayDat) ASC;
END;
//
DELIMITER ;
-- Dòng sản phẩm bán chạy
DELIMITER //
CREATE PROCEDURE sp_statistic_dongsanphambanchay()
BEGIN
    SELECT d.MaDSP, d.TenDSP, COUNT(ct.MaCTDH) AS SoLuongSanPhamBanRa
	FROM DongSanPham d	INNER JOIN SanPham s ON d.MaDSP = s.MaDSP
						INNER JOIN CTDonHang ct ON s.MaSP = ct.MaSP
						INNER JOIN DonHang dh ON ct.MaDH = dh.MaDH
	WHERE dh.TrangThai = 5 AND dh.NgayDat >= DATE_SUB(NOW(), INTERVAL 12 MONTH) -- Từ ngày hiện tại đến 12 tháng gần nhất
    GROUP BY d.MaDSP, d.TenDSP;
END;
//
DELIMITER ;
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Trigeer cập nhật sl sản phẩm khi thêm ct hóa đơn nhập
DELIMITER //
CREATE TRIGGER trg_update_sanpham_after_insert_cthoadonnhap
AFTER INSERT ON CTHoaDonNhap
FOR EACH ROW
BEGIN
    DECLARE product_count INT;
    -- Lấy số lượng sản phẩm hiện tại trong bảng SanPham
    SELECT SoLuong INTO product_count FROM SanPham WHERE MaSP = NEW.MaSP;
    -- Cập nhật số lượng sản phẩm mới
    UPDATE SanPham
    SET SoLuong = product_count + NEW.SoLuong
    WHERE MaSP = NEW.MaSP;
END;
//
DELIMITER ;
-- -----------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- Trigeer giảm sl sản phẩm khi trạng thái đã hoàn thành (5):
DELIMITER //
CREATE TRIGGER tr_complete_order
BEFORE UPDATE ON DonHang
FOR EACH ROW
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE tr_MaSP INT;
    DECLARE tr_SoLuong INT;

    -- Cursor để lặp qua các chi tiết đơn hàng
    DECLARE cur CURSOR FOR 
        SELECT MaSP, SoLuong 
        FROM CTDonHang
        WHERE MaDH = NEW.MaDH;

    -- Khai báo lặp
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Kiểm tra nếu trạng thái đơn hàng chuyển từ 4 (đang vận chuyển) sang 5 (đã hoàn thành)
    IF NEW.TrangThai = 5 AND OLD.TrangThai = 4 THEN
        -- Mở con trỏ để bắt đầu lặp qua các dòng dữ liệu.
        OPEN cur;
        -- Vòng lặp để duyệt qua các dòng dữ liệu của con trỏ.
        read_loop: LOOP
            -- Lấy dữ liệu từ dòng hiện tại trong con trỏ.
            FETCH cur INTO tr_MaSP, tr_SoLuong;
            -- Kiểm tra nếu không còn dòng dữ liệu nào.
            IF done THEN
                -- Thoát khỏi vòng lặp.
                LEAVE read_loop;
            END IF;

            -- Giảm số lượng sản phẩm trong bảng SanPham.
            UPDATE SanPham SET SoLuong = SoLuong - tr_SoLuong
            WHERE MaSP = tr_MaSP;
        END LOOP;
        -- Đóng con trỏ sau khi hoàn thành việc lặp.
        CLOSE cur;
    END IF;
END;
//
DELIMITER ;