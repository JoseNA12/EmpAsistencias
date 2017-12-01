SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTelefonoCliente(
	--@pIdTelefonoCliente int,
	@pIdCliente int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
	BEGIN
		Insert into TelefonoCliente(IdCliente, telefono)
		values (@pIdCliente, @pTelefono)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTelefonoCliente(
	@pIdTelefonoCliente int,
	@pIdCliente int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoCliente(@pIdTelefonoCliente) = 1
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
		BEGIN
			update TelefonoCliente
			set --IdTelefonoCliente = @pIdTelefonoCliente,
				IdCliente = isnull(@pIdCliente, IdCliente),
				telefono = isnull(@pTelefono, telefono)
	
			where IdTelefonoCliente = @pIdTelefonoCliente
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdTelefonoCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTelefonoCliente(
	@pIdTelefonoCliente int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoCliente(@pIdTelefonoCliente) = 1
	BEGIN
		select * from TelefonoCliente t
		where t.IdTelefonoCliente = @pIdTelefonoCliente
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTelefonoCliente(
	@pIdTelefonoCliente int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoCliente(@pIdTelefonoCliente) = 1
	BEGIN
		delete from TelefonoCliente
		where IdTelefonoCliente = @pIdTelefonoCliente
	END
	else
		Raiserror('El IdTelefonoCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTelefonoCliente 6, 6
Execute sp_UpdateTelefonoCliente 134
Execute sp_ReadTelefonoCliente 1
Execute sp_DeleteTelefonoCliente 5