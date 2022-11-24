CREATE TRIGGER [dbo].[UpdateInsertTraNVL]
ON  [dbo].[TraNVL]
AFTER INSERT
AS 
BEGIN
    UPDATE dbo.NguyenVatLieu
    SET SLTon = SLTon - IsNull((SELECT Sum(SoLuong) FROM INSERTED WHERE INSERTED.MSNVL = NguyenVatLieu.MSNVL
	GROUP BY INSERTED.MSNVL), 0)    
    FROM dbo.NguyenVatLieu
    JOIN INSERTED ON INSERTED.MSNVL = NguyenVatLieu.MSNVL;
	END

GO

CREATE TRIGGER [dbo].[UpdateDeleteTraNVL]
ON  [dbo].[XuatNVL]
AFTER DELETE
AS 
DECLARE @oldslton int;
DECLARE @new int;
DECLARE @Error VARCHAR(100)
SET @Error = 'So luong tra khi xoa lon hon so luong ton';
SET @oldslton = (SELECT SLTon FROM NguyenVatLieu, inserted WHERE INSERTED.MSNVL = NguyenVatLieu.MSNVL);
SET @new = IsNull((SELECT Sum(SoLuong) FROM  NguyenVatLieu, INSERTED WHERE INSERTED.MSNVL = NguyenVatLieu.MSNVL
	GROUP BY INSERTED.MSNVL), 0) 
IF (@new < @oldslton)
BEGIN
    UPDATE dbo.NguyenVatLieu
    SET SLTon = SLTon - IsNull((SELECT Sum(SoLuong) FROM INSERTED WHERE INSERTED.MSNVL = NguyenVatLieu.MSNVL
	GROUP BY INSERTED.MSNVL), 0)    
    FROM dbo.NguyenVatLieu
    JOIN INSERTED ON INSERTED.MSNVL = NguyenVatLieu.MSNVL;
END
ELSE 
RAISERROR(@Error, 16, 1)
DELETE  dbo.XuatNVL FROM   dbo.XuatNVL INNER JOIN inserted ON INSERTED.MSNVL = dbo.XuatNVL.MSNVL
GO