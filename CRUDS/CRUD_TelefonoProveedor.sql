SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTelefonoProveedor(
	--@pIdTelefonoProveedor int,
	@pIdProveedor int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		Insert into TelefonoProveedor(IdProveedor, telefono)
		values (@pIdProveedor, @pTelefono)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTelefonoProveedor(
	@pIdTelefonoProveedor int,
	@pIdProveedor int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoProveedor(@pIdTelefonoProveedor) = 1
	BEGIN
		if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
		BEGIN
			update TelefonoProveedor
			set --IdTelefonoProveedor = @pIdTelefonoProveedor,
				IdProveedor = isnull(@pIdProveedor, IdProveedor),
				telefono = isnull(@pTelefono, telefono)
	
			where IdTelefonoProveedor = @pIdTelefonoProveedor
		END
		else
			Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdTelefonoProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTelefonoProveedor(
	@pIdTelefonoProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoProveedor(@pIdTelefonoProveedor) = 1
	BEGIN
		select * from TelefonoProveedor t
		where t.IdTelefonoProveedor = @pIdTelefonoProveedor
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTelefonoProveedor(
	@pIdTelefonoProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoProveedor(@pIdTelefonoProveedor) = 1
	BEGIN
		delete from TelefonoProveedor
		where IdTelefonoProveedor = @pIdTelefonoProveedor
	END
	else
		Raiserror('El IdTelefonoProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTelefonoProveedor 1, 123123123
Execute sp_UpdateTelefonoProveedor 4, 56234612
Execute sp_ReadTelefonoProveedor 1
Execute sp_DeleteTelefonoProveedor 5