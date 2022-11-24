USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'ASS2CLC'
)
CREATE DATABASE [ASS2CLC]
GO
USE [ASS2CLC]
-- Create a new table called 'Customers' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.ChiNhanh', 'U') IS NOT NULL
DROP TABLE dbo.ChiNhanh
-- Create the table in the specified schema
CREATE TABLE dbo.ChiNhanh
(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MCN AS CAST( RIGHT('CN' + CAST(ID AS VARCHAR(20)), 20) AS VARCHAR(20)) PERSISTED UNIQUE, 	    -- primary key column,
	Tinh	varchar(20) NOT NULL,
	DiaChi	varchar(100),
	SoDT varchar(10)
	CHECK(SoDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL UNIQUE,
	Email varchar(20)
);

CREATE TABLE dbo.HinhAnhChiNhanh
(
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 	  
	HinhAnh varchar(100) NOT NULL,
	CONSTRAINT MaHACN PRIMARY KEY (MCN,HinhAnh),  -- primary key column
	FOREIGN KEY (MCN) REFERENCES dbo.ChiNhanh(MCN),

);
CREATE TABLE dbo.Khu
(
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 
	TenKhu varchar(20)
	CONSTRAINT MaKhu PRIMARY KEY (MCN,TenKhu),  -- primary key column
	FOREIGN KEY (MCN) REFERENCES dbo.ChiNhanh(MCN),
);

CREATE TABLE dbo.LoaiPhong
(	
	MaLoaiPhong INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TenLoaiPhong varchar(20),
	SoKhach INT
	CHECK(SoKhach >=1 and SoKhach <=10),
	DienTich INT
	
);
CREATE TABLE dbo.ThongTinGiuong
(
	MaLoaiPhong INT  NOT NULL UNIQUE,
	KichThuoc INT NOT NULL,
	SoLuong INT NOT NULL DEFAULT 1,
	CONSTRAINT MaTTG PRIMARY KEY (MaLoaiPhong,KichThuoc),  -- primary key column
	FOREIGN KEY (MaLoaiPhong) REFERENCES dbo.LoaiPhong(MaLoaiPhong),
);
CREATE TABLE dbo.ChiNhanhLoaiPhong
(	
	MaLoaiPhong INT  NOT NULL,
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 
	GiaThue INT,
	CONSTRAINT MaCNLP PRIMARY KEY (MaLoaiPhong, MCN),  -- primary key column
	FOREIGN KEY (MaLoaiPhong) REFERENCES dbo.LoaiPhong(MaLoaiPhong),
	FOREIGN KEY (MCN) REFERENCES dbo.ChiNhanh(MCN),

	
);
CREATE TABLE dbo.Phong
(	
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 
	SoPhong varchar(20)
	CHECK(SoPhong LIKE '[0-9][0-9][0-9]') NOT NULL,
	MaLoaiPhong INT  NOT NULL,
	TenKhu varchar(20),
	FOREIGN KEY (MCN) REFERENCES dbo.ChiNhanh(MCN),
	FOREIGN KEY (MaLoaiPhong) REFERENCES dbo.LoaiPhong(MaLoaiPhong),
	CONSTRAINT MaPHONG PRIMARY KEY (MCN,SoPhong),  -- primary key column
	
);
CREATE TABLE dbo.MLVT
(	
	MLVT varchar(20)
	CHECK(MLVT like 'VT[0-9][0-9][0-9][0-9]') NOT NULL   PRIMARY KEY,
	TenLVT varchar(20)

);
CREATE TABLE dbo.LVTLP
(	
	MLVT varchar(20)
	CHECK(MLVT like 'VT[0-9][0-9][0-9][0-9]') NOT NULL,
	MaLoaiPhong INT NOT NULL,
	SoLuong INT NOT NULL DEFAULT 1
	CHECK(SoLuong >=1 and SoLuong <=20),
	CONSTRAINT MaLVT PRIMARY KEY (MLVT,MaLoaiPhong),  -- primary key column
	FOREIGN KEY (MaLoaiPhong) REFERENCES dbo.LoaiPhong(MaLoaiPhong),
	FOREIGN KEY (MLVT) REFERENCES dbo.MLVT(MLVT),

);
CREATE TABLE dbo.VatTu
(	
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 
	MLVT varchar(20)
	CHECK(MLVT like 'VT[0-9][0-9][0-9][0-9]') NOT NULL,
	STT INT
	CHECK (STT >=0),
	TinhTrang varchar(20),
	SoPhong varchar(20)
	CHECK(SoPhong LIKE '[0-9][0-9][0-9]') NOT NULL,
	CONSTRAINT MaVT PRIMARY KEY (MCN,MLVT,STT),  -- primary key column
	FOREIGN KEY (MCN,SoPhong) REFERENCES dbo.Phong(MCN,SoPhong),


);
CREATE TABLE dbo.NhaCungCap
(	
	MNCC varchar(20)
	CHECK(MNCC like 'NCC[0-9][0-9][0-9][0-9]') NOT NULL PRIMARY KEY, 	    -- primary key column
	TenNCC varchar(20) NOT NULL,
	DiaChi	varchar(100),
	Email varchar(20),

);
CREATE TABLE dbo.CungCapVatTu
(	
	MNCC varchar(20)
	CHECK(MNCC like 'NCC[0-9][0-9][0-9][0-9]') NOT NULL,
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 
	MLVT varchar(20)
	CHECK(MLVT like 'VT[0-9][0-9][0-9][0-9]') NOT NULL,
	CONSTRAINT MaCCVT PRIMARY KEY (MCN,MLVT),  -- primary key column
	FOREIGN KEY (MNCC) REFERENCES dbo.NhaCungCap(MNCC),
	FOREIGN KEY (MLVT) REFERENCES dbo.MLVT(MLVT),
	FOREIGN KEY (MCN) REFERENCES dbo.ChiNhanh(MCN),

);
CREATE TABLE dbo.KhachHang
(	
	MKH varchar(20)
	CHECK(MKH like 'KH[0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL PRIMARY KEY, 	   
	CCCD varchar(12) NOT NULL UNIQUE,
	Email varchar(20)  UNIQUE,
	Username varchar(20)  UNIQUE,
	Pass varchar(20) NOT NULL UNIQUE,
	Ho varchar(20) NOT NULL,
	Ten varchar(20) NOT NULL,
	Diem INT NOT NULL DEFAULT 0 
	CHECK (Diem >=0),
	Loai INT NOT NULL 
	CHECK (Loai >= 1 AND LOAI <=4),
);
CREATE TABLE dbo.GoiDichVu
(	
	TenGoi varchar(20) NOT NULL PRIMARY KEY,
	SoNgay INT
	CHECK (SoNgay >=1 AND SoNgay<=100),
	SoKhach INT
	CHECK (SoKhach >=1 AND SoKhach<=10),
	Gia INT NOT NULL
);
CREATE TABLE dbo.HoaDonGoiDichVu
(	
	MKH varchar(20)
	CHECK(MKH like 'KH[0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL ,
	TenGoi varchar(20) NOT NULL ,
	NgayMua datetime NOT NULL,
	NgayBatDau datetime NOT NULL,
	TongTien INT NOT NULL
	FOREIGN KEY (MKH) REFERENCES dbo.KhachHang(MKH),
	FOREIGN KEY (TenGoi) REFERENCES dbo.GoiDichVu(TenGoi ),
	CONSTRAINT  CK_HDGV1   CHECK (NgayBatDau > NgayMua),
	CONSTRAINT MaHDGDV PRIMARY KEY (MKH,TenGoi),  -- primary key column


);
CREATE TABLE dbo.DonDatPhong
(	
	ID INT IDENTITY(1,1) NOT NULL UNIQUE,
	NgayGioDat datetime  NOT NULL,
	NgayGioDatID varchar(20) NOT NULL,
	MDP AS CAST( RIGHT('DP' +CAST(NgayGioDatID AS VARCHAR(20)) +CAST(ID AS VARCHAR(20)), 20) AS VARCHAR(20)) PERSISTED PRIMARY KEY,
	NgayNP datetime  NOT NULL,
	NgayTP datetime  NOT NULL,
	SoKhach INT,
	TinhTrang INT,
	TongTien INT NOT NULL DEFAULT 0,
	MKH varchar(20)
	CHECK(MKH like 'KH[0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL ,
	TenGoi varchar(20) NOT NULL ,
	FOREIGN KEY (MKH) REFERENCES dbo.KhachHang(MKH),
	FOREIGN KEY (TenGoi) REFERENCES dbo.GoiDichVu(TenGoi ),
	CHECK (NgayTP > NgayNP and NgayNP >NgayGioDat),
	CHECK (TinhTrang >=0 and TinhTrang <=3),

);
CREATE TABLE dbo.PhongThue
(	
	MDP varchar(20),	    
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 
	SoPhong varchar(20)
	CHECK(SoPhong LIKE '[0-9][0-9][0-9]') NOT NULL,
	CONSTRAINT MaPT PRIMARY KEY (MDP,MCN,SoPhong),  -- primary key column
	FOREIGN KEY (MCN,SoPhong) REFERENCES dbo.Phong(MCN,SoPhong),
	FOREIGN KEY (MDP) REFERENCES dbo.DonDatPhong(MDP),

);
CREATE TABLE dbo.HoaDon
(	
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEy ,
	MHD AS CAST( RIGHT('HD' +CAST(CURRENT_TIMESTAMP AS VARCHAR(20)) +CAST(ID AS VARCHAR(20)), 20) AS VARCHAR(20)), 	    -- primary key column,
	MDP varchar(20),	    
	NgayNP datetime,
	NgayTP datetime,
	FOREIGN KEY (ID) REFERENCES dbo.DonDatPhong(ID),

)
CREATE TABLE dbo.DoanhNghiep
(	
	MaDN varchar (20)
	CHECK( MaDN LIKE 'DN[0-9][0-9][0-9][0-9]') PRIMARY KEY,
	TenDN varchar(20), 

)
CREATE TABLE dbo.DichVu
(	
	MaDV varchar (20)
	CHECK( MaDV LIKE 'DV[R|S|C|M|B][0-9][0-9][0-9]') PRIMARY KEY,
	LoaiDV varchar(20), 
	SoKhach INT, 
	PhongCach varchar(20), 
	MaDN varchar (20)
	CHECK( MaDN LIKE 'DN[0-9][0-9][0-9][0-9]'),
	FOREIGN KEY (MaDN) REFERENCES dbo.DoanhNghiep(MaDN),

)
CREATE TABLE dbo.Spa
(	
	MaDV varchar (20)
	CHECK( MaDV LIKE 'DVS[0-9][0-9][0-9]'),
	LoaiDV varchar(20), 
	CONSTRAINT MaSpa PRIMARY KEY (MaDV,LoaiDV),  -- primary key column
	FOREIGN KEY (MaDV) REFERENCES dbo.DichVu(MaDV),
	

)
CREATE TABLE dbo.LuuNiem
(	
	MaDV varchar (20)
	CHECK( MaDV LIKE 'DVM[0-9][0-9][0-9]'),
	LoaiHang varchar(20), 
	CONSTRAINT MaLuuNiem PRIMARY KEY (MaDV,LoaiHang),  -- primary key column
	FOREIGN KEY (MaDV) REFERENCES dbo.DichVu(MaDV),
	

)
CREATE TABLE dbo.ThuongHieuLN
(	
	MaDV varchar (20)
	CHECK( MaDV LIKE 'DVM[0-9][0-9][0-9]'),
	ThuongHieu varchar(20), 
	CONSTRAINT MaThuongHieuLN PRIMARY KEY (MaDV,ThuongHieu),  -- primary key column
	FOREIGN KEY (MaDV) REFERENCES dbo.DichVu(MaDV),
	

)
CREATE TABLE dbo.MatBang
(	
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 

	FOREIGN KEY (MCN) REFERENCES dbo.ChiNhanh(MCN),
	STT INT NOT NULL DEFAULT 1,
	CHECK (STT>=1 AND STT<=50),
	MaDV varchar (20)
	CHECK( MaDV LIKE 'DV[R|S|C|M|B][0-9][0-9][0-9]'),
	CONSTRAINT MaMB PRIMARY KEY (MCN,STT),  -- primary key column
	ChieuDai INT,
	ChieuRong INT,
	GiaThue INT,
	TenCH varchar(20),
	FOREIGN KEY (MaDV) REFERENCES dbo.DichVu(MaDV),
	
)
CREATE TABLE dbo.HinhAnhCuaHang
(	
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 

	STT INT NOT NULL DEFAULT 1
	CHECK (STT>=1 AND STT<=50),
	HinhAnh varchar (20)
	CONSTRAINT CSHinhAnhCuaHang PRIMARY KEY (MCN,STT,HinhAnh),  -- primary key column
	FOREIGN KEY (MCN,STT) REFERENCES dbo.MatBang(MCN,STT),
	
)
CREATE TABLE dbo.GioHD
(	
	MCN	varchar(20) 
	CHECK(MCN LIKE 'CN[1-9]')NOT NULL, 
	STT INT NOT NULL DEFAULT 1
	CHECK (STT>=1 AND STT<=50),
	GioBatDau varchar (20)
	CHECK (GioBatDau LIKE '[0-2][0-9]:[0-6][0-9]'),
	GioKetThuc varchar (20)
	CHECK (GioKetThuc LIKE '[0-2][0-9]:[0-6][0-9]')
	CONSTRAINT HinhAnhCH PRIMARY KEY (MCN,STT),  -- primary key column
	FOREIGN KEY (MCN,STT) REFERENCES dbo.MatBang(MCN,STT),
	
)

GO