SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
ALTER PROCEDURE sp_CreateEmpresaAsistencia(
	--@pIdEmpresaAsistencia int, 
	@pNombre varchar(50) = null,
	@pCedulaJuridica int = null,
	@pUbicacion varchar(50) = null,
	@pTelefono int = null)
AS
BEGIN
	Insert into EmpresaAsistencia(nombre, cedulaJuridica, ubicacion)
	values (@pNombre, @pCedulaJuridica, @pUbicacion)

	declare @EmpresaAsistenciaCreada int
	set @EmpresaAsistenciaCreada = (select top 1 ea.IdEmpresaAsistencia from EmpresaAsistencia ea order by ea.IdEmpresaAsistencia desc)

	Execute sp_CreateTelefonoEmpresaAsistencia @EmpresaAsistenciaCreada, @pTelefono
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateEmpresaAsistencia(
	@pIdEmpresaAsistencia int, 
	@pNombre varchar(50) = null,
	@pCedulaJuridica int = null,
	@pUbicacion varchar(50) = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1
	BEGIN
		update EmpresaAsistencia
		set --IdEmpresaAsistencia = @pIdEmpresaAsistencia, 
			nombre = isnull(@pNombre, nombre),
			cedulaJuridica = isnull(@pCedulaJuridica, cedulaJuridica),
			ubicacion = isnull(@pUbicacion, ubicacion)

		where IdEmpresaAsistencia = @pIdEmpresaAsistencia
	END
	else
		Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadEmpresaAsistencia(
	@pIdEmpresaAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1
	BEGIN
		select * from EmpresaAsistencia ea
		where ea.IdEmpresaAsistencia = @pIdEmpresaAsistencia
	END
	else
		Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteEmpresaAsistencia(
	@pIdEmpresaAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1
	BEGIN
		delete from EmpresaAsistencia
		where IdEmpresaAsistencia = @pIdEmpresaAsistencia
	END
	else
		Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
END
GO
