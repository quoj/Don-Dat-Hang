CREATE TABLE Hang (
    MaHang INT PRIMARY KEY,
    TenHang NVARCHAR(50),
    DiaChi NVARCHAR(100),
    DienThoai NVARCHAR(20)
);
SELECT * FROM Hang;


CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY,
    TenSanPham NVARCHAR(50),
    MoTaSanPham NVARCHAR(100),
    DonVi NVARCHAR(20),
    Gia FLOAT,
    SoLuong INT,
    MaHang INT,
    FOREIGN KEY (MaHang) REFERENCES Hang(MaHang)
);
SELECT * FROM SanPham;

INSERT INTO Hang (MaHang, TenHang, DiaChi, DienThoai)
VALUES (123, 'Asus', 'USA', '983232');

INSERT INTO SanPham (MaSanPham, TenSanPham, MoTaSanPham, DonVi, Gia, SoLuong, MaHang)
VALUES 
    (1, 'Máy Tính T450', 'Máy nhập mới', 'Chiếc', 1000, 200, 123),
    (2, 'Điện Thoại Nokia5670', 'Điện thoại đang hot', 'Chiếc', 200, 10, 123),
    (3, 'Máy In Samsung 450', 'Máy in đang ế', 'Chiếc', 100, 2, 123);


SELECT * FROM Hang ORDER BY TenHang DESC;

SELECT * FROM SanPham WHERE MaHang = 123 ORDER BY Gia DESC;

SELECT * FROM Hang WHERE TenHang = 'Asus';

SELECT * FROM SanPham WHERE SoLuong < 10;

SELECT * FROM SanPham WHERE MaHang = (SELECT MaHang FROM Hang WHERE TenHang = 'Asus');


SELECT COUNT(DISTINCT MaHang) FROM SanPham;


SELECT COUNT(*) FROM SanPham;


SELECT TenHang, COUNT(*) AS SoLoaiSanPham FROM SanPham JOIN Hang ON SanPham.MaHang = Hang.MaHang GROUP BY TenHang;


SELECT SUM(SoLuong) FROM SanPham;


UPDATE SanPham SET Gia =Xin lỗi vì sự thiếu sót. Dưới đây là phần tiếp theo của câu truy vấn và các yêu cầu trong bài tập MSSQL Assignment 02:


UPDATE SanPham SET Gia = Gia + 50;


UPDATE Hang SET DienThoai = '0' + SUBSTRING(DienThoai, 2, LEN(DienThoai) - 1) WHERE DienThoai NOT LIKE '0%';




CREATE INDEX idx_TenHang ON SanPham (TenSanPham);
CREATE INDEX idx_MoTaHang ON SanPham (MoTaSanPham);


CREATE VIEW SanPhamView AS
SELECT MaSanPham, TenSanPham, Gia FROM SanPham;


CREATE VIEW SanPhamHang AS
SELECT SanPham.MaSanPham, SanPham.TenSanPham, Hang.TenHang
FROM SanPham
JOIN Hang ON SanPham.MaHang = Hang.MaHang;


CREATE PROCEDURE SP_SanPham_TenHang
    @TenHang NVARCHAR(50)
AS
BEGIN
    SELECT * FROM SanPham WHERE MaHang = (SELECT MaHang FROM Hang WHERE TenHang = @TenHang);
END;

CREATE PROCEDURE SP_SanPham_Gia
    @Gia FLOAT
AS
BEGIN
    SELECT * FROM SanPham WHERE Gia >= @Gia;
END;

CREATE PROCEDURE SP_SanPham_Hethung
