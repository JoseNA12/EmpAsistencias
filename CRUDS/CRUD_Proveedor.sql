SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
ALTER PROCEDURE sp_CreateProveedor(
	--@pIdProveedor int, 
	@pNombre varchar(50) = null,
	@pPrecio money = null,
	@pEstado varchar(50) = null,
	@pIdEmpresaAsistencia int = null,
	@pTelefono int = null,
	@pHoraDisponible time = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
	BEGIN
		Insert into Proveedor(nombre, precio, estado, IdEmpresaAsistencia)
		values (@pNombre, @pPrecio, @pEstado, @pIdEmpresaAsistencia)

		declare @ProveedorCreado int
		set @ProveedorCreado = (select top 1 p.IdProveedor from Proveedor p order by p.IdProveedor desc)

		Execute sp_CreateTelefonoProveedor @ProveedorCreado, @pTelefono
		Execute sp_CreateDisponibilidadProveedor @ProveedorCreado, @pHoraDisponible
	END
	else
		Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateProveedor(
	@pIdProveedor int, 
	@pNombre varchar(50) = null,
	@pPrecio money = null,
	@pEstado varchar(50) = null,
	@pIdEmpresaAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1
	BEGIN
		if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
		BEGIN
			update Proveedor
			set --IdProveedor = @pIdProveedor, 
				nombre = isnull(@pNombre, nombre),
				precio = isnull(@pPrecio, precio),
				estado = isnull(@pEstado, estado),
				IdEmpresaAsistencia = isnull(@pIdEmpresaAsistencia, IdEmpresaAsistencia)

			where IdProveedor = @pIdProveedor
		END
		else
			Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END 
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadProveedor(
	@pIdProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1
	BEGIN
		select * from Proveedor p
		where p.IdProveedor = @pIdProveedor
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteProveedor(
	@pIdProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1
	BEGIN
		delete from Proveedor
		where IdProveedor = @pIdProveedor
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateProveedor 'PEPEE', 1232, 'LISTO PAPU', 'KALITÉ', 1
Execute sp_UpdateProveedor 20, 'SASASA', 123213, 'DSD', 'SDD', 1
Execute sp_ReadProveedor 20
Execute sp_DeleteProveedor 20
