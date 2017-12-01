SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateSolicitudServicio(
	--@pIdSolicitudServicio int,
	@pIdSolicitud int = null,
	@pIdServicio int = null,
	@pEstado varchar(25) = null,
	@pCalificacion tinyint = null)
AS
BEGIN
	if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1 or @pIdSolicitud is null
	BEGIN
		if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
		BEGIN
			Insert into SolicitudServicio(IdSolicitud, IdServicio, estado, calificacion)
			values (@pIdSolicitud, @pIdServicio, @pEstado, @pCalificacion)
		END
		else
			Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateSolicitudServicio(
	@pIdSolicitudServicio int,
	@pIdSolicitud int = null,
	@pIdServicio int = null,
	@pEstado varchar(25) = null,
	@pCalificacion tinyint = null)
AS
BEGIN
	if [dbo].fn_ExisteSolicitudServicio(@pIdSolicitudServicio) = 1
	BEGIN
		if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1 or @pIdSolicitud is null
		BEGIN
			if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
			BEGIN
				update SolicitudServicio
				set --IdSolicitudServicio = @pIdSolicitudServicio,
					IdSolicitud = isnull(@pIdSolicitud, IdSolicitud),
					IdServicio = isnull(@pIdServicio, IdServicio),
					estado = isnull(@pEstado, estado),
					calificacion = isnull(@pCalificacion, calificacion)
	
				where IdSolicitudServicio = @pIdSolicitudServicio
			END
			else
				Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdSolicitudServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadSolicitudServicio(
	@pIdSolicitudServicio int)
AS
BEGIN
	if [dbo].fn_ExisteSolicitudServicio(@pIdSolicitudServicio) = 1
	BEGIN
		select * from SolicitudServicio s
		where s.IdSolicitudServicio = @pIdSolicitudServicio
	END
	else
		Raiserror('El IdSolicitudServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteSolicitudServicio(
	@pIdSolicitudServicio int)
AS
BEGIN
	if [dbo].fn_ExisteSolicitudServicio(@pIdSolicitudServicio) = 1
	BEGIN
		delete from SolicitudServicio
		where IdSolicitudServicio = @pIdSolicitudServicio
	END
	else
		Raiserror('El IdSolicitudServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateSolicitudServicio 4
Execute sp_UpdateSolicitudServicio 8
Execute sp_ReadSolicitudServicio 1
Execute sp_DeleteSolicitudServicio 22