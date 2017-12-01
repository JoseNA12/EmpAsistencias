SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreatePagoServicio(
	--@pIdPagoServicio int,
	@pIdPago int = null,
	@pIdServicio int = null)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
	BEGIN
		if[dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
		BEGIN
			Insert into PagoServicio(IdPago, IdServicio)
			values (@pIdPago, @pIdServicio)
		END
		else
			Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdatePagoServicio(
	@pIdPagoServicio int,
	@pIdPago int = null,
	@pIdServicio int = null)
AS
BEGIN
	if [dbo].fn_ExistePagoServicio(@pIdPagoServicio) = 1
	BEGIN
		if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
		BEGIN
			if [dbo].fn_ExisteServicio(@pIdServicio) = 1  or @pIdServicio is null
			BEGIN
				update PagoServicio
				set --IdPagoServicio = @pIdPagoServicio, 
					IdPago = isnull(@pIdPago, IdPago),
					IdServicio = isnull(@pIdServicio, IdServicio)

				where IdPagoServicio = @pIdPagoServicio
			END
			else
				Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdPagoServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadPagoServicio(
	@pIdPagoServicio int)
AS
BEGIN
	if [dbo].fn_ExistePagoServicio(@pIdPagoServicio) = 1
	BEGIN
		select * from PagoServicio p
		where p.IdPagoServicio = @pIdPagoServicio
	END
	else
		Raiserror('El IdPagoServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeletePagoServicio(
	@pIdPagoServicio int)
AS
BEGIN
	if [dbo].fn_ExistePagoServicio(@pIdPagoServicio) = 1
	BEGIN
		delete from PagoServicio
		where IdPagoServicio = @pIdPagoServicio
	END
	else
		Raiserror('El IdPagoServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreatePagoServicio 1
Execute sp_UpdatePagoServicio 22
Execute sp_ReadPagoServicio 1
Execute sp_DeletePagoServicio 22
