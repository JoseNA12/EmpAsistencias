SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
ALTER PROCEDURE sp_CreateEmpleado(
	--@pIdEmpleado int, 
	@pNombre varchar(50) = null,
	@pProcedencia varchar(50) = null,
	@pSalario money = null,
	@pIdCallCenter int = null,
	@pIdIdioma int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1 or @pIdCallCenter is null
	BEGIN
		if [dbo].fn_ExisteIdioma(@pIdIdioma) = 1 or @pIdIdioma is null
		BEGIN
			Insert into Empleado(nombre, procedencia, salario, IdCallCenter)
			values (@pNombre, @pProcedencia, @pSalario, @pIdCallCenter)

			declare @EmpleadoCreado int
			set @EmpleadoCreado = (select top 1 e.IdEmpleado from Empleado e order by e.IdEmpleado desc)

			Execute sp_CreateIdiomaEmpleado @EmpleadoCreado, @pIdIdioma
			Execute sp_CreateTelefonoEmpleado @EmpleadoCreado, @pTelefono
		END
		else
			Raiserror ('El Idioma ingresado no se encuentra en la base datos', 0, 0)
	END
	else
		Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateEmpleado(
	@pIdEmpleado int, 
	@pNombre varchar(50) = null,
	@pProcedencia varchar(50) = null,
	@pSalario money = null,
	@pIdCallCenter int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1
	BEGIN
		if [dbo].fn_ExisteCallCenter(@pIdCallCenter) = 1 or @pIdCallCenter is null
		BEGIN
			update Empleado
			set --IdEmpleado = @pIdEmpleado, 
				nombre = isnull(@pNombre, nombre),
				procedencia = isnull(@pProcedencia, procedencia),
				salario = isnull(@pSalario, salario),
				IdCallCenter = isnull(@pIdCallCenter, IdCallCenter)

			where IdEmpleado = @pIdEmpleado
		END
		else
			Raiserror('El Call Center ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadEmpleado(
	@pIdEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1
	BEGIN
		select * from Empleado e
		where e.IdEmpleado = @pIdEmpleado
	END
	else
		Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteEmpleado(
	@pIdEmpleado int)
AS
BEGIN
	if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1
	BEGIN
		delete from Empleado
		where IdEmpleado = @pIdEmpleado
	END
	else
		Raiserror('El Empleado ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateEmpleado 'PRUEBA', 'CARTUCHO', 90000, 1
Execute sp_UpdateEmpleado 13, 'PRUEBA2', 'SAN JOSE', 80000, 1
Execute sp_ReadEmpleado 10
Execute sp_DeleteEmpleado 13
