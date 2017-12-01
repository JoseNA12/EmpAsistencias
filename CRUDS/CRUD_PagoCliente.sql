SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreatePagoCliente(
	--@pIdPagoCliente int,
	@pIdPago int = null,
	@pIdCliente int = null)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
	BEGIN
		if[dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
		BEGIN
			Insert into PagoCliente(IdPago, IdCliente)
			values (@pIdPago, @pIdCliente)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdatePagoCliente(
	@pIdPagoCliente int,
	@pIdPago int = null,
	@pIdCliente int = null)
AS
BEGIN
	if [dbo].fn_ExistePagoCliente(@pIdPagoCliente) = 1
	BEGIN
		if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
		BEGIN
			if [dbo].fn_ExisteCliente(@pIdCliente) = 1  or @pIdCliente is null
			BEGIN
				update PagoCliente
				set --IdPagoCliente = @pIdPagoCliente, 
					IdPago = isnull(@pIdPago, IdPago),
					IdCliente = isnull(@pIdCliente, IdCliente)

				where IdPagoCliente = @pIdPagoCliente
			END
			else
				Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdPagoCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadPagoCliente(
	@pIdPagoCliente int)
AS
BEGIN
	if [dbo].fn_ExistePagoCliente(@pIdPagoCliente) = 1
	BEGIN
		select * from PagoCliente p
		where p.IdPagoCliente = @pIdPagoCliente
	END
	else
		Raiserror('El IdPagoCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeletePagoCliente(
	@pIdPagoCliente int)
AS
BEGIN
	if [dbo].fn_ExistePagoCliente(@pIdPagoCliente) = 1
	BEGIN
		delete from PagoCliente
		where IdPagoCliente = @pIdPagoCliente
	END
	else
		Raiserror('El IdPagoCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreatePagoCliente 1
Execute sp_UpdatePagoCliente 22
Execute sp_ReadPagoCliente 1
Execute sp_DeletePagoCliente 22
