SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTelefonoEmpleado(
	--@pIdTelefonoEmpleado int,
	@pIdEmpleado int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1 or @pIdEmpleado is null
	BEGIN
		Insert into TelefonoEmpleado(IdEmpleado, telefono)
		values (@pIdEmpleado, @pTelefono)
	END
	else
		Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTelefonoEmpleado(
	@pIdTelefonoEmpleado int,
	@pIdEmpleado int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoEmpleado(@pIdTelefonoEmpleado) = 1
	BEGIN
		if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1 or @pIdEmpleado is null
		BEGIN
			update TelefonoEmpleado
			set --IdTelefonoEmpleado = @pIdTelefonoEmpleado,
				IdEmpleado = isnull(@pIdEmpleado, IdEmpleado),
				telefono = isnull(@pTelefono, telefono)
	
			where IdTelefonoEmpleado = @pIdTelefonoEmpleado
		END
		else
			Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdTelefonoEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTelefonoEmpleado(
	@pIdTelefonoEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoEmpleado(@pIdTelefonoEmpleado) = 1
	BEGIN
		select * from TelefonoEmpleado t
		where t.IdTelefonoEmpleado = @pIdTelefonoEmpleado
	END
	else
		Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTelefonoEmpleado(
	@pIdTelefonoEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoEmpleado(@pIdTelefonoEmpleado) = 1
	BEGIN
		delete from TelefonoEmpleado
		where IdTelefonoEmpleado = @pIdTelefonoEmpleado
	END
	else
		Raiserror('El IdTelefonoEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTelefonoEmpleado 1, 123123123
Execute sp_UpdateTelefonoEmpleado 4, 56234612
Execute sp_ReadTelefonoEmpleado 1
Execute sp_DeleteTelefonoEmpleado 5