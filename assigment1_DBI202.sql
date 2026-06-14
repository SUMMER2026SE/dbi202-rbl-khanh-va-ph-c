--đề tài:Thiết kế CSDL Quản lý Tour Du Lịch

use Tourdulich


-- địa điểm du lịch.
Create Table tblDiaDiem (
    maDiaDiem   int           PRIMARY KEY,
    tenDiaDiem  nvarchar(100) NOT NULL,
    quocGia     nvarchar(50),
    moTa        nvarchar(200)
)

-- thông tin về hướng dẫn viên dẫn tour.
Create Table tblHuongDanVien (
    maHDV       varchar(10)   PRIMARY KEY,
    tenHDV      nvarchar(50)  NOT NULL,
    soDT        varchar(11),
    ngonNgu     nvarchar(50)
)

--thông tin của khách hàng đã đặt tour.
Create Table tblKhachHang (
    maKH        varchar(10)   PRIMARY KEY,
    tenKH       nvarchar(50)  NOT NULL,
    soDT        varchar(11),
    diaChi      nvarchar(100),
    email       varchar(100)
)

--thông tin về các tour du lịch.
Create Table tblTour (
    maTour      varchar(10)   PRIMARY KEY,
    tenTour     nvarchar(100) NOT NULL,
    ngayKhoiHanh date,
    ngayKetThuc  date,
    giaTour     decimal(10,0),
    SlotToiDa  int, --slot tối đa cho 1 tour là bao nhiêu người.
    maDiaDiem   int           FOREIGN KEY REFERENCES tblDiaDiem(maDiaDiem),
    maHDV       varchar(10)   FOREIGN KEY REFERENCES tblHuongDanVien(maHDV) 
    )

-- ghi lại dữ liệu của các khách hàng đã đặt tour.
 Create Table tblDatTour (
    maKH        varchar(10),
    maTour      varchar(10),
    ngayDat     date   not null,
    soNguoi     int,
    tongTien    decimal(10,0),
    trangThai   nvarchar(20),
    CONSTRAINT pk_dattour PRIMARY KEY (maKH, maTour),
    CONSTRAINT fk_dattour1 FOREIGN KEY (maKH)   REFERENCES tblKhachHang(maKH) ON UPDATE CASCADE,
    CONSTRAINT fk_dattour2 FOREIGN KEY (maTour) REFERENCES tblTour(maTour) ON UPDATE CASCADE
)

--thông tin thanh toán tour của khách hàng.
Create Table tblThanhToan (
    maThanhToan   varchar(10)     PRIMARY KEY,
    maKH          varchar(10),
    maTour        varchar(10),
    ngayThanhToan   date,
    soTien          decimal(10,0),
    hinhThuc        nvarchar(30),  -- 'Tiền mặt', 'Chuyển khoản', 'Thẻ'
 CONSTRAINT fk_tt FOREIGN KEY (maKH, maTour) REFERENCES tblDatTour(maKH, maTour)
    )

    --đánh giá tour của khách hàng sau khi du lịch.
    Create Table tblDanhGia (
    maKH        varchar(10),
    maTour      varchar(10),
    ngayDanhGia date,
    DiemSo      int,    --tu 1 den 5 sao.       
    nhanXet     nvarchar(300),
    CONSTRAINT pk_danhgia  PRIMARY KEY (maKH, maTour),
    CONSTRAINT fk_danhgia1 FOREIGN KEY (maKH)   REFERENCES tblKhachHang(maKH),
    CONSTRAINT fk_danhgia2 FOREIGN KEY (maTour) REFERENCES tblTour(maTour)
    )


    --chèn dữ liệu vào bảng.
    -- 1. tblDiaDiem
INSERT INTO tblDiaDiem (maDiaDiem, tenDiaDiem, quocGia, moTa)
VALUES
(1, N'Phú Quốc', N'Việt Nam', N'Đảo ngọc thiên đường'),
(2, N'Đà Nẵng', N'Việt Nam', N'Thành phố đáng sống nhất'),
(3, N'Hà Nội', N'Việt Nam', N'Thủ đô ngàn năm văn hiến'),
(4, N'Bangkok', N'Thái Lan', N'Thành phố không ngủ'),
(5, N'Singapore', N'Singapore', N'Đảo quốc sư tử');

-- 2. tblHuongDanVien
INSERT INTO tblHuongDanVien (maHDV, tenHDV, soDT, ngonNgu)
VALUES
('HDV001', N'Nguyễn Văn An', '0901234561', N'Tiếng Anh'),
('HDV002', N'Trần Thị Bình', '0901234562', N'Tiếng Thái'),
('HDV003', N'Lê Minh Châu', '0901234563', N'Tiếng Anh, Tiếng Trung'),
('HDV004', N'Phạm Thị Dung', '0901234564', N'Tiếng Anh'),
('HDV005', N'Hoàng Văn Em', '0901234565', N'Tiếng Nhật');

-- 3. tblKhachHang
INSERT INTO tblKhachHang (maKH, tenKH, soDT, diaChi, email)
VALUES
('KH001', N'Nguyễn Thị Lan', '0911111111', N'TP. Hồ Chí Minh', 'lan@gmail.com'),
('KH002', N'Trần Văn Bình', '0922222222', N'Hà Nội', 'binh@gmail.com'),
('KH003', N'Lê Thị Cúc', '0933333333', N'Đà Nẵng', 'cuc@gmail.com'),
('KH004', N'Phạm Văn Dũng', '0944444444', N'Cần Thơ', 'dung@gmail.com'),
('KH005', N'Vũ Thị Hoa', '0955555555', N'Hải Phòng', 'hoa@gmail.com');

-- 4. tblTour
INSERT INTO tblTour (maTour, tenTour, ngayKhoiHanh, ngayKetThuc, giaTour, SlotToiDa, maDiaDiem, maHDV)
VALUES
('T001', N'Tour Phú Quốc 4N3Đ', '2026-07-01', '2026-07-04', 5000000, 20, 1, 'HDV001'),
('T002', N'Tour Đà Nẵng 3N2Đ', '2026-07-05', '2026-07-07', 3000000, 15, 2, 'HDV002'),
('T003', N'Tour Hà Nội 2N1Đ', '2026-07-10', '2026-07-11', 2000000, 25, 3, 'HDV003'),
('T004', N'Tour Bangkok 5N4Đ', '2026-07-15', '2026-07-19', 8000000, 15, 4, 'HDV004'),
('T005', N'Tour Singapore 4N3Đ', '2026-08-01', '2026-08-04', 12000000, 10, 5, 'HDV005');

-- 5. tblDatTour
INSERT INTO tblDatTour (maKH, maTour, ngayDat, soNguoi, tongTien, trangThai)
VALUES
('KH001', 'T001', '2026-06-01', 2, 10000000, N'Đã xác nhận'),
('KH002', 'T002', '2026-06-02', 3, 9000000,  N'Đã xác nhận'),
('KH003', 'T003', '2026-06-03', 1, 2000000,  N'Chờ xác nhận'),
('KH004', 'T004', '2026-06-04', 2, 16000000, N'Đã xác nhận'),
('KH005', 'T005', '2026-06-05', 4, 48000000, N'Chờ xác nhận');

-- 6. tblThanhToan
INSERT INTO tblThanhToan (maThanhToan, maKH, maTour, ngayThanhToan, soTien, hinhThuc)
VALUES
('TT001', 'KH001', 'T001', '2026-06-02', 10000000, N'Chuyển khoản'),
('TT002', 'KH002', 'T002', '2026-06-03', 9000000,  N'Tiền mặt'),
('TT003', 'KH003', 'T003', '2026-06-04', 2000000,  N'Thẻ'),
('TT004', 'KH004', 'T004', '2026-06-05', 16000000, N'Chuyển khoản'),
('TT005', 'KH005', 'T005', '2026-06-06', 48000000, N'Tiền mặt');

-- 7. tblDanhGia
INSERT INTO tblDanhGia (maKH, maTour, ngayDanhGia, DiemSo, nhanXet)
VALUES
('KH001', 'T001', '2026-07-05', 5, N'Tour rất tuyệt, hướng dẫn viên nhiệt tình'),
('KH002', 'T002', '2026-07-08', 4, N'Khách sạn đẹp, đồ ăn ngon'),
('KH003', 'T003', '2026-07-12', 3, N'Tạm ổn, có thể cải thiện thêm'),
('KH004', 'T004', '2026-07-20', 5, N'Rất hài lòng, sẽ đi lại lần sau'),
('KH005', 'T005', '2026-08-05', 4, N'Singapore đẹp, tour được tổ chức tốt');


--truy vấn.

--Hiển thị tất cả thông tin của các tour có giá trên 5 triệu.
Select * from tblTour
Where giaTour > 5000000

--Hiển thị tên khách hàng và tên tour họ đã đặt.
Select tenKH, tenTour, ngayDat
from tblDatTour dt inner join tblKhachHang kh on dt.maKH=kh.maKH
inner join tblTour t on dt.maTour=t.maTour

--Hiển thị tên khách hàng, tên tour và hình thức thanh toán.
Select tenKH, tenTour, soTien, hinhthuc
from tblThanhToan tt inner join tblKhachHang kh on tt.maKH=kh.maKH
inner join tblTour t on tt.maTour=t.maTour

--Hiển thị tên khách hàng, tên tour, địa điểm đã được xác nhận.
Select tenKH, tenTour, tenDiaDiem, soNguoi, tongTien
from tblDatTour dt 
inner join tblKhachHang kh on dt.maKH=kh.maKH
inner join tblTour t on dt.maTour=t.maTour
inner join tblDiaDiem dd on t.maDiaDiem=dd.maDiaDiem
Where trangThai=N'Đã xác nhận'