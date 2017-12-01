SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateCalificacionesCliente(
	--@pIdCalificacionesCliente int, 
	@pIdCliente int = null,
	@pCalificacion tinyint = null)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1 or @pIdCliente is null
	BEGIN
		if (@pCalificacion between 0 and 5) or (@pCalificacion is null)
		BEGIN	
			Insert into CalificacionesCliente(IdCliente, calificacion)
			values (@pIdCliente, @pCalificacion)
		END
		else
			Raiserror('La Calificaciones ingresada debe de estar en un rango de 0 a 5', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCalificacionesCliente(
	@pIdCalificacionesCliente int, 
	@pIdCliente int = null,
	@pCalificacion tinyint = null)
AS
BEGIN
	if [dbo].fn_ExisteCalificacionesCliente(@pIdCalificacionesCliente) = 1
	BEGIN
		if (@pCalificacion between 0 and 5) or (@pCalificacion is null)
		BEGIN	 
			update CalificacionesCliente
			set --IdCalificacionesCliente = @pIdCalificacionesCliente, 
				IdCliente = isnull(@pIdCliente, IdCliente), 
				calificacion = isnull(@pCalificacion, calificacion)

			where IdCalificacionesCliente = @pIdCalificacionesCliente
		END
		else
			Raiserror('La Calificaciones ingresada debe de estar en un rango de 0 a 5', 0, 0)
	END
	else
		Raiserror('El IDCalificacionesCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCalificacionesCliente(
	@pIdCalificacionesCliente int)
AS
BEGIN
	if [dbo].fn_ExisteCalificacionesCliente(@pIdCalificacionesCliente) = 1
	BEGIN
		select * from CalificacionesCliente c
		where c.IdCalificacionesCliente = @pIdCalificacionesCliente
	END
	else
		Raiserror('El IDCalificacionesCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCalificacionesCliente(
	@pIdCalificacionesCliente int)
AS
BEGIN
	if [dbo].fn_ExisteCalificacionesCliente(@pIdCalificacionesCliente) = 1
	BEGIN
		delete from CalificacionesCliente
		where IdCalificacionesCliente = @pIdCalificacionesCliente
	END
	else
		Raiserror('El IdCalificacionesCliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCalificacionesCliente 16, 3
Execute sp_UpdateCalificacionesCliente 3, 4
Execute sp_ReadCalificacionesCliente 16
Execute sp_DeleteCalificacionesCliente 3
