SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateIdiomaEmpleado(
	--@pIdIdiomaEmpleado int, 
	@pIdEmpleado int = null,
	@pIdIdioma int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1 or @pIdEmpleado is null
	BEGIN
		if [dbo].fn_ExisteIdioma(@pIdIdioma) = 1 or @pIdIdioma is null
		BEGIN
			Insert into IdiomaEmpleado(IdEmpleado, IdIdioma)
			values (@pIdEmpleado, @pIdIdioma)
		END
		else
			Raiserror('El Idioma ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateIdiomaEmpleado(
	@pIdIdiomaEmpleado int, 
	@pIdEmpleado int = null,
	@pIdioma int = null)
AS
BEGIN
	if [dbo].fn_ExisteIdiomaEmpleado(@pIdIdiomaEmpleado) = 1
	BEGIN
		if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1 or @pIdEmpleado is null
		BEGIN
			if [dbo].fn_ExisteIdioma(@pIdioma) = 1 or @pIdioma is null
			BEGIN
				update IdiomaEmpleado
				set --IdIdiomaEmpleado = @pIdIdiomaEmpleado, 
					IdEmpleado = isnull(@pIdEmpleado, IdEmpleado),
					IdIdioma = isnull(@pIdioma, IdIdioma)

				where IdIdiomaEmpleado = @pIdIdiomaEmpleado
			END
			else
				Raiserror('El Idioma ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdIdiomaEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadIdiomaEmpleado(
	@pIdIdiomaEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteIdiomaEmpleado(@pIdIdiomaEmpleado) = 1
	BEGIN
		select * from IdiomaEmpleado ie
		where ie.IdIdiomaEmpleado = @pIdIdiomaEmpleado
	END
	else
		Raiserror('El IdIdiomaEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteIdiomaEmpleado(
	@pIdIdiomaEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteIdiomaEmpleado(@pIdIdiomaEmpleado) = 1
	BEGIN
		delete from IdiomaEmpleado
		where IdIdiomaEmpleado = @pIdIdiomaEmpleado
	END
	else
		Raiserror('El IdIdiomaEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateIdiomaEmpleado 1, 3
Execute sp_UpdateIdiomaEmpleado 28, 6
Execute sp_ReadIdiomaEmpleado 1
Execute sp_DeleteIdiomaEmpleado 28
