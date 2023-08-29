CREATE TABLE DanhBanew11508 (
    HoTen NVARCHAR(50),
    DiaChi NVARCHAR(100),
    DienThoai NVARCHAR(20),
    NgaySinh DATE
);
SELECT * FROM  DanhBanew11508;

INSERT INTO DanhBanew11508 (HoTen, DiaChi, DienThoai, NgaySinh) VALUES 
('Nguyễn Văn An', 'Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '1987-11-18'),
('Hii', 'Nguyễn Trãi, Thanh Xuân, Hà Nội', '09873452', '1987-11-18'),
('Hii', 'Nguyễn Trãi, Thanh Xuân, Hà Nội', '09832323', '1987-11-18'),
('Hii', 'Nguyễn Trãi, Thanh Xuân, Hà Nội', '09434343', '1987-11-18');



SELECT HoTen FROM DanhBa;


SELECT DienThoai FROM DanhBa;


SELECT HoTen FROM DanhBa ORDER BY HoTen;

SELECT DienThoai FROM DanhBa WHERE HoTen = 'Nguyễn Văn An';


SELECT HoTen FROM DanhBa WHERE NgaySinh = '2009-12-12';



SELECT HoTen, COUNT(DienThoai) AS SoLuongSoDienThoai FROM DanhBa GROUP BY HoTen;


SELECT COUNT(*) AS TongSoNguoi FROM DanhBa WHERE MONTH(NgaySinh) = 12;


SELECT * FROM DanhBa;


SELECT * FROM DanhBa WHERE DienThoai = '123456789';



UPDATE DanhBa SET NgaySinh = GETDATE() WHERE NgaySinh < GETDATE();


- Trường khóa chính của bảng DanhBa là HoTen.
- Không có khóa ngoại trong bảng DanhBa.


ALTER TABLE DanhBa ADD NgayBatDauLienLac DATE;



CREATE INDEX IX_HoTen ON DanhBa (HoTen);
CREATE INDEX IX_SoDienThoai ON DanhBa (DienThoai);


CREATE VIEW View_SoDienThoai AS
SELECT HoTen, DienThoai FROM DanhBa;

CREATE VIEW View_SinhNhat AS
SELECT HoTen, NgaySinh, DienThoai FROM DanhBa WHERE MONTH(NgaySinh) = MONTH(GETDATE());


CREATE PROCEDURE SP_ThemDanhBa
@HoTen NVARCHAR(50),
@DiaChi NVARCHAR(100),
@DienThoai NVARCHAR(20),
@NgaySinh DATE
AS
BEGIN
    INSERT INTO DanhBa (HoTen, DiaChi, DienThoai, NgaySinh) VALUES (@HoTen, @DiaChi, @DienThoai, @NgaySinh)
END;

CREATE PROCEDURE SP_TimDanhBa
@HoTen NVARCHAR(50)
AS
BEGIN
    SELECT HoTen, DiaChi, DienThoai, NgaySinh FROM DanhBa WHERE HoTen LIKE '%' + @HoTen + '%'
END;