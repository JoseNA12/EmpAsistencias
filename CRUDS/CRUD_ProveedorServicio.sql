SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateProveedorServicio(
	--@pIdProveedorServicio int,
	@pIdServicio int = null,
	@pIdProveedor int = null)
AS
BEGIN
	if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
	BEGIN
		if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
		BEGIN
			Insert into ProveedorServicio(IdServicio, IdProveedor)
			values (@pIdServicio, @pIdProveedor)
		END
		else
			Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateProveedorServicio(
	@pIdProveedorServicio int,
	@pIdServicio int = null,
	@pIdProveedor int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedorServicio(@pIdProveedorServicio) = 1
	BEGIN
		if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
		BEGIN
			if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
			BEGIN
				update ProveedorServicio
				set --IdProveedorServicio = @pIdProveedorServicio, 
					IdServicio = isnull(@pIdServicio, IdServicio),
					IdProveedor = isnull(@pIdProveedor, IdProveedor)

				where IdProveedorServicio = @pIdProveedorServicio
			END
			else
				Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdProveedorServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadProveedorServicio(
	@pIdProveedorServicio int)
AS
BEGIN
	if [dbo].fn_ExisteProveedorServicio(@pIdProveedorServicio) = 1
	BEGIN
		select * from ProveedorServicio p
		where p.IdProveedorServicio = @pIdProveedorServicio
	END
	else
		Raiserror('El IdProveedorServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteProveedorServicio(
	@pIdProveedorServicio int)
AS
BEGIN
	if [dbo].fn_ExisteProveedorServicio(@pIdProveedorServicio) = 1
	BEGIN
		delete from ProveedorServicio
		where IdProveedorServicio = @pIdProveedorServicio
	END
	else
		Raiserror('El IdProveedorServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateProveedorServicio 2, 6
Execute sp_UpdateProveedorServicio 8
Execute sp_ReadProveedorServicio 1
Execute sp_DeleteProveedorServicio 3
