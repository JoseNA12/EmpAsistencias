SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateLlamadaCliente(
	--@pIdLlamadaCliente int, 
	@pIdLlamada int = null,
	@pIdCliente int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
		BEGIN
			Insert into LlamadaCliente(IdLlamada, IdCliente)
			values (@pIdLlamada, @pIdCliente)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateLlamadaCliente(
	@pIdLlamadaCliente int, 
	@pIdLlamada int = null,
	@pIdCliente int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaCliente(@pIdLlamadaCliente) = 1
	BEGIN
		if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
		BEGIN
			if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
			BEGIN
				update LlamadaCliente
				set --IdLlamadaCliente = @pIdLlamadaCliente, 
					IdLlamada = isnull(@pIdLlamada, IdLlamada),
					IdCliente = isnull(@pIdCliente, IdCliente)

				where IdLlamadaCliente = @pIdLlamadaCliente
			END
			else
				Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdLlamadaCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadLlamadaCliente(
	@pIdLlamadaCliente int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaCliente(@pIdLlamadaCliente) = 1
	BEGIN
		select * from LlamadaCliente lc
		where lc.IdLlamadaCliente = @pIdLlamadaCliente
	END
	else
		Raiserror('El IdLlamadaCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteLlamadaCliente(
	@pIdLlamadaCliente int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaCliente(@pIdLlamadaCliente) = 1
	BEGIN
		delete from LlamadaCliente
		where IdLlamadaCliente = @pIdLlamadaCliente
	END
	else
		Raiserror('El IdLlamadaCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateLlamadaCliente 23
Execute sp_UpdateLlamadaCliente 2
Execute sp_ReadLlamadaCliente 6
Execute sp_DeleteLlamadaCliente 34
