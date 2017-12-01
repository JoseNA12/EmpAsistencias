SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreatePaquete(
	--@pIdPaquete int,
	@pIdEmpresaAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
	BEGIN
		Insert into Paquete(IdEmpresaAsistencia)
		values (@pIdEmpresaAsistencia)
	END
	else
		Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdatePaquete(
	@pIdPaquete int,
	@pIdEmpresaAsistencia int = null)
AS
BEGIN
	if [dbo].fn_ExistePaquete(@pIdPaquete) = 1
	BEGIN
		if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
		BEGIN
			update Paquete
			set --IdPaquete = @pIdPaquete, 
				IdEmpresaAsistencia = isnull(@pIdEmpresaAsistencia, IdEmpresaAsistencia)

			where IdPaquete = @pIdPaquete
		END
		else
			Raiserror('La Empresa de Asistencias ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadPaquete(
	@pIdPaquete int)
AS
BEGIN
	if [dbo].fn_ExistePaquete(@pIdPaquete) = 1
	BEGIN
		select * from Paquete p
		where p.IdPaquete = @pIdPaquete
	END
	else
		Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeletePaquete(
	@pIdPaquete int)
AS
BEGIN
	if [dbo].fn_ExistePaquete(@pIdPaquete) = 1
	BEGIN
		delete from Paquete
		where IdPaquete = @pIdPaquete
	END
	else
		Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreatePaquete 1
Execute sp_UpdatePaquete 1, 1
Execute sp_ReadPaquete 1
Execute sp_DeletePaquete 1