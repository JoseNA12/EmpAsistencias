SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateOrganizacion(
	--@pIdOrganizacion int,
	@pIdEmpresaAsistencia int,
	@pNombre varchar(50) = null,
	@pUbicacion varchar(50) = null,
	@pCedulaJuridica int = null)
AS
BEGIN
	if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
	BEGIN
		Insert into Organizacion(nombre, ubicacion, cedulaJuridica, IdEmpresaAsistencia)
		values (@pNombre, @pUbicacion, @pCedulaJuridica, @pIdEmpresaAsistencia)
	END
	else
		Raiserror('El IdEmpresaAsistencia ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateOrganizacion(
	@pIdOrganizacion int,
	@pNombre varchar(50) = null,
	@pUbicacion varchar(50) = null,
	@pCedulaJuridica int = null,
	@pIdEmpresaAsistencia int)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1
	BEGIN
		if [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia) = 1 or @pIdEmpresaAsistencia is null
		BEGIN
			update Organizacion
			set --IdOrganizacion = @pIdOrganizacion, 
				nombre = isnull(@pNombre, nombre),
				ubicacion = isnull(@pUbicacion, ubicacion),
				cedulaJuridica = isnull(@pCedulaJuridica, cedulaJuridica),
				IdEmpresaAsistencia = isnull(@pIdEmpresaAsistencia, IdEmpresaAsistencia)

			where IdOrganizacion = @pIdOrganizacion
		END
		else
			Raiserror('El IdEmpresaAsistencia ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Organización ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadOrganizacion(
	@pIdOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1
	BEGIN
		select * from Organizacion o
		where o.IdOrganizacion = @pIdOrganizacion
	END
	else
		Raiserror('La Organización ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteOrganizacion(
	@pIdOrganizacion int)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1
	BEGIN
		delete from Organizacion
		where IdOrganizacion = @pIdOrganizacion
	END
	else
		Raiserror('La Organización ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateOrganizacion 'CAREPINGA', 'jajaja', 123123123
Execute sp_UpdateOrganizacion 15, 'PINGUIN', 'asasasas', 79086789, 3
Execute sp_ReadOrganizacion 15
Execute sp_DeleteOrganizacion 15
