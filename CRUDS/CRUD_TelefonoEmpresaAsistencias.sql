SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateTelefonoEmpresaAsistencia(
	--@pIdTelefonoEmpresaAsistencia int,
	@pIdEmpresaAsistencia int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
	BEGIN
		Insert into TelefonoEmpresaAsistencia(IdEmpresaAsistencia, telefono)
		values (@pIdEmpresaAsistencia, @pTelefono)
	END
	else
		Raiserror('La EmpresaAsistencia ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateTelefonoEmpresaAsistencia(
	@pIdTelefonoEmpresaAsistencia int,
	@pIdEmpresaAsistencia int = null,
	@pTelefono int = null)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoEmpresaAsistencia(@pIdTelefonoEmpresaAsistencia) = 1
	BEGIN
		if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
		BEGIN
			update TelefonoEmpresaAsistencia
			set --IdTelefonoEmpresaAsistencia = @pIdTelefonoEmpresaAsistencia,
				IdEmpresaAsistencia = isnull(@pIdEmpresaAsistencia, IdEmpresaAsistencia),
				telefono = isnull(@pTelefono, telefono)
	
			where IdTelefonoEmpresaAsistencia = @pIdTelefonoEmpresaAsistencia
		END
		else
			Raiserror('La EmpresaAsistencia ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdTelefonoEmpresaAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadTelefonoEmpresaAsistencia(
	@pIdTelefonoEmpresaAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoEmpresaAsistencia(@pIdTelefonoEmpresaAsistencia) = 1
	BEGIN
		select * from TelefonoEmpresaAsistencia t
		where t.IdTelefonoEmpresaAsistencia = @pIdTelefonoEmpresaAsistencia
	END
	else
		Raiserror('La EmpresaAsistencia ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteTelefonoEmpresaAsistencia(
	@pIdTelefonoEmpresaAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteTelefonoEmpresaAsistencia(@pIdTelefonoEmpresaAsistencia) = 1
	BEGIN
		delete from TelefonoEmpresaAsistencia
		where IdTelefonoEmpresaAsistencia = @pIdTelefonoEmpresaAsistencia
	END
	else
		Raiserror('El IdTelefonoEmpresaAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateTelefonoEmpresaAsistencia 1, 123123123
Execute sp_UpdateTelefonoEmpresaAsistencia 4, 56234612
Execute sp_ReadTelefonoEmpresaAsistencia 1
Execute sp_DeleteTelefonoEmpresaAsistencia 5