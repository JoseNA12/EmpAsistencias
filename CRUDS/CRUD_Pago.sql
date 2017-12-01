SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreatePago(
	--@pIdPago int,
	@pMonto money = null,
	@pEstado varchar(50) = null,
	--@pFecha date = null,
	--@pHora time = null,
	@pIdTipoPago int = null)
AS
BEGIN
	if [dbo].fn_ExisteTipoPago(@pIdTipoPago) = 1 or @pIdTipoPago is null
	BEGIN
		Insert into Pago(monto, estado, fecha, hora, IdTipoPago)
		values (@pMonto, @pEstado, (select cast(getdate() as date)), (select cast(getdate() as time)), @pIdTipoPago)
	END
	else
		Raiserror('El Tipo de Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdatePago(
	@pIdPago int,
	@pMonto money = null,
	@pEstado varchar(50) = null,
	@pFecha date = null,
	@pHora time = null,
	@pIdTipoPago int = null)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1
	BEGIN
		if [dbo].fn_ExisteTipoPago(@pIdTipoPago) = 1 or @pIdTipoPago is null
		BEGIN
			update Pago
			set --IdPago = @pIdPago, 
				monto = isnull(@pMonto, monto),
				estado = isnull(@pEstado, estado),
				fecha = isnull(@pFecha, fecha),
				hora = isnull(@pHora, hora),
				IdTipoPago = isnull(@pIdTipoPago, IdTipoPago)

			where IdPago = @pIdPago
		END
		else
			Raiserror('El Tipo de Pago ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadPago(
	@pIdPago int)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1
	BEGIN
		select * from Pago p
		where p.IdPago = @pIdPago
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeletePago(
	@pIdPago int)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1
	BEGIN
		delete from Pago
		where IdPago = @pIdPago
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreatePago 3456, 'Prueba', NULL, NULL, NULL
Execute sp_UpdatePago 2, 3456, 'PINGUIN', NULL, NULL, NULL
Execute sp_ReadPago 2
Execute sp_DeletePago 3