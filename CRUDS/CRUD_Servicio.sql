SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateServicio(
	--@pIdServicio int,
	@pEstado varchar(50) = null,
	@pTipo varchar(50) = null)
AS
BEGIN
	Insert into Servicio(estado, tipo)
	values (@pEstado, @pTipo)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateServicio(
	@pIdServicio int,
	@pEstado varchar(50) = null,
	@pTipo varchar(50) = null)
AS
BEGIN
	if [dbo].fn_ExisteServicio(@pIdServicio) = 1
	BEGIN
		update Servicio
		set --IdServicio = @pIdServicio, 
			estado = isnull(@pEstado, estado),
			tipo = isnull(@pTipo, tipo)

		where IdServicio = @pIdServicio
	END
	else
		Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadServicio(
	@pIdServicio int)
AS
BEGIN
	if [dbo].fn_ExisteServicio(@pIdServicio) = 1
	BEGIN
		select * from Servicio s
		where s.IdServicio = @pIdServicio
	END
	else
		Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteServicio(
	@pIdServicio int)
AS
BEGIN
	if [dbo].fn_ExisteServicio(@pIdServicio) = 1
	BEGIN
		delete from Servicio
		where IdServicio = @pIdServicio
	END
	else
		Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateServicio 'JAJAJA'
Execute sp_UpdateServicio 1, 'EJEJEJE'
Execute sp_ReadServicio 1
Execute sp_DeleteServicio 17