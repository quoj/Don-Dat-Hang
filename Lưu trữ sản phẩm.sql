CREATE TABLE LoaiSanPham (
    MaLoaiSanPham VARCHAR(10) PRIMARY KEY,
    TenLoaiSanPham VARCHAR(50)
);
SELECT * FROM LoaiSanPham;

CREATE TABLE NguoiChiuTrachNhiem (
    MaNguoiChiuTrachNhiem INT PRIMARY KEY,
    TenNguoiChiuTrachNhiem VARCHAR(50)
);
SELECT * FROM  NguoiChiuTrachNhiem;

CREATE TABLE SanPhamnew (
    MaSanPham VARCHAR(10) PRIMARY KEY,
    NgaySanXuat DATE,
    MaLoaiSanPham VARCHAR(10),
    MaNguoiChiuTrachNhiem INT,
    FOREIGN KEY (MaLoaiSanPham) REFERENCES LoaiSanPham(MaLoaiSanPham),
    FOREIGN KEY (MaNguoiChiuTrachNhiem) REFERENCES NguoiChiuTrachNhiem(MaNguoiChiuTrachNhiem)
);
SELECT * FROM SanPhamnew;




INSERT INTO LoaiSanPham (MaLoaiSanPham, TenLoaiSanPham) VALUES ('Z37E', 'Máy tính sách tay 737');

INSERT INTO NguoiChiuTrachNhiem (MaNguoiChiuTrachNhiem, TenNguoiChiuTrachNhiem) VALUES (987688, 'Nguyễn Văn An');

INSERT INTO SanPhamnew (MaSanPham, NgaySanXuat, MaLoaiSanPham, MaNguoiChiuTrachNhiem) VALUES ('Z37', '2009-12-12', 'Z37E', 987688);









SELECT * FROM LoaiSanPham ORDER BY TenLoaiSanPham ASC;



SELECT * FROM NguoiChiuTrachNhiem ORDER BY TenNguoiChiuTrachNhiem ASC;



SELECT * FROM SanPhamnew WHERE MaLoaiSanPham = 'Z37E';



SELECT * FROM SanPhamnew WHERE MaNguoiChiuTrachNhiem = 987688 ORDER BY NgaySanXuat DESC;



SELECT LoaiSanPham.TenLoaiSanPham, COUNT(*) AS SoSanPham
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
GROUP BY LoaiSanPham.TenLoaiSanPham;



SELECT SanPham.*, LoaiSanPham.TenLoaiSanPham
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham;



SELECT SanPham.*, LoaiSanPham.TenLoaiSanPham, NguoiChiuTrachNhiem.TenNguoiChiuTrachNhiem
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
INNER JOIN NguoiChiuTrachNhiem ON SanPham.MaNguoiChiuTrachNhiem = NguoiChiuTrachNhiem.MaNguoiChiuTrachNhiem;



UPDATE SanPhamnew SET NgaySanXuat = GETDATE() WHERE NgaySanXuat <= GETDATE();



SELECT
    OBJECT_NAME(parent_object_id) AS TableName,
    COL_NAME(parent_object_id, parent_column_id) AS PrimaryKey,
    OBJECT_NAME(referenced_object_id) AS ReferencedTable,
    COL_NAME(referenced_object_id, referenced_column_id) AS ForeignKey
FROM sys.foreign_key_columns;


ALTER TABLE SanPham ADD PhienBan VARCHAR(10);


CREATE INDEX idx_TenNguoiChiuTrachNhiem ON NguoiChiuTrachNhiem(TenNguoiChiuTrachNhiem);



CREATE VIEW View_SanPham AS
SELECT MaSanPham, NgaySanXuat, TenLoaiSanPham
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham;

CREATE VIEW View_SanPham_NCTN AS
SELECT MaSanPham, NgaySanXuat, TenNguoiChiuTrachNhiem
FROM SanPham
INNER JOIN NguoiChiuTrachNhiem ON SanPham.MaNguoiChiuTrachNhiem = NguoiChiuTrachNhiem.MaNguoiChiuTrachNhiem;

CREATE VIEW View_Top_SanPham AS
SELECT TOP 5 MaSanPham, TenLoaiSanPham, NgaySanXuat
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
ORDER BY NgaySanXuat DESC;



CREATE PROCEDURE SP_Them_LoaiSP
    @MaLoaiSanPham VARCHAR(10),
    @TenLoaiSanPham VARCHAR(50)
AS
BEGIN
    INSERT INTO LoaiSanPham (MaLoaiSanPham, TenLoaiSanPham) VALUES (@MaLoaiSanPham, @TenLoaiSanPham);
END;

CREATE PROCEDURE SP_Them_NCTN
    @MaNguoiChiuTrachNhiem INT,
    @TenNguoiChiuTrachNhiem VARCHAR(50)
AS
BEGIN
    INSERT INTO NguoiChiuTrachNhiem (MaNguoiChiuTrachNhiem, TenNguoiChiuTrachNhiem) VALUES (@MaNguoiChiuTrachNhiem, @TenNguoiChiuTrachNhiem);
END;

CREATE PROCEDURE SP_Them_SanPham
    @MaSanPham VARCHAR(10),
    @NgaySanXuat DATE,
    @MaLoaiSanPham VARCHAR(10),
    @MaNguoiChiuTrachNhiem INT
AS
BEGIN
    INSERT INTO SanPhamnew (MaSanPham, NgaySanXuat, MaLoaiSanPham, MaNguoiChiuTrachNhiem) VALUES (@MaSanPham, @NgaySanXuat, @MaLoaiSanPham, @MaNguoiChiuTrachNhiem);
END;

CREATE PROCEDURE SP_Xoa_SanPham
    @MaSanPham VARCHAR(10)
AS
BEGIN
    DELETE FROM SanPhamnew WHERE MaSanPham = @MaSanPham;
END;

CREATE PROCEDURE SP_Xoa_SanPham_TheoLoai
    @MaLoaiSanPham VARCHAR(10)
AS
BEGIN
    DELETE FROM SanPhamnew WHERE MaLoaiSanPham = @MaLoaiSanPham;
END;