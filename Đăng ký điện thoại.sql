CREATE TABLE KhachHang (
    MaKH INT PRIMARY KEY,
    TenKH NVARCHAR(50),
    SoCMT INT,
    DiaChi NVARCHAR(100)
);

SELECT * FROM KhachHang;


CREATE TABLE ThueBao (
    SoThueBao INT PRIMARY KEY,
    LoaiThueBao NVARCHAR(50),
    NgayDangKy DATE,
    MaKH INT,
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
);

SELECT * FROM ThueBao;


INSERT INTO KhachHang (MaKH, TenKH, SoCMT, DiaChi)
VALUES (1, 'Nguyễn Nguyệt Nga', 123456789, 'Hà Nội');

INSERT INTO ThueBao (SoThueBao, LoaiThueBao, NgayDangKy, MaKH)
VALUES (123456789, 'Trả trước', '2002-12-12', 1);







SELECT * FROM ThueBao WHERE SoThueBao = 0123456789;


SELECT * FROM KhachHang WHERE SoCMT = 123456789;


SELECT * FROM ThueBao WHERE MaKH IN (SELECT MaKH FROM KhachHang WHERE SoCMT = 123456789);


SELECT * FROM ThueBao WHERE NgayDangKy = '2009-12-12';


SELECT * FROM ThueBao WHERE MaKH IN (SELECT MaKH FROM KhachHang WHERE DiaChi = 'Hà Nội');



SELECT COUNT(*) FROM KhachHang;


SELECT COUNT(*) FROM ThueBao;


SELECT COUNT(*) FROM ThueBao WHERE NgayDangKy = '2009-12-12';


SELECT * FROM KhachHang JOIN ThueBao ON KhachHang.MaKH = ThueBao.MaKH;



ALTER TABLE ThueBao ALTER COLUMN NgayDangKy DATE NOT NULL;


ALTER TABLE ThueBao ADD CONSTRAINT CK_NgayDangKy CHECK (NgayDangKy <= GETDATE());


ALTER TABLE ThueBao ADD CONSTRAINT CK_SoThueBao CHECK (LEFT(CONVERT(NVARCHAR(10), SoThueBao), 2) = '09');


ALTER TABLE ThueBao ADD DiemThuong INT DEFAULT 0;



CREATE INDEX IX_TenKH ON KhachHang(TenKH);


CREATE VIEW View_KhachHang AS
SELECT MaKH, TenKH, DiaChi FROM KhachHang;

CREATE VIEW View_KhachHang_ThueBao AS
SELECT MaKH, TenKH, SoThueBao FROM KhachHang JOIN ThueBao ON KhachHang.MaKH = ThueBao.MaKH;


CREATE PROCEDURE SP_TimKH_ThueBao
    @SoThueBao INT
AS
BEGIN
    SELECT * FROM KhachHang WHERE MaKH IN (SELECT MaKH FROM ThueBao WHERE SoThueBao = @SoThueBao);
END

CREATE PROCEDURE SP_TimTB_KhachHang
    @TenKH NVARCHAR(50)
AS
BEGIN
    SELECT SoThueBao FROM ThueBao WHERE MaKH IN (SELECT MaKH FROM KhachHang WHERE TenKH = @TenKH);
END

CREATE PROCEDURE SP_ThemTB
    @MaKH INT,
    @SoThueBao INT,
    @LoaiThueBao NVARCHAR(50),
    @NgayDangKy DATE
AS
BEGIN
    INSERT INTO ThueBao (SoThueBao, LoaiThueBao, NgayDangKy, MaKH)
    VALUES (@SoThueBao, @LoaiThueBao, @NgayDangKy, @MaKH);
END

CREATE PROCEDURE SP_HuyTB_MaKH
    @MaKH INT
AS
BEGIN
    DELETE FROM ThueBao WHERE MaKH = @MaKH;
END