SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateClienteAsistencia(
	--IdClienteAsistencia int, 
	@pIdCliente int = null,
	@pIdAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
	BEGIN
		if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1 or @pIdAsistencia is null
		BEGIN
			Insert into ClienteAsistencia(IdCliente, IdAsistencia)
			values (@pIdCliente, @pIdAsistencia)
		END
		else
			Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateClienteAsistencia(
	@pIdClienteAsistencia int, 
	@pIdCliente int = null,
	@pIdAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExisteClienteAsistencia(@pIdClienteAsistencia) = 1
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
		BEGIN
			if [dbo].fn_ExisteAsistencia(@pIdAsistencia) = 1 or @pIdAsistencia is null
			BEGIN
				update ClienteAsistencia
				set --IdClienteAsistencia = @pIdClienteAsistencia, 
					IdCliente = isnull(@pIdCliente, IdCliente), 
					IdAsistencia = isnull(@pIdAsistencia, IdAsistencia)

				where IdClienteAsistencia = @pIdClienteAsistencia
			END
			else
				Raiserror('La Asistencia ingresada no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdClienteAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadClienteAsistencia(
	@pIdClienteAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteClienteAsistencia(@pIdClienteAsistencia) = 1
	BEGIN
		select * from ClienteAsistencia c
		where c.IdClienteAsistencia = @pIdClienteAsistencia
	END
	else
		Raiserror('El IdClienteAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteClienteAsistencia(
	@pIdClienteAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteClienteAsistencia(@pIdClienteAsistencia) = 1
	BEGIN
		delete from ClienteAsistencia
		where IdClienteAsistencia = @pIdClienteAsistencia
	END
	else
		Raiserror('El IdClienteAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateClienteAsistencia 7, 4
Execute sp_UpdateClienteAsistencia 1, null, null
Execute sp_ReadClienteAsistencia 1
Execute sp_DeleteClienteAsistencia 1