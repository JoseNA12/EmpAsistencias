SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateLlamada(
	--@pIdLlamada int,
	--@pFecha date,
	--@pHora time,
	@pIdCallCenter int)
AS
BEGIN
	if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1 or @pIdCallCenter is null
	BEGIN
		insert into Llamada(fecha, hora, IdCallCenter)
		values((select cast(getdate() as date)), (select cast(getdate() as time)), @pIdCallCenter)
	END
	else
		Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateLlamada(
	@pIdLlamada int,
	@pFecha date = null,
	@pHora time = null,
	@pIdCallCenter int = null)
AS
BEGIN
	if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1
	BEGIN
		if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1 or @pIdCallCenter is null
		BEGIN
			update Llamada
			set --IdLlamada = @pIdLlamada,
				fecha = isnull(@pFecha, fecha),
				hora = isnull(@pHora, hora),
				IdCallCenter = isnull(@pIdCallCenter,IdCallCenter)

			where IdLlamada = @pIdLlamada
		END
		else
			Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadLlamada(
	@pIdLlamada int)
AS
BEGIN
	if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1
	BEGIN
		select * from Llamada l
		where l.IdLlamada = @pIdLlamada
	END
	else
		Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteLlamada(
	@pIdLlamada int)
AS
BEGIN
	if [dbo].fn_ExisteLlamada(@pIdLlamada) = 1
	BEGIN
		delete from Llamada
		where IdLlamada = @pIdLlamada
	END
	else
		Raiserror('La Llamada ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateLlamada 1
Execute sp_UpdateLlamada 7, 'PINGUIN'
Execute sp_ReadLlamada 4
Execute sp_DeleteLlamada 4

