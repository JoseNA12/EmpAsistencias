SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateIdioma(
	--@pIdIdioma int,
	@pIdioma varchar(50) = null)
AS
BEGIN
	Insert into Idioma(idioma)
	values (@pIdioma)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateIdioma(
	@pIdIdioma int,
	@pIdioma varchar(50) = null)
AS
BEGIN
	if [dbo].fn_ExisteIdioma(@pIdIdioma) = 1
	BEGIN
		update Idioma
		set --IdIdioma = @pIdIdioma,
			idioma = isnull(@pIdioma, idioma)
	
		where @pIdIdioma = IdIdioma
	END
	else
		Raiserror('El Idioma ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadIdioma(
	@pIdIdioma int)
AS
BEGIN
	if [dbo].fn_ExisteIdioma(@pIdIdioma) = 1
	BEGIN
		select * from Idioma t
		where t.IdIdioma = @pIdIdioma
	END
	else
		Raiserror('El Idioma ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteIdioma(
	@pIdIdioma int)
AS
BEGIN
	if [dbo].fn_ExisteIdioma(@pIdIdioma) = 1
	BEGIN
		if [dbo].fn_ExisteIdiomaEnEmpleado(@pIdIdioma) = 0
		BEGIN
			delete from Idioma
			where IdIdioma = @pIdIdioma
		END
		else
			Raiserror('El Idioma ingresado se encuentra asociado a uno o varios empleados. Elimine la relación primero', 0, 0)
	END
	else
		Raiserror('El Idioma ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateIdioma 'CAREPINGA'
Execute sp_UpdateIdioma 7, 'PINGUIN'
Execute sp_ReadIdioma 6
Execute sp_DeleteIdioma 2