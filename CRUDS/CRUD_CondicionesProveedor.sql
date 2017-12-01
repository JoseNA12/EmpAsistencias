SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateCondicionesProveedor(
	--@pIdCondicionesProveedor int, 
	@pIdProveedor int = null,
	@pIdCondicion int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		if [dbo].fn_ExisteCondicion(@pIdCondicion) = 1 or @pIdCondicion is null
		BEGIN
			Insert into CondicionesProveedor(IdProveedor, IdCondicion)
			values (@pIdProveedor, @pIdCondicion)
		END
		else
			Raiserror('La Condicion ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCondicionesProveedor(
	@pIdCondicionesProveedor int, 
	@pIdProveedor int = null,
	@pIdCondicion int = null)
AS
BEGIN
	if [dbo].fn_ExisteCondicionesProveedor(@pIdCondicionesProveedor) = 1
	BEGIN
		if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
		BEGIN
			if [dbo].fn_ExisteCondicion(@pIdCondicion) = 1 or @pIdCondicion is null
			BEGIN
				update CondicionesProveedor
				set --IdCondicionesProveedor = @pIdCondicionesProveedor, 
					IdProveedor = isnull(@pIdProveedor, IdProveedor),
					IdCondicion = isnull(@pIdCondicion, IdCondicion)

				where IdCondicionesProveedor = @pIdCondicionesProveedor
			END
			else
				Raiserror('La Condicion ingresada no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdCondicionesProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCondicionesProveedor(
	@pIdCondicionesProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteCondicionesProveedor(@pIdCondicionesProveedor) = 1
	BEGIN
		select * from CondicionesProveedor cp
		where cp.IdCondicionesProveedor = @pIdCondicionesProveedor
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCondicionesProveedor(
	@pIdCondicionesProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteCondicionesProveedor(@pIdCondicionesProveedor) = 1
	BEGIN
		delete from CondicionesProveedor
		where IdCondicionesProveedor = @pIdCondicionesProveedor
	END
	else
		Raiserror('El IdCondicionesProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCondicionesProveedor 1, 4
Execute sp_UpdateCondicionesProveedor 2, 3
Execute sp_ReadCondicionesProveedor 1
Execute sp_DeleteCondicionesProveedor 1
