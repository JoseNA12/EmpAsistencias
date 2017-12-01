SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------Create-----------------------------------------
CREATE PROCEDURE sp_CreateOrganizacionPaquete(
	--@pIdOrganizacionPaquete int, 
	@pIdOrganizacion int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
	BEGIN
		if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
		BEGIN
			Insert into OrganizacionPaquete(IdOrganizacion, IdPaquete)
			values(@pIdOrganizacion, @pIdPaquete)
		END
		else
			Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Update-----------------------------------------
CREATE PROCEDURE sp_UpdateOrganizacionPaquete(
	@pIdOrganizacionPaquete int, 
	@pIdOrganizacion int = null,
	@pIdPaquete int = null)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacionPaquete(@pIdOrganizacionPaquete) = 1
	BEGIN
		if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1 or @pIdOrganizacion is null
		BEGIN
			if [dbo].fn_ExistePaquete(@pIdPaquete) = 1 or @pIdPaquete is null
			BEGIN
				update OrganizacionPaquete
				set --IdOrganizacionPaquete = @pIdOrganizacionPaquete, 
					IdOrganizacion = isnull(@pIdOrganizacion, IdOrganizacion), 
					IdPaquete = isnull(@pIdPaquete, IdPaquete)
					
				where IdOrganizacionPaquete = @pIdOrganizacionPaquete
			END
			else
				Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El IdOrganizacionPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Read-----------------------------------------
CREATE PROCEDURE sp_ReadOrganizacionPaquete(
	@pIdOrganizacionPaquete int)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacionPaquete(@pIdOrganizacionPaquete) = 1
	BEGIN
		select * from OrganizacionPaquete a
		where a.IdOrganizacionPaquete = @pIdOrganizacionPaquete
	END
	else
		Raiserror('El IdOrganizacionAsistencio ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------Delete-----------------------------------------
CREATE PROCEDURE sp_DeleteOrganizacionPaquete(
	@pIdOrganizacionPaquete int)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacionPaquete(@pIdOrganizacionPaquete) = 1
	BEGIN
		delete from OrganizacionPaquete
		where IdOrganizacionPaquete = @pIdOrganizacionPaquete
	END
	else
		Raiserror('El IdOrganizacionPaquete ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-----------------------------------------EXECUTE's-----------------------------------------

Execute sp_CreateOrganizacionPaquete 12, 34, 4
Execute sp_UpdateOrganizacionPaquete 22, 7, 5
Execute sp_ReadOrganizacionPaquete 1
Execute sp_DeleteOrganizacionPaquete 22