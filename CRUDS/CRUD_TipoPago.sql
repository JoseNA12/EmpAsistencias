SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTipoPago(
	--@pIdTipoPago int,
	@pTipo varchar(50) = null)
AS
BEGIN
	Insert into TipoPago(tipo)
	values (@pTipo)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTipoPago(
	@pIdTipoPago int,
	@pTipo varchar(50) = null)
AS
BEGIN
	if [dbo].fn_ExisteTipoPago(@pIdTipoPago) = 1
	BEGIN
		update TipoPago
		set --IdTipoPago = @pIdTipoPago,
			tipo = isnull(@pTipo, tipo)
	
		where @pIdTipoPago = IdTipoPago
	END
	else
		Raiserror('El TipoPago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTipoPago(
	@pIdTipoPago int)
AS
BEGIN
	if [dbo].fn_ExisteTipoPago(@pIdTipoPago) = 1
	BEGIN
		select * from TipoPago t
		where t.IdTipoPago = @pIdTipoPago
	END
	else
		Raiserror('El TipoPago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTipoPago(
	@pIdTipoPago int)
AS
BEGIN
	if [dbo].fn_ExisteTipoPago(@pIdTipoPago) = 1
	BEGIN
		delete from TipoPago
		where IdTipoPago = @pIdTipoPago
	END
	else
		Raiserror('El TipoPago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTipoPago 'JAJAJA'
Execute sp_UpdateTipoPago 5, 'EJEJEJE'
Execute sp_ReadTipoPago 5
Execute sp_DeleteTipoPago 5