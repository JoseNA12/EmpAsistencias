SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateClientePaquete(
	--@pIdClientePaquete int, 
	@pIdCliente int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
	BEGIN
		if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
		BEGIN
			Insert into ClientePaquete(IdCliente, IdPaquete)
			values (@pIdCliente, @pIdPaquete)
		END
		else
			Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateClientePaquete(
	@pIdClientePaquete int, 
	@pIdCliente int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExisteClientePaquete(@pIdClientePaquete) = 1
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
		BEGIN
			if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
			BEGIN
				update ClientePaquete
				set --IdClientePaquete = @pIdClientePaquete, 
					IdCliente = isnull(@pIdCliente, IdCliente),
					IdPaquete = isnull(@pIdPaquete, IdPaquete)

				where IdClientePaquete = @pIdClientePaquete
			END
			else
				Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdClientePaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadClientePaquete(
	@pIdClientePaquete int)
AS
BEGIN
	if [dbo].fn_ExisteClientePaquete(@pIdClientePaquete) = 1
	BEGIN
		select * from ClientePaquete lc
		where lc.IdClientePaquete = @pIdClientePaquete
	END
	else
		Raiserror('El IdClientePaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteClientePaquete(
	@pIdClientePaquete int)
AS
BEGIN
	if [dbo].fn_ExisteClientePaquete(@pIdClientePaquete) = 1
	BEGIN
		delete from ClientePaquete
		where IdClientePaquete = @pIdClientePaquete
	END
	else
		Raiserror('El IdClientePaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateClientePaquete
Execute sp_UpdateClientePaquete 2
Execute sp_ReadClientePaquete 2
Execute sp_DeleteClientePaquete 2
