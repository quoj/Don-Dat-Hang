CREATE TABLE DonDatHangnew (
    MaSoDonHang INT PRIMARY KEY,
    NguoiDatHang NVARCHAR(50),
    DiaChi NVARCHAR(100),
    DienThoai NVARCHAR(20),
    NgayDatHang DATE
);

SELECT * FROM DonDatHangnew;

CREATE TABLE MatHangnew (
    STT INT PRIMARY KEY,
    TenHang NVARCHAR(50),
    MoTaHang NVARCHAR(100),
    DonVi NVARCHAR(20),
    Gia FLOAT,
    SoLuong INT,
    ThanhTien FLOAT,
    MaSoDonHang INT,
    FOREIGN KEY (MaSoDonHang) REFERENCES DonDatHangnew(MaSoDonHang)
);

SELECT * FROM MatHangnew;

INSERT INTO DonDatHangnew (MaSoDonHang, NguoiDatHang, DiaChi, DienThoai, NgayDatHang)
VALUES (123, N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '2009-09-18'),
(213, N'Trần Đức Huy', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '2009-09-18'),
(229, N'Lê Thị Thắm', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '2009-09-18'),
(290, N'Hoàng Bảo Ngọc', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '2009-09-18');

DELETE FROM DonDatHangnew;

INSERT INTO MatHangnew (STT, TenHang, MoTaHang, DonVi, Gia, SoLuong, ThanhTien, MaSoDonHang)
VALUES
    (1, 'Máy Tính T450', 'Máy nhập mới', 'Chiếc', 1000, 1, 1000, 123),
    (2, 'Điện Thoại Nokia5670', 'Điện thoại đang hot', 'Chiếc', 200, 2, 400, 123),
    (3, 'Máy In Samsung 450', 'Máy in đang ế', 'Chiếc', 100, 1, 100, 123);

DELETE FROM MatHangnew;

SELECT NguoiDatHang, DiaChi, DienThoai FROM DonDatHangnew;
SELECT TenHang, MoTaHang, DonVi, Gia FROM MatHangnew;
SELECT * FROM DonDatHangnew;
SELECT NguoiDatHang, DiaChi, DienThoai FROM DonDatHangnew ORDER BY NguoiDatHang ASC;
SELECT TenHang, MoTaHang, DonVi, Gia FROM MatHangnew ORDER BY Gia DESC;
SELECT TenHang, MoTaHang, DonVi, Gia
FROM MatHangnew
INNER JOIN DonDatHangnew ON MatHangnew.MaSoDonHang = DonDatHangnew.MaSoDonHang
WHERE DonDatHangnew.NguoiDatHang = 'Nguyễn Văn An';

SELECT COUNT(*) AS SoKhachHang FROM DonDatHangnew;
SELECT COUNT(*) AS SoMatHang FROM MatHangnew;

SELECT MaSoDonHang, SUM(ThanhTien) AS TongTien
FROM MatHangnew
GROUP BY MaSoDonHang;

UPDATE MatHangnew
SET Gia = ABS(Gia)
WHERE Gia < 0;

UPDATE DonDatHangnew
SET NgayDatHang = GETDATE()
WHERE NgayDatHang > GETDATE();

ALTER TABLE MatHangnew
ADD NgayXuatHien DATE;

CREATE INDEX idx_TenHang ON MatHangnew(TenHang);
CREATE INDEX idx_NguoiDatHang ON DonDatHangnew(NguoiDatHang);

CREATE VIEW View_KhachHang
AS
SELECT NguoiDatHang, DiaChi, DienThoai
FROM DonDatHangnew;

CREATE VIEW View_SanPham
AS
SELECT TenHang, Gia
FROM MatHangnew;

CREATE VIEW View_KhachHang_SanPham
AS
SELECT DonDatHangnew.NguoiDatHang, DonDatHangnew.DienThoai, MatHangnew.TenHang, MatHangnew.SoLuong, DonDatHangnew.NgayDatHang
FROM DonDatHangnew
INNER JOIN MatHangnew ON DonDatHangnew.MaSoDonHang = MatHangnew.MaSoDonHang;
 
CREATE PROCEDURE