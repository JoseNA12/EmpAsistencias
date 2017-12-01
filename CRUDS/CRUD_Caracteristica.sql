SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateCaracteristica(
	--@pIdCaracteristica int,
	@pCaracteristica varchar(50) = null)
AS
BEGIN
	Insert into Caracteristica(caracteristica)
	values (@pCaracteristica)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateCaracteristica(
	@pIdCaracteristica int,
	@pCaracteristica varchar(50) = null)
AS
BEGIN
	if [dbo].fn_ExisteCaracteristica(@pIdCaracteristica) = 1
	BEGIN
		update Caracteristica
		set --IdCaracteristica = @pIdCaracteristica,
			caracteristica = isnull(@pCaracteristica, caracteristica)
	
		where @pIdCaracteristica = IdCaracteristica
	END
	else
		Raiserror('La Caracteristica ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadCaracteristica(
	@pIdCaracteristica int)
AS
BEGIN
	if [dbo].fn_ExisteCaracteristica(@pIdCaracteristica) = 1
	BEGIN
		select * from Caracteristica t
		where t.IdCaracteristica = @pIdCaracteristica
	END
	else
		Raiserror('La Caracteristica ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteCaracteristica(
	@pIdCaracteristica int)
AS
BEGIN
	if [dbo].fn_ExisteCaracteristica(@pIdCaracteristica) = 1
	BEGIN
		if [dbo].fn_ExisteCaracteristicaEnProveedores(@pIdCaracteristica) = 0
		BEGIN
			delete from Caracteristica
			where IdCaracteristica = @pIdCaracteristica
		END
		else
			Raiserror('La Caracteristica ingresada se encuentra asociada a uno o varios proveedores. Elimine la relación primero', 0, 0)
	END
	else
		Raiserror('La Caracteristica ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateCaracteristica 'Caracteristica_Libre'
Execute sp_UpdateCaracteristica 18, 'PRUEBAAaAaA'
Execute sp_ReadCaracteristica 19
Execute sp_DeleteCaracteristica 1