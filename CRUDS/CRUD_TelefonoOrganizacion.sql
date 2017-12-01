SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTelefonoOrganizacion(
	--@pIdTelefonoOrganizacion int,
	@pIdOrganizacion int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
	BEGIN
		Insert into TelefonoOrganizacion(IdOrganizacion, telefono)
		values (@pIdOrganizacion, @pTelefono)
	END
	else
		Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTelefonoOrganizacion(
	@pIdTelefonoOrganizacion int,
	@pIdOrganizacion int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoOrganizacion(@pIdTelefonoOrganizacion) = 1
	BEGIN
		if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
		BEGIN
			update TelefonoOrganizacion
			set --IdTelefonoOrganizacion = @pIdTelefonoOrganizacion,
				IdOrganizacion = isnull(@pIdOrganizacion, IdOrganizacion),
				telefono = isnull(@pTelefono, telefono)
	
			where IdTelefonoOrganizacion = @pIdTelefonoOrganizacion
		END
		else
			Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdTelefonoOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTelefonoOrganizacion(
	@pIdTelefonoOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoOrganizacion(@pIdTelefonoOrganizacion) = 1
	BEGIN
		select * from TelefonoOrganizacion t
		where t.IdTelefonoOrganizacion = @pIdTelefonoOrganizacion
	END
	else
		Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTelefonoOrganizacion(
	@pIdTelefonoOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoOrganizacion(@pIdTelefonoOrganizacion) = 1
	BEGIN
		delete from TelefonoOrganizacion
		where IdTelefonoOrganizacion = @pIdTelefonoOrganizacion
	END
	else
		Raiserror('El IdTelefonoOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTelefonoOrganizacion 1, 123123123
Execute sp_UpdateTelefonoOrganizacion 4, 56234612
Execute sp_ReadTelefonoOrganizacion 1
Execute sp_DeleteTelefonoOrganizacion 5