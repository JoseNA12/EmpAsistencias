SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateSolicitud
	--@pIdSolicitud int,
	
AS
BEGIN
	Insert into Solicitud(fecha, hora)
	values ((select cast(getdate() as date)), (select cast(getdate() as time)))
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateSolicitud(
	@pIdSolicitud int,
	--@pIdServicio int = null,
	@pFecha date = null,
	@pHora time = null)
AS
BEGIN
	if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1
	BEGIN
		update Solicitud
		set --IdSolicitud = @pIdSolicitud,
			fecha = isnull(@pFecha, fecha),
			hora = isnull(@pHora, hora)
	
		where IdSolicitud = @pIdSolicitud
	END
	else
		Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadSolicitud(
	@pIdSolicitud int)
AS
BEGIN
	if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1
	BEGIN
		select * from Solicitud s
		where s.IdSolicitud = @pIdSolicitud
	END
	else
		Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteSolicitud(
	@pIdSolicitud int)
AS
BEGIN
	if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1
	BEGIN
		delete from Solicitud
		where IdSolicitud = @pIdSolicitud
	END
	else
		Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateSolicitud 'JAJAJA'
Execute sp_UpdateSolicitud 1, 'EJEJEJE'
Execute sp_ReadSolicitud 1
Execute sp_DeleteSolicitud 1