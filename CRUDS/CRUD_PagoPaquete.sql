SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreatePagoPaquete(
	--@pIdPagoPaquete int,
	@pIdPago int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
	BEGIN
		if[dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
		BEGIN
			Insert into PagoPaquete(IdPago, IdPaquete)
			values (@pIdPago, @pIdPaquete)
		END
		else
			Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdatePagoPaquete(
	@pIdPagoPaquete int,
	@pIdPago int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExistePagoPaquete(@pIdPagoPaquete) = 1
	BEGIN
		if [dbo].fn_ExistePago(@pIdPago) = 1 or @pIdPago is null
		BEGIN
			if [dbo].fn_ExistePaquete(@pIdPaquete) = 1  or @pIdPaquete is null
			BEGIN
				update PagoPaquete
				set --IdPagoPaquete = @pIdPagoPaquete, 
					IdPago = isnull(@pIdPago, IdPago),
					IdPaquete = isnull(@pIdPaquete, IdPaquete)

				where IdPagoPaquete = @pIdPagoPaquete
			END
			else
				Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Pago ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdPagoPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadPagoPaquete(
	@pIdPagoPaquete int)
AS
BEGIN
	if [dbo].fn_ExistePagoPaquete(@pIdPagoPaquete) = 1
	BEGIN
		select * from PagoPaquete p
		where p.IdPagoPaquete = @pIdPagoPaquete
	END
	else
		Raiserror('El IdPagoPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeletePagoPaquete(
	@pIdPagoPaquete int)
AS
BEGIN
	if [dbo].fn_ExistePagoPaquete(@pIdPagoPaquete) = 1
	BEGIN
		delete from PagoPaquete
		where IdPagoPaquete = @pIdPagoPaquete
	END
	else
		Raiserror('El IdPagoPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreatePagoPaquete 1
Execute sp_UpdatePagoPaquete 22
Execute sp_ReadPagoPaquete 1
Execute sp_DeletePagoPaquete 22
