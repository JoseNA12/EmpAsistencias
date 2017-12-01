SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateCondicion(
	--@pIdCondicion int,
	@pCondicion varchar(50) = null)
AS
BEGIN
	Insert into Condicion(condicion)
	values (@pCondicion)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCondicion(
	@pIdCondicion int,
	@pCondicion varchar(50) = null)
AS
BEGIN
	if [dbo].fn_ExisteCondicion(@pIdCondicion) = 1
	BEGIN
		update Condicion
		set --IdCondicion = @pIdCondicion,
			condicion = isnull(@pCondicion, condicion)
	
		where @pIdCondicion = IdCondicion
	END
	else
		Raiserror('La Condicion ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCondicion(
	@pIdCondicion int)
AS
BEGIN
	if [dbo].fn_ExisteCondicion(@pIdCondicion) = 1
	BEGIN
		select * from Condicion t
		where t.IdCondicion = @pIdCondicion
	END
	else
		Raiserror('La Condicion ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCondicion(
	@pIdCondicion int)
AS
BEGIN
	if [dbo].fn_ExisteCondicion(@pIdCondicion) = 1
	BEGIN
		if [dbo].fn_ExisteCondicionEnProveedores(@pIdCondicion) = 0
		BEGIN
			delete from Condicion
			where IdCondicion = @pIdCondicion
		END
		else
			Raiserror('La Condicion ingresada se encuentra asociada a uno o varios proveedores. Elimine la relación primero', 0, 0)
	END
	else
		Raiserror('La Condicion ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCondicion 'CONDICION_mil'
Execute sp_UpdateCondicion 2, 'PRUEBAAaAaA'
Execute sp_ReadCondicion 6
Execute sp_DeleteCondicion 34