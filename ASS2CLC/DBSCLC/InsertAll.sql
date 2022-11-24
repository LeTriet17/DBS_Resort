USE [ASS2CLC]
GO

INSERT INTO [dbo].[ChiNhanh]
           ([Tinh]
           ,[DiaChi]
           ,[SoDT]
           ,[Email])
     VALUES
           ('Binh Duong','20 Duong ANC','9876543210','abc@gmail.com'),
           ('Da Nang','10 Duong ABC','9976543210','ade@gmail.com'),
           ('Thai Nguyen','25 Duong ADG','9886543210','abg@gmail.com'),
           ('Ha Noi','26 Duong ANC','9877543210','amn@gmail.com');

INSERT INTO [dbo].[HinhAnhChiNhanh]
           ([MCN]
           ,[HinhAnh])
     VALUES
           ('CN1','D:/hinh1.jpg'),
           ('CN2','D:/hinh2.jpg'),
           ('CN3','D:/hinh3.jpg'),
           ('CN4','D:/hinh4.jpg');



INSERT INTO [dbo].[Khu]
           ([MCN]
           ,[TenKhu])
     VALUES
           ('CN1','Khu A'),
           ('CN2','Khu B'),
           ('CN3','Khu C'),
           ('CN4','Khu D');


USE [ASS2CLC]
GO

INSERT INTO [dbo].[LoaiPhong]
           ([TenLoaiPhong]
           ,[SoKhach]
           ,[DienTich])
     VALUES
           ('Phong A',2,20),
		   ('Phong B',5,50),
           ('Phong C',4,40),
           ('Phong D',3,30);
USE [ASS2CLC]
GO

INSERT INTO [dbo].[ThongTinGiuong]
           ([MaLoaiPhong]
           ,[KichThuoc]
           ,[SoLuong])
     VALUES
           (1,5,1),
           (2,5,2),
           (3,5,3),
           (4,5,4);
USE [ASS2CLC]
GO

INSERT INTO [dbo].[ChiNhanhLoaiPhong]
           ([MaLoaiPhong]
           ,[MCN]
           ,[GiaThue])
     VALUES
           (1,'CN1',20),
           (2,'CN2',40),
           (3,'CN3',100),
           (4,'CN4',60);

USE [ASS2CLC]
GO

INSERT INTO [dbo].[Phong]
           ([MCN]
           ,[SoPhong]
           ,[MaLoaiPhong]
           ,[TenKhu])
     VALUES
           ('CN1','101',1,'Khu A'),
		   ('CN1','202',2,'Khu B'),
           ('CN1','303',3,'Khu C'),
           ('CN1','404',4,'Khu D'),
           ('CN2','202',2,'Khu B'),
           ('CN3','303',3,'Khu C'),
           ('CN4','404',4,'Khu D');

GO
USE [ASS2CLC]
GO

INSERT INTO [dbo].[MLVT]
           ([MLVT]
           ,[TenLVT])
     VALUES
           ('VT0001','Den'),
           ('VT0002','Ban'),
           ('VT0003','Ghe'),
           ('VT0004','Khan');

GO

USE [ASS2CLC]
GO

INSERT INTO [dbo].[LVTLP]
           ([MLVT]
           ,[MaLoaiPhong]
           ,[SoLuong])
     VALUES
           ('VT0001',1,2),
           ('VT0003',3,5),
           ('VT0002',2,3),
           ('VT0004',3,2);

GO


USE [ASS2CLC]
GO

INSERT INTO [dbo].[VatTu]
           ([MCN]
           ,[MLVT]
           ,[STT]
           ,[TinhTrang]
           ,[SoPhong])
     VALUES
           ('CN1','VT0001',1,'TOT','101'),
           ('CN2','VT0002',1,'TOT','202'),
           ('CN3','VT0003',1,'TOT','303'),
           ('CN4','VT0004',1,'TOT','404');

GO
USE [ASS2CLC]
GO

INSERT INTO [dbo].[NhaCungCap]
           ([MNCC]
           ,[TenNCC]
           ,[DiaChi]
           ,[Email])
     VALUES
           ('NCC0001','Nguyen Van A','Ha Noi','nva@gmail.com'),
           ('NCC0002','Nguyen Van B','Ha Noi','nvb@gmail.com'),
           ('NCC0003','Nguyen Van C','Ha Noi','nvc@gmail.com'),
           ('NCC0004','Nguyen Van D','Ha Noi','nvd@gmail.com');
USE [ASS2CLC]
GO

INSERT INTO [dbo].[CungCapVatTu]
           ([MNCC]
           ,[MCN]
           ,[MLVT])
     VALUES
          ('NCC0001','CN1','VT0001'),
          ('NCC0002','CN2','VT0002'),
          ('NCC0003','CN3','VT0003'),
          ('NCC0004','CN4','VT0004');
USE [ASS2CLC]
GO



INSERT INTO [dbo].[KhachHang]
           ([MKH]
      ,[CCCD]
      ,[Email]
      ,[Username]
      ,[Pass]
      ,[Ho]
      ,[Ten]
      ,[Diem]
      ,[Loai])
     VALUES
           ('KH000001','CCCD1','kh1@gmail.com','kh1','passkh1','Nguyen Van','A',0,1),
           ('KH000002','CCCD2','kh2@gmail.com','kh2','passkh2','Nguyen Van','B',0,2),
           ('KH000003','CCCD3','kh3@gmail.com','kh3','passkh3','Nguyen Van','C',0,3),
           ('KH000004','CCCD4','kh4@gmail.com','kh4','passkh4','Nguyen Van','D',0,4);

GO
USE [ASS2CLC]
GO

INSERT INTO [dbo].[GoiDichVu]
           ([TenGoi]
           ,[SoNgay]
           ,[SoKhach]
           ,[Gia])
     VALUES
           ('GoiA',2,2,10),
           ('GoiB',3,3,20),
           ('GoiC',5,5,40),
           ('GoiD',2,1,5);

GO



USE [ASS2CLC]
GO

INSERT INTO [dbo].[HoaDonGoiDichVu]
           ([MKH]
           ,[TenGoi]
           ,[NgayMua]
           ,[NgayBatDau]
           ,[TongTien])
     VALUES
	 ('KH000001','GoiA','2022/12/01','2022/12/02',100),
	 ('KH000001','GoiB','2022/11/01','2022/11/02',100),
	 ('KH000001','GoiC','2022/10/01','2022/10/02',100),
	 ('KH000001','GoiD','2022/09/01','2022/09/02',100),
	 ('KH000002','GoiB','2022/11/01','2022/11/02',100),
	 ('KH000003','GoiC','2022/10/01','2022/10/02',100),
	 ('KH000004','GoiD','2022/09/01','2022/09/02',100);
        
USE [ASS2CLC]
GO

INSERT INTO [dbo].[DonDatPhong]
           ([NgayGioDat]
           ,[NgayGioDatID]
           ,[NgayNP]
           ,[NgayTP]
		   ,[SoKhach]
           ,[TinhTrang]
           ,[TongTien]
           ,[MKH]
           ,[TenGoi])
     VALUES
	 ('2022/12/01','20221202','2022/12/02','2022/12/04',1,0,100,'KH000001','GoiA'),
	  ('2022/11/01','20221102','2022/11/02','2022/11/05',1,1,100,'KH000001','GoiB'),
	 ('2022/10/01','20221002','2022/10/02','2022/10/07',2,2,100,'KH000001','GoiC'),
	 ('2022/09/01','20220902','2022/09/02','2022/09/03',1,3,100,'KH000001','GoiD'),
     ('2022/11/01','20221102','2022/11/02','2022/11/05',1,1,100,'KH000002','GoiB'),
	 ('2022/10/01','20221002','2022/10/02','2022/10/07',2,2,100,'KH000003','GoiC'),
	 ('2022/09/01','20220902','2022/09/02','2022/09/03',1,3,100,'KH000004','GoiD');
USE [ASS2CLC]
GO

INSERT INTO [dbo].[PhongThue]
           ([MDP]
           ,[MCN]
           ,[SoPhong])
     VALUES
           ('DP202212021','CN1','101'),
		   ('DP202211022','CN1','202'),
           ('DP202210023','CN1','303'),
           ('DP202209024','CN1','404'),
           ('DP202211025','CN2','202'),
           ('DP202210026','CN3','303'),
           ('DP202209027','CN4','404');

GO


USE [ASS2CLC]
GO

INSERT INTO [dbo].[HoaDon]
           ([MDP]
           ,[NgayNP]
           ,[NgayTP])
     VALUES
           ('DP202212021','2022/12/02','2022/12/04'),
           ('DP202211022','2022/11/02','2022/11/05'),
           ('DP202210023','2022/10/02','2022/10/07'),
           ('DP202209024','2022/09/02','2022/09/03'),
		   ('DP202211025','2022/11/02','2022/11/05'),
           ('DP202210026','2022/10/02','2022/10/07'),
           ('DP202209027','2022/09/02','2022/09/03');

GO

USE [ASS2CLC]
GO

INSERT INTO [dbo].[DoanhNghiep]
           ([MaDN]
           ,[TenDN])
     VALUES
          ('DN0001','Doanh Nghiep A'),
          ('DN0002','Doanh Nghiep B'),
          ('DN0003','Doanh Nghiep C'),
          ('DN0004','Doanh Nghiep D');

USE [ASS2CLC]
GO

INSERT INTO [dbo].[DichVu]
           ([MaDV]
           ,[LoaiDV]
           ,[SoKhach]
           ,[PhongCach]
           ,[MaDN])
     VALUES
           ('DVR001','Nha Hang',10,'Chau Au','DN0001'),
           ('DVS001','Spa',10,'Chau A','DN0002'),
           ('DVC001','Cua Hang Tien Loi',10,'Chau A','DN0003'),
           ('DVM001','Do Luu Niem',10,'Chau Au','DN0004'),
           ('DVB001','Bar',10,'Chau Au','DN0004');
USE [ASS2CLC]
GO

INSERT INTO [dbo].[Spa]
           ([MaDV]
           ,[LoaiDV])
     VALUES
           ('DVS001','Spa1'),
           ('DVS001','Spa2'),
           ('DVS001','Spa3'),
           ('DVS001','Spa4');

GO
USE [ASS2CLC]
GO

INSERT INTO [dbo].[LuuNiem]
           ([MaDV]
           ,[LoaiHang])
     VALUES
           ('DVM001','GAU BONG'),
           ('DVM001','Giay'),
           ('DVM001','Dep'),
           ('DVM001','Day Chuyen');

GO
USE [ASS2CLC]
GO

INSERT INTO [dbo].[ThuongHieuLN]
           ([MaDV]
           ,[ThuongHieu])
     VALUES
           ('DVM001','Thuong Hieu A'),
           ('DVM001','Thuong Hieu B'),
           ('DVM001','Thuong Hieu C'),
           ('DVM001','Thuong Hieu D');
GO


USE [ASS2CLC]
GO
USE [ASS2CLC]
GO

INSERT INTO [dbo].[MatBang]
           ([MCN]
           ,[STT]
           ,[MaDV]
           ,[ChieuDai]
           ,[ChieuRong]
           ,[GiaThue]
           ,[TenCH])
     VALUES
	 ('CN1',1,'DVR001',20,40,100,'Cua Hang A'),
	 ('CN2',1,'DVS001',20,40,200,'Cua Hang B'),
	 ('CN3',1,'DVC001',20,40,300,'Cua Hang C'),
	 ('CN4',1,'DVM001',20,40,350,'Cua Hang D');
           
GO


INSERT INTO [dbo].[HinhAnhCuaHang]
           ([MCN]
           ,[STT]
           ,[HinhAnh])
     VALUES
           ('CN1',1,'D/hinhanhCH1.jpg'),
           ('CN2',1,'D/hinhanhCH2.jpg'),
           ('CN3',1,'D/hinhanhCH3.jpg'),
           ('CN4',1,'D/hinhanhCH4.jpg');

GO



USE [ASS2CLC]
GO

INSERT INTO [dbo].[GioHD]
           ([MCN]
           ,[STT]
           ,[GioBatDau]
           ,[GioKetThuc])
     VALUES
           ('CN1',1,'08:00','18:00'),
           ('CN2',1,'08:30','18:30'),
           ('CN3',1,'09:00','19:00'),
           ('CN4',1,'08:00','18:00');
GO






