SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateDisponibilidadProveedor(
	--@pIdDisponibilidadProveedor int, 
	@pIdProveedor int = null,
	@pDisponibilidad time = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		Insert into DisponibilidadProveedor(IdProveedor, disponibilidad)
		values (@pIdProveedor, @pDisponibilidad)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateDisponibilidadProveedor(
	@pIdDisponibilidadProveedor int, 
	@pIdProveedor int = null,
	@pDisponibilidad time = null)
AS
BEGIN
	if [dbo].fn_ExisteDisponibilidadProveedor(@pIdDisponibilidadProveedor) = 1
	BEGIN
		update DisponibilidadProveedor
		set --IdDisponibilidadProveedor = @pIdDisponibilidadProveedor, 
			IdProveedor = isnull(@pIdProveedor, IdProveedor), 
			@pDisponibilidad = isnull(@pDisponibilidad, disponibilidad)

		where IdDisponibilidadProveedor = @pIdDisponibilidadProveedor
	END
	else
		Raiserror('El IDDisponibilidadProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadDisponibilidadProveedor(
	@pIdDisponibilidadProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteDisponibilidadProveedor(@pIdDisponibilidadProveedor) = 1
	BEGIN
		select * from DisponibilidadProveedor c
		where c.IdDisponibilidadProveedor = @pIdDisponibilidadProveedor
	END
	else
		Raiserror('El IDDisponibilidadProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteDisponibilidadProveedor(
	@pIdDisponibilidadProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteDisponibilidadProveedor(@pIdDisponibilidadProveedor) = 1
	BEGIN
		delete from DisponibilidadProveedor
		where IdDisponibilidadProveedor = @pIdDisponibilidadProveedor
	END
	else
		Raiserror('El IdDisponibilidadProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateDisponibilidadProveedor 16, 3
Execute sp_UpdateDisponibilidadProveedor 3, 4
Execute sp_ReadDisponibilidadProveedor 16
Execute sp_DeleteDisponibilidadProveedor 3
