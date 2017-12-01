SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateLlamadaOrganizacion(
	--@pIdLlamadaOrganizacion int, 
	@pIdLlamada int = null,
	@pIdOrganizacion int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
	BEGIN
		if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
		BEGIN
			Insert into LlamadaOrganizacion(IdLlamada, IdOrganizacion)
			values (@pIdLlamada, @pIdOrganizacion)
		END
		else
			Raiserror('El Organizacion ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateLlamadaOrganizacion(
	@pIdLlamadaOrganizacion int, 
	@pIdLlamada int = null,
	@pIdOrganizacion int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaOrganizacion(@pIdLlamadaOrganizacion) = 1
	BEGIN
		if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
		BEGIN
			if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
			BEGIN
				update LlamadaOrganizacion
				set --IdLlamadaOrganizacion = @pIdLlamadaOrganizacion, 
					IdLlamada = isnull(@pIdLlamada, IdLlamada),
					IdOrganizacion = isnull(@pIdOrganizacion, IdOrganizacion)

				where IdLlamadaOrganizacion = @pIdLlamadaOrganizacion
			END
			else
				Raiserror('El Organizacion ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdLlamadaOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadLlamadaOrganizacion(
	@pIdLlamadaOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaOrganizacion(@pIdLlamadaOrganizacion) = 1
	BEGIN
		select * from LlamadaOrganizacion lc
		where lc.IdLlamadaOrganizacion = @pIdLlamadaOrganizacion
	END
	else
		Raiserror('El IdLlamadaOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteLlamadaOrganizacion(
	@pIdLlamadaOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaOrganizacion(@pIdLlamadaOrganizacion) = 1
	BEGIN
		delete from LlamadaOrganizacion
		where IdLlamadaOrganizacion = @pIdLlamadaOrganizacion
	END
	else
		Raiserror('El IdLlamadaOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateLlamadaOrganizacion 23
Execute sp_UpdateLlamadaOrganizacion 2
Execute sp_ReadLlamadaOrganizacion 6
Execute sp_DeleteLlamadaOrganizacion 34
