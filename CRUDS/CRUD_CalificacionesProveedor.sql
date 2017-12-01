SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateCalificacionesProveedor(
	--@pIdCalificacionesProveedor int, 
	@pIdProveedor int = null,
	@pCalificacion tinyint = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		if (@pCalificacion between 0 and 5) or (@pCalificacion is null)
		BEGIN	
			Insert into CalificacionesProveedor(IdProveedor, calificacion, fecha)
			values (@pIdProveedor, @pCalificacion, getDate())
		END
		else
			Raiserror('La Calificaciones ingresada debe de estar en un rango de 0 a 5', 0, 0)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCalificacionesProveedor(
	@pIdCalificacionesProveedor int, 
	@pIdProveedor int = null,
	@pCalificacion tinyint = null,
	@pFecha date = null, 
	@pFechaDesbaneo date = null)
AS
BEGIN
	if [dbo].fn_ExisteCalificacionesProveedor(@pIdCalificacionesProveedor) = 1
	BEGIN
		if (@pCalificacion between 0 and 5) or (@pCalificacion is null)
		BEGIN	 
			update CalificacionesProveedor
			set --IdCalificacionesProveedor = @pIdCalificacionesProveedor, 
				IdProveedor = isnull(@pIdProveedor, IdProveedor), 
				calificacion = isnull(@pCalificacion, calificacion),
				fecha = isnull(@pFecha, fecha),
				fechaDesbaneo = isnull(@pFechaDesbaneo, fechaDesbaneo)

			where IdCalificacionesProveedor = @pIdCalificacionesProveedor
		END
		else
			Raiserror('La Calificaciones ingresada debe de estar en un rango de 0 a 5', 0, 0)
	END
	else
		Raiserror('El IDCalificacionesProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCalificacionesProveedor(
	@pIdCalificacionesProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteCalificacionesProveedor(@pIdCalificacionesProveedor) = 1
	BEGIN
		select * from CalificacionesProveedor c
		where c.IdCalificacionesProveedor = @pIdCalificacionesProveedor
	END
	else
		Raiserror('El IDCalificacionesProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCalificacionesProveedor(
	@pIdCalificacionesProveedor int)
AS
BEGIN
	if [dbo].fn_ExisteCalificacionesProveedor(@pIdCalificacionesProveedor) = 1
	BEGIN
		delete from CalificacionesProveedor
		where IdCalificacionesProveedor = @pIdCalificacionesProveedor
	END
	else
		Raiserror('El IdCalificacionesProveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCalificacionesProveedor 4, 1
Execute sp_UpdateCalificacionesProveedor 3, 4
Execute sp_ReadCalificacionesProveedor 1
Execute sp_DeleteCalificacionesProveedor 3
