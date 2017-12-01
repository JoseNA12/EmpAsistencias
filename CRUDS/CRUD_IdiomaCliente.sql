SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateIdiomaCliente(
	--@pIdIdiomaCliente int, 
	@pIdCliente int = null,
	@pIdIdioma int = null)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
	BEGIN
		if [dbo].fn_ExisteIdioma(@pIdIdioma) = 1 or @pIdIdioma is null
		BEGIN
			Insert into IdiomaCliente(IdCliente, IdIdioma)
			values (@pIdCliente, @pIdIdioma)
		END
		else
			Raiserror('El Idioma ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateIdiomaCliente(
	@pIdIdiomaCliente int, 
	@pIdCliente int = null,
	@pIdioma int = null)
AS
BEGIN
	if [dbo].fn_ExisteIdiomaCliente(@pIdIdiomaCliente) = 1
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
		BEGIN
			if [dbo].fn_ExisteIdioma(@pIdioma) = 1 or @pIdioma is null
			BEGIN
				update IdiomaCliente
				set --IdIdiomaCliente = @pIdIdiomaCliente, 
					IdCliente = isnull(@pIdCliente, IdCliente),
					IdIdioma = isnull(@pIdioma, IdIdioma)

				where IdIdiomaCliente = @pIdIdiomaCliente
			END
			else
				Raiserror('El Idioma ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdIdiomaCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadIdiomaCliente(
	@pIdIdiomaCliente int)
AS
BEGIN
	if [dbo].fn_ExisteIdiomaCliente(@pIdIdiomaCliente) = 1
	BEGIN
		select * from IdiomaCliente ie
		where ie.IdIdiomaCliente = @pIdIdiomaCliente
	END
	else
		Raiserror('El IdIdiomaCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteIdiomaCliente(
	@pIdIdiomaCliente int)
AS
BEGIN
	if [dbo].fn_ExisteIdiomaCliente(@pIdIdiomaCliente) = 1
	BEGIN
		delete from IdiomaCliente
		where IdIdiomaCliente = @pIdIdiomaCliente
	END
	else
		Raiserror('El IdIdiomaCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateIdiomaCliente 1, 3
Execute sp_UpdateIdiomaCliente 28, 6
Execute sp_ReadIdiomaCliente 1
Execute sp_DeleteIdiomaCliente 28
