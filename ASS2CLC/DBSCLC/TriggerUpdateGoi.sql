CREATE OR ALTER TRIGGER [dbo].[DangKyHDGDV]
ON  [dbo].[HoaDonGoiDichVu]
AFTER INSERT
AS 
BEGIN

SET NOCOUNT ON;
     IF EXISTS (
    SELECT INSERTED.MKH
    FROM HoaDonGoiDichVu ,INSERTED
    WHERE HoaDonGoiDichVu.MKH = INSERTED.MKH and inserted.TenGoi = HoaDonGoiDichVu.TenGoi and inserted.NgayMua >  HoaDonGoiDichVu.NgayBatDau
    ) BEGIN
    -- Should be using throw
    RAISERROR(N'',16,1);
  END;

END

GO