CREATE OR ALTER TRIGGER [dbo].[UpdateDiemDDP]
ON  [dbo].[DonDatPhong]
AFTER INSERT
AS 
BEGIN

SET NOCOUNT ON;

    UPDATE dbo.KhachHang
    SET Diem = Diem + IsNull((SELECT Sum(TongTien) FROM INSERTED WHERE INSERTED.MKH = dbo.KhachHang.MKH
	GROUP BY INSERTED.MKH), 0) /1000   
 	UPDATE dbo.KhachHang SET
    Loai = 1
  WHERE Diem <= 10;
  UPDATE dbo.KhachHang SET
    Loai = 2
  WHERE Diem > 100 AND Diem <=1000;
    UPDATE dbo.KhachHang SET
    Loai = 3
  WHERE Diem > 1000 AND Diem <=10000;
    UPDATE dbo.KhachHang SET
    Loai = 4
  WHERE Diem > 10000;
END

GO