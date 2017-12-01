SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
ALTER PROCEDURE sp_CreateCallCenter(
	--@pIdCallCenter int,
	@pNombre varchar(50) = null,
	@pUbicacion varchar(100) = null,
	@pIdEmpresaAsistencia int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
	BEGIN
		Insert into CallCenter(nombre, ubicacion, IdEmpresaAsistencia)
		values (@pNombre, @pUbicacion, @pIdEmpresaAsistencia)

		declare @CallCenterCreado int
		set @CallCenterCreado = (select top 1 cc.IdCallCenter from CallCenter cc order by cc.IdCallCenter desc)

		Execute sp_CreateTelefonoCallCenter @CallCenterCreado, @pTelefono
	END
	else
		Raiserror('El IdEmpresaAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCallCenter(
	@pIdCallCenter int,
	@pNombre varchar(50) = null,
	@pUbicacion varchar(100) = null,
	@pIdEmpresaAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1
	BEGIN
		if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
		BEGIN
			update CallCenter
			set --IdCallCenter = @pIdCallCenter,
				nombre = isnull(@pNombre, nombre),
				ubicacion = isnull(@pUbicacion, ubicacion),
				IdEmpresaAsistencia = isnull(@pIdEmpresaAsistencia, IdEmpresaAsistencia)
	
			where IdCallCenter = @pIdCallCenter
		END
		else
			Raiserror('El IdEmpresaAsistencia ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCallCenter(
	@pIdCallCenter int)
AS
BEGIN
	if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1
	BEGIN
		select * from CallCenter cc
		where cc.IdCallCenter = @pIdCallCenter
	END
	else
		Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCallCenter(
	@pIdCallCenter int)
AS
BEGIN
	if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1
	BEGIN
		delete from CallCenter
		where IdCallCenter = @pIdCallCenter
	END
	else
		Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCallCenter 'PRUEBA', 'PRUEBA', 1
Execute sp_UpdateCallCenter 2, 'NUEVO NOMBRE', 'NUEVA UBICACION', 1
Execute sp_ReadCallCenter 2
Execute sp_DeleteCallCenter 2