SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateClienteOrganizacion(
	--IdClienteOrganizacion int, 
	@pIdCliente int = null,
	@pIdOrganizacion int = null)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
	BEGIN
		if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
		BEGIN
			Insert into ClienteOrganizacion(IdCliente, IdOrganizacion)
			values (@pIdCliente, @pIdOrganizacion)
		END
		else
			Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateClienteOrganizacion(
	@pIdClienteOrganizacion int, 
	@pIdCliente int = null,
	@pIdOrganizacion int = null)
AS
BEGIN
	if [dbo].fn_ExisteClienteOrganizacion(@pIdClienteOrganizacion) = 1
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
		BEGIN
			if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
			BEGIN
				update ClienteOrganizacion
				set --IdClienteOrganizacion = @pIdClienteOrganizacion, 
					IdCliente = isnull(@pIdCliente, IdCliente), 
					IdOrganizacion = isnull(@pIdOrganizacion, IdOrganizacion)

				where IdClienteOrganizacion = @pIdClienteOrganizacion
			END
			else
				Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdClienteOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadClienteOrganizacion(
	@pIdClienteOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteClienteOrganizacion(@pIdClienteOrganizacion) = 1
	BEGIN
		select * from ClienteOrganizacion c
		where c.IdClienteOrganizacion = @pIdClienteOrganizacion
	END
	else
		Raiserror('El IdClienteOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteClienteOrganizacion(
	@pIdClienteOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteClienteOrganizacion(@pIdClienteOrganizacion) = 1
	BEGIN
		delete from ClienteOrganizacion
		where IdClienteOrganizacion = @pIdClienteOrganizacion
	END
	else
		Raiserror('El IdClienteOrganizacion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateClienteOrganizacion 7, 4
Execute sp_UpdateClienteOrganizacion 1, null, null
Execute sp_ReadClienteOrganizacion 1
Execute sp_DeleteClienteOrganizacion 1