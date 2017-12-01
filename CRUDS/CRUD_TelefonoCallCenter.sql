SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTelefonoCallCenter(
	--@pIdTelefonoCallCenter int,
	@pIdCallCenter int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1 or @pIdCallCenter is null
	BEGIN
		Insert into TelefonoCallCenter(IdCallCenter, telefono)
		values (@pIdCallCenter, @pTelefono)
	END
	else
		Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTelefonoCallCenter(
	@pIdTelefonoCallCenter int,
	@pIdCallCenter int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoCallCenter(@pIdTelefonoCallCenter) = 1
	BEGIN
		if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1 or @pIdCallCenter is null
		BEGIN
			update TelefonoCallCenter
			set --IdTelefonoCallCenter = @pIdTelefonoCallCenter,
				IdCallCenter = isnull(@pIdCallCenter, IdCallCenter),
				telefono = isnull(@pTelefono, telefono)
	
			where IdTelefonoCallCenter = @pIdTelefonoCallCenter
		END
		else
			Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdTelefonoCallCenter ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTelefonoCallCenter(
	@pIdTelefonoCallCenter int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoCallCenter(@pIdTelefonoCallCenter) = 1
	BEGIN
		select * from TelefonoCallCenter t
		where t.IdTelefonoCallCenter = @pIdTelefonoCallCenter
	END
	else
		Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTelefonoCallCenter(
	@pIdTelefonoCallCenter int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoCallCenter(@pIdTelefonoCallCenter) = 1
	BEGIN
		delete from TelefonoCallCenter
		where IdTelefonoCallCenter = @pIdTelefonoCallCenter
	END
	else
		Raiserror('El IdTelefonoCallCenter ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTelefonoCallCenter 1, 123123123
Execute sp_UpdateTelefonoCallCenter 4, 56234612
Execute sp_ReadTelefonoCallCenter 1
Execute sp_DeleteTelefonoCallCenter 5