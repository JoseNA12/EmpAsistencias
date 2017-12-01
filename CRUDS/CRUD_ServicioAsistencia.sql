SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateServicioAsistencia(
	--@pIdServicioAsistencia int,
	@pIdServicio int = null,
	@pIdAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
	BEGIN
		if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1 or @pIdAsistencia is null
		BEGIN
			Insert into ServicioAsistencia(IdServicio, IdAsistencia)
			values (@pIdServicio, @pIdAsistencia)
		END
		else
			Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateServicioAsistencia(
	@pIdServicioAsistencia int,
	@pIdServicio int = null,
	@pIdAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExisteServicioAsistencia(@pIdServicioAsistencia) = 1
	BEGIN
		if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
		BEGIN
			if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1 or @pIdAsistencia is null
			BEGIN
				update ServicioAsistencia
				set --IdServicioAsistencia = @pIdServicioAsistencia, 
					IdServicio = isnull(@pIdServicio, IdServicio),
					IdAsistencia = isnull(@pIdAsistencia, IdAsistencia)

				where IdServicioAsistencia = @pIdServicioAsistencia
			END
			else
				Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdServicioAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadServicioAsistencia(
	@pIdServicioAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteServicioAsistencia(@pIdServicioAsistencia) = 1
	BEGIN
		select * from ServicioAsistencia p
		where p.IdServicioAsistencia = @pIdServicioAsistencia
	END
	else
		Raiserror('El IdServicioAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteServicioAsistencia(
	@pIdServicioAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteServicioAsistencia(@pIdServicioAsistencia) = 1
	BEGIN
		delete from ServicioAsistencia
		where IdServicioAsistencia = @pIdServicioAsistencia
	END
	else
		Raiserror('El IdServicioAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateServicioAsistencia 2, 6
Execute sp_UpdateServicioAsistencia 8
Execute sp_ReadServicioAsistencia 1
Execute sp_DeleteServicioAsistencia 1
