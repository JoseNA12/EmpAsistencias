SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateLlamadaEmpleado(
	--@pIdLlamadaEmpleado int, 
	@pIdLlamada int = null,
	@pIdEmpleado int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
	BEGIN
		if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1 or @pIdEmpleado is null
		BEGIN
			Insert into LlamadaEmpleado(IdLlamada, IdEmpleado)
			values (@pIdLlamada, @pIdEmpleado)
		END
		else
			Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateLlamadaEmpleado(
	@pIdLlamadaEmpleado int, 
	@pIdLlamada int = null,
	@pIdEmpleado int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaEmpleado(@pIdLlamadaEmpleado) = 1
	BEGIN
		if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1 or @pIdLlamada is null
		BEGIN
			if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1 or @pIdEmpleado is null
			BEGIN
				update LlamadaEmpleado
				set --IdLlamadaEmpleado = @pIdLlamadaEmpleado, 
					IdLlamada = isnull(@pIdLlamada, IdLlamada),
					IdEmpleado = isnull(@pIdEmpleado, IdEmpleado)

				where IdLlamadaEmpleado = @pIdLlamadaEmpleado
			END
			else
				Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdLlamadaEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadLlamadaEmpleado(
	@pIdLlamadaEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaEmpleado(@pIdLlamadaEmpleado) = 1
	BEGIN
		select * from LlamadaEmpleado lc
		where lc.IdLlamadaEmpleado = @pIdLlamadaEmpleado
	END
	else
		Raiserror('El IdLlamadaEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteLlamadaEmpleado(
	@pIdLlamadaEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteLlamadaEmpleado(@pIdLlamadaEmpleado) = 1
	BEGIN
		delete from LlamadaEmpleado
		where IdLlamadaEmpleado = @pIdLlamadaEmpleado
	END
	else
		Raiserror('El IdLlamadaEmpleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateLlamadaEmpleado 23
Execute sp_UpdateLlamadaEmpleado 2
Execute sp_ReadLlamadaEmpleado 6
Execute sp_DeleteLlamadaEmpleado 34
