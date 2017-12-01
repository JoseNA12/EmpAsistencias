SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateProveedorSolicitud(
	--@pIdProveedorSolicitud int,
	@pIdProveedor int = null,
	@pIdSolicitud int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		if[dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1 or @pIdSolicitud is null
		BEGIN
			Insert into ProveedorSolicitud(IdProveedor, IdSolicitud)
			values (@pIdProveedor, @pIdSolicitud)
		END
		else
			Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateProveedorSolicitud(
	@pIdProveedorSolicitud int,
	@pIdProveedor int = null,
	@pIdSolicitud int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedorSolicitud(@pIdProveedorSolicitud) = 1
	BEGIN
		if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
		BEGIN
			if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1  or @pIdSolicitud is null
			BEGIN
				update ProveedorSolicitud
				set --IdProveedorSolicitud = @pIdProveedorSolicitud, 
					IdProveedor = isnull(@pIdProveedor, IdProveedor),
					IdSolicitud = isnull(@pIdSolicitud, IdSolicitud)

				where IdProveedorSolicitud = @pIdProveedorSolicitud
			END
			else
				Raiserror('La Solicitud ingresada no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdProveedorSolicitud ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadProveedorSolicitud(
	@pIdProveedorSolicitud int)
AS
BEGIN
	if [dbo].fn_ExisteProveedorSolicitud(@pIdProveedorSolicitud) = 1
	BEGIN
		select * from ProveedorSolicitud p
		where p.IdProveedorSolicitud = @pIdProveedorSolicitud
	END
	else
		Raiserror('El IdProveedorSolicitud ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteProveedorSolicitud(
	@pIdProveedorSolicitud int)
AS
BEGIN
	if [dbo].fn_ExisteProveedorSolicitud(@pIdProveedorSolicitud) = 1
	BEGIN
		delete from ProveedorSolicitud
		where IdProveedorSolicitud = @pIdProveedorSolicitud
	END
	else
		Raiserror('El IdProveedorSolicitud ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateProveedorSolicitud 1
Execute sp_UpdateProveedorSolicitud 22
Execute sp_ReadProveedorSolicitud 1
Execute sp_DeleteProveedorSolicitud 22
