SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateSolicitudPaquete(
	--@pIdSolicitudPaquete int,
	@pIdSolicitud int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1 or @pIdSolicitud is null
	BEGIN
		if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
		BEGIN
			Insert into SolicitudPaquete(IdSolicitud, IdPaquete)
			values (@pIdSolicitud, @pIdPaquete)
		END
		else
			Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateSolicitudPaquete(
	@pIdSolicitudPaquete int,
	@pIdSolicitud int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExisteSolicitudPaquete(@pIdSolicitudPaquete) = 1
	BEGIN
		if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1 or @pIdSolicitud is null
		BEGIN
			if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
			BEGIN
				update SolicitudPaquete
				set --IdSolicitudPaquete = @pIdSolicitudPaquete,
					IdSolicitud = isnull(@pIdSolicitud, IdSolicitud),
					IdPaquete = isnull(@pIdPaquete, IdPaquete)
	
				where IdSolicitudPaquete = @pIdSolicitudPaquete
			END
			else
				Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdSolicitudPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadSolicitudPaquete(
	@pIdSolicitudPaquete int)
AS
BEGIN
	if [dbo].fn_ExisteSolicitudPaquete(@pIdSolicitudPaquete) = 1
	BEGIN
		select * from SolicitudPaquete s
		where s.IdSolicitudPaquete = @pIdSolicitudPaquete
	END
	else
		Raiserror('El IdSolicitudPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteSolicitudPaquete(
	@pIdSolicitudPaquete int)
AS
BEGIN
	if [dbo].fn_ExisteSolicitudPaquete(@pIdSolicitudPaquete) = 1
	BEGIN
		delete from SolicitudPaquete
		where IdSolicitudPaquete = @pIdSolicitudPaquete
	END
	else
		Raiserror('El IdSolicitudPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateSolicitudPaquete 4
Execute sp_UpdateSolicitudPaquete 8
Execute sp_ReadSolicitudPaquete 1
Execute sp_DeleteSolicitudPaquete 22