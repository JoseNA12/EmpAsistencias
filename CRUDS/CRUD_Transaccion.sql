SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTransaccion(
	--@pIdTransaccion int, 
	@pIdPago int = null,
	@pEstado int = null)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
	BEGIN
		Insert into Transaccion(IdPago, Estado)
		values (@pIdPago, @pEstado)
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTransaccion(
	@pIdTransaccion int, 
	@pIdPago int = null,
	@pEstado int = null)
AS
BEGIN
	if [dbo].fn_ExisteTransaccion(@pIdTransaccion) = 1
	BEGIN
		if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
		BEGIN

			update Transaccion
			set --IdTransaccion = @pIdTransaccion, 
				IdPago = isnull(@pIdPago, IdPago),
				Estado = isnull(@pEstado, Estado)

			where IdTransaccion = @pIdTransaccion

		END
		else
			Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdTransaccion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTransaccion(
	@pIdTransaccion int)
AS
BEGIN
	if [dbo].fn_ExisteTransaccion(@pIdTransaccion) = 1
	BEGIN
		select * from Transaccion ie
		where ie.IdTransaccion = @pIdTransaccion
	END
	else
		Raiserror('El IdTransaccion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTransaccion(
	@pIdTransaccion int)
AS
BEGIN
	if [dbo].fn_ExisteTransaccion(@pIdTransaccion) = 1
	BEGIN
		delete from Transaccion
		where IdTransaccion = @pIdTransaccion
	END
	else
		Raiserror('El IdTransaccion ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTransaccion 1, 3
Execute sp_UpdateTransaccion 28, 6
Execute sp_ReadTransaccion 1
Execute sp_DeleteTransaccion 28
