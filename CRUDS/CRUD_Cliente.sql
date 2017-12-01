SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
ALTER PROCEDURE sp_CreateCliente(
	--@pIdCliente int, 
	@pNombre varchar(50) = null,
	@pEstado varchar(50) = null,
	@pDireccion varchar(100) = null,
	@pIdIdioma int = null,
	@pIdOrganizacion int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
	BEGIN
		if [dbo].fn_ExisteIdioma(@pIdIdioma) = 1 or @pIdIdioma is null
		BEGIN
			Insert into Cliente(Nombre, Estado, Direccion)
			values (@pNombre, @pEstado, @pDireccion)

			declare @ClienteCreado int
			set @ClienteCreado = (select top 1 c.IdCliente from Cliente c order by c.IdCliente desc)

			Execute sp_CreateClienteOrganizacion @ClienteCreado, @pIdOrganizacion
			Execute sp_CreateIdiomaCliente @ClienteCreado, @pIdIdioma
			Execute sp_CreateTelefonoCliente @ClienteCreado, @pTelefono
		END
		else
			Raiserror ('El Idioma ingresado no se encuentra en la base datos', 0, 0)
	END
	else
		Raiserror ('La Organizacion ingresada no se encuentra en la base datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCliente(
	@pIdCliente int,
	@pNombre varchar(50) = null,
	@pEstado varchar(50) = null,
	@pDireccion varchar(100) = null)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		update Cliente
		set --IdCliente = @pIdCliente, 
			nombre = isnull(@pNombre, nombre), 
			estado = isnull(@pEstado, estado),
			direccion = isnull(@pDireccion, direccion)

		where IdCliente = @pIdCliente
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCliente_nombre_estado(
	@pIdCliente int)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		select c.nombre, c.estado from Cliente c
		where c.IdCliente = @pIdCliente
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

CREATE PROCEDURE sp_ReadCliente_id_nombre(
	@pIdCliente int)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		select c.IdCliente, c.Nombre from Cliente c
		where c.IdCliente = @pIdCliente
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

CREATE PROCEDURE sp_ReadCliente(
	@pIdCliente int)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		select * from Cliente c
		where c.IdCliente = @pIdCliente
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCliente(
	@pIdCliente int)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		delete from Cliente
		where IdCliente = @pIdCliente
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCliente 1, 'PEPE', 'INVALIDO', 'DIRECCION'
Execute sp_UpdateCliente 17, 1, '3PRUEBA', 'PRUEBA', 'DIR'
Execute sp_ReadCliente 10
Execute sp_DeleteCliente 17
