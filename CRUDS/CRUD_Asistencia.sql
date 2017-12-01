SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateAsistencia(
	--@pIdAsistencia int, 
	@pTipo varchar(50) = null,
	@pIdEmpresaAsistencia int = null,
	@pIdServicio int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
	BEGIN
		if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
		BEGIN
			Insert into Asistencia(tipo, IdEmpresaAsistencia, IdServicio)
			values (@pTipo, @pIdEmpresaAsistencia, @pIdServicio)
		END
		else
			Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateAsistencia(
	@pIdAsistencia int, 
	@pTipo varchar(50) = null,
	@pIdEmpresaAsistencia int = null,
	@pIdServicio int = null)
AS
BEGIN
	if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1
	BEGIN
		if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
		BEGIN
			if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
			BEGIN
				update Asistencia
				set --IdAsistencia = @pIdAsistencia, 
					tipo = isnull(@pTipo, tipo),  
					IdEmpresaAsistencia = isnull(@pIdEmpresaAsistencia, IdEmpresaAsistencia),
					IdServicio = isnull(@pIdServicio, IdServicio)

				where IdAsistencia = @pIdAsistencia
			END
			else
				Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadAsistencia_Id_Serv(
	@pIdAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1
	BEGIN
		select a.IdAsistencia, a.IdServicio from Asistencia a
		where a.IdAsistencia = @pIdAsistencia
	END
	else
		Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
END
GO


CREATE PROCEDURE sp_ReadAsistencia_Id_tipo_IdEmpAsit(
	@pIdAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1
	BEGIN
		select a.IdAsistencia, a.tipo, a.IdEmpresaAsistencia from Asistencia a
		where a.IdAsistencia = @pIdAsistencia
	END
	else
		Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
END
GO

CREATE PROCEDURE sp_ReadAsistencia_Tipo_Descripcion(
	@pIdAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1
	BEGIN
		select a.tipo, a.descripcion from Asistencia a
		where a.IdAsistencia = @pIdAsistencia
	END
	else
		Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteAsistencia(
	@pIdAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1
	BEGIN
		delete from Asistencia
		where IdAsistencia = @pIdAsistencia
	END
	else
		Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateAsistencia 'TipoPRUEBA', 'DescripcionPRUEBA', 1
Execute sp_UpdateAsistencia 22, '3PRUEBA', 'PRUEBA', 1
Execute sp_ReadAsistencia 1
Execute sp_DeleteAsistencia 22