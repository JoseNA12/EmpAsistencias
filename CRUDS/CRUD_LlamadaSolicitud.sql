SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateLlamadaSolicitud(
	--@pIdLlamadaSolicitud int, 
	@pIdLlamada int = null,
	@pIdSolicitud int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
	BEGIN
		if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1 or @pIdSolicitud is null
		BEGIN
			Insert into LlamadaSolicitud(IdLlamada, IdSolicitud)
			values (@pIdLlamada, @pIdSolicitud)
		END
		else
			Raiserror('El Solicitud ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateLlamadaSolicitud(
	@pIdLlamadaSolicitud int, 
	@pIdLlamada int = null,
	@pIdSolicitud int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaSolicitud(@pIdLlamadaSolicitud) = 1
	BEGIN
		if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
		BEGIN
			if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1 or @pIdSolicitud is null
			BEGIN
				update LlamadaSolicitud
				set --IdLlamadaSolicitud = @pIdLlamadaSolicitud, 
					IdLlamada = isnull(@pIdLlamada, IdLlamada),
					IdSolicitud = isnull(@pIdSolicitud, IdSolicitud)

				where IdLlamadaSolicitud = @pIdLlamadaSolicitud
			END
			else
				Raiserror('El Solicitud ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdLlamadaSolicitud ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadLlamadaSolicitud(
	@pIdLlamadaSolicitud int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaSolicitud(@pIdLlamadaSolicitud) = 1
	BEGIN
		select * from LlamadaSolicitud lc
		where lc.IdLlamadaSolicitud = @pIdLlamadaSolicitud
	END
	else
		Raiserror('El IdLlamadaSolicitud ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteLlamadaSolicitud(
	@pIdLlamadaSolicitud int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaSolicitud(@pIdLlamadaSolicitud) = 1
	BEGIN
		delete from LlamadaSolicitud
		where IdLlamadaSolicitud = @pIdLlamadaSolicitud
	END
	else
		Raiserror('El IdLlamadaSolicitud ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateLlamadaSolicitud 23
Execute sp_UpdateLlamadaSolicitud 2
Execute sp_ReadLlamadaSolicitud 6
Execute sp_DeleteLlamadaSolicitud 34
