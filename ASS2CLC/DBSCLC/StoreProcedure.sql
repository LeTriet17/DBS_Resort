SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TTMKH] 
	-- Add the parameters for the stored procedure here
	@MKH varchar(20) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT tmp.TenGoi,SoKhach,NgayBatDau,(NgayBatDau + SoNgay) AS NgayHetHan, SoNgay AS SoNgayConlai FROM dbo.GoiDichVu INNER JOIN (SELECT TenGoi, NgayMua,NgayBatDau FROM dbo.HoaDonGoiDichVu WHERE MKH = @MKH) tmp
	ON tmp.TenGoi = dbo.GoiDichVu.TenGoi
END
GO
EXEC dbo.TTMKH  @MKH = 'KH000001';
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeLuotKhach]
	-- Add the parameters for the stored procedure here
	@MCN varchar(20) = NULL,
	@nam INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT Month(NgayNP) AS Thang,  SUM(SoKhach) AS TongSoKhach FROM dbo.DonDatPhong INNER JOIN (SELECT MDP FROM dbo.PhongThue WHERE MCN= @MCN) tmp
	ON tmp.MDP = DonDatPhong.MDP WHERE YEAR(NgayNP) = @nam  GROUP BY NgayNP
END
GO
EXEC dbo.ThongKeLuotKhach @MCN = 'CN1', @nam = 2022;
