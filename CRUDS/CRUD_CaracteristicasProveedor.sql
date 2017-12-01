SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateCaracteristicasProveedor(
	--@pIdCaracteristicasProveedor int, 
	@pIdProveedor int = null,
	@pIdCaracteristica int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		if [dbo].fn_ExisteCaracteristica(@pIdCaracteristica) = 1 or @pIdCaracteristica is null
		BEGIN
			Insert into CaracteristicasProveedor(IdProveedor, IdCaracteristica)
			values (@pIdProveedor, @pIdCaracteristica)
		END
		else
			Raiserror('La Caracteristica ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCaracteristicasProveedor(
	@pIdCaracteristicasProveedor int, 
	@pIdProveedor int = null,
	@pIdCaracteristica int = null)
AS
BEGIN
	if [dbo].fn_ExisteCaracteristicasProveedor(@pIdCaracteristicasProveedor) = 1
	BEGIN
		if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
		BEGIN
			if [dbo].fn_ExisteCaracteristica(@pIdCaracteristica) = 1 or @pIdCaracteristica is null
			BEGIN
				update CaracteristicasProveedor
				set --IdCaracteristicasProveedor = @pIdCaracteristicasProveedor, 
					IdProveedor = isnull(@pIdProveedor, IdProveedor),
					IdCaracteristica = isnull(@pIdCaracteristica, IdCaracteristica)

				where IdCaracteristicasProveedor = @pIdCaracteristicasProveedor
			END
			else
				Raiserror('La Caracteristica ingresada no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdCaracteristicasProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCaracteristicasProveedor(
	@pIdCaracteristicasProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteCaracteristicasProveedor(@pIdCaracteristicasProveedor) = 1
	BEGIN
		select * from CaracteristicasProveedor cp
		where cp.IdCaracteristicasProveedor = @pIdCaracteristicasProveedor
	END
	else
		Raiserror('El IdCaracteristicasProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCaracteristicasProveedor(
	@pIdCaracteristicasProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteCaracteristicasProveedor(@pIdCaracteristicasProveedor) = 1
	BEGIN
		delete from CaracteristicasProveedor
		where IdCaracteristicasProveedor = @pIdCaracteristicasProveedor
	END
	else
		Raiserror('El IdCaracteristicasProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCaracteristicasProveedor 5, 4
Execute sp_UpdateCaracteristicasProveedor 10, 1
Execute sp_ReadCaracteristicasProveedor 5
Execute sp_DeleteCaracteristicasProveedor 10
