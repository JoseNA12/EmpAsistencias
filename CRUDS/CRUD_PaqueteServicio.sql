SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreatePaqueteServicio(
	--@pIdPaqueteServicio int,
	@pIdPaquete int = null,
	@pIdServicio int = null)
AS
BEGIN
	if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
	BEGIN
		if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
		BEGIN
			Insert into PaqueteServicio(IdPaquete, IdServicio)
			values (@pIdPaquete, @pIdServicio)
		END
		else
			Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdatePaqueteServicio(
	@pIdPaqueteServicio int,
	@pIdPaquete int = null,
	@pIdServicio int = null)
AS
BEGIN
	if [dbo].fn_ExistePaqueteServicio(@pIdPaqueteServicio) = 1
	BEGIN
		if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
		BEGIN
			if [dbo].fn_ExisteServicio(@pIdServicio) = 1 or @pIdServicio is null
			BEGIN
				update PaqueteServicio
				set --IdPaqueteServicio = @pIdPaqueteServicio, 
					IdPaquete = isnull(@pIdPaquete, IdPaquete),
					IdServicio = isnull(@pIdServicio, IdServicio)

				where IdPaqueteServicio = @pIdPaqueteServicio
			END
			else
				Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdPaqueteServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadPaqueteServicio(
	@pIdPaqueteServicio int)
AS
BEGIN
	if [dbo].fn_ExistePaqueteServicio(@pIdPaqueteServicio) = 1
	BEGIN
		select * from PaqueteServicio ps
		where ps.IdPaqueteServicio = @pIdPaqueteServicio
	END
	else
		Raiserror('El IdPaqueteServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeletePaqueteServicio(
	@pIdPaqueteServicio int)
AS
BEGIN
	if [dbo].fn_ExistePaqueteServicio(@pIdPaqueteServicio) = 1
	BEGIN
		delete from PaqueteServicio
		where IdPaqueteServicio = @pIdPaqueteServicio
	END
	else
		Raiserror('El IdPaqueteServicio ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreatePaqueteServicio 1
Execute sp_UpdatePaqueteServicio 3
Execute sp_ReadPaqueteServicio 1
Execute sp_DeletePaqueteServicio 22
