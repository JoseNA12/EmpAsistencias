SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreatePagoOrganizacion(
	--@pIdPagoOrganizacion int,
	@pIdPago int = null,
	@pIdOrganizacion int = null)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
	BEGIN
		if[dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
		BEGIN
			Insert into PagoOrganizacion(IdPago, IdOrganizacion)
			values (@pIdPago, @pIdOrganizacion)
		END
		else
			Raiserror('El Organizacion ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdatePagoOrganizacion(
	@pIdPagoOrganizacion int,
	@pIdPago int = null,
	@pIdOrganizacion int = null)
AS
BEGIN
	if [dbo].fn_ExistePagoOrganizacion(@pIdPagoOrganizacion) = 1
	BEGIN
		if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
		BEGIN
			if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1  or @pIdOrganizacion is null
			BEGIN
				update PagoOrganizacion
				set --IdPagoOrganizacion = @pIdPagoOrganizacion, 
					IdPago = isnull(@pIdPago, IdPago),
					IdOrganizacion = isnull(@pIdOrganizacion, IdOrganizacion)

				where IdPagoOrganizacion = @pIdPagoOrganizacion
			END
			else
				Raiserror('El Organizacion ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdPagoOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadPagoOrganizacion(
	@pIdPagoOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExistePagoOrganizacion(@pIdPagoOrganizacion) = 1
	BEGIN
		select * from PagoOrganizacion p
		where p.IdPagoOrganizacion = @pIdPagoOrganizacion
	END
	else
		Raiserror('El IdPagoOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeletePagoOrganizacion(
	@pIdPagoOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExistePagoOrganizacion(@pIdPagoOrganizacion) = 1
	BEGIN
		delete from PagoOrganizacion
		where IdPagoOrganizacion = @pIdPagoOrganizacion
	END
	else
		Raiserror('El IdPagoOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreatePagoOrganizacion 1
Execute sp_UpdatePagoOrganizacion 22
Execute sp_ReadPagoOrganizacion 1
Execute sp_DeletePagoOrganizacion 22
