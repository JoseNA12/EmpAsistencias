SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------------------------------------------------------------------
--								Verificar existencia de las tablas
-----------------------------------------------------------------------------------------------

CREATE FUNCTION [dbo].fn_ExisteAsistencia(@pIdAsistencia int)
returns bit
AS
BEGIN
	if exists (Select c.IdAsistencia from Asistencia c where c.IdAsistencia = @pIdAsistencia)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCalificacionesCliente(@pIdCalificacionesCliente int)
returns bit
AS
BEGIN
	if exists (Select c.IdCalificacionesCliente from CalificacionesCliente c where c.IdCalificacionesCliente = @pIdCalificacionesCliente)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCalificacionesProveedor(@pIdCalificacionesProveedor int)
returns bit
AS
BEGIN
	if exists (Select c.IdCalificacionesProveedor from CalificacionesProveedor c where c.IdCalificacionesProveedor = @pIdCalificacionesProveedor)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCallCenter(@pIdCallCenter int)
returns bit
AS
BEGIN
	if exists (Select c.IdCallCenter from CallCenter c where c.IdCallCenter = @pIdCallCenter)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCaracteristica(@pIdCaracteristica int)
returns bit
AS
BEGIN
	if exists (Select c.IdCaracteristica from Caracteristica c where c.IdCaracteristica = @pIdCaracteristica)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCaracteristicaEnProveedores(@pIdCaracteristica int)
returns bit
AS
BEGIN
	if exists (Select cp.IdCaracteristica from CaracteristicasProveedor cp where cp.IdCaracteristica = @pIdCaracteristica)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCaracteristicasProveedor(@pIdCaracteristicasProveedor int)
returns bit
AS
BEGIN
	if exists (Select c.IdCaracteristicasProveedor from CaracteristicasProveedor c where c.IdCaracteristicasProveedor = @pIdCaracteristicasProveedor)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCliente(@pIdCliente int)
returns bit
AS
BEGIN
	if exists (Select c.IdCliente from Cliente c where c.IdCliente = @pIdCliente)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteClienteAsistencia(@pIdClienteAsistencia int)
returns bit
AS
BEGIN
	if exists (Select c.IdClienteAsistencia from ClienteAsistencia c where c.IdClienteAsistencia = @pIdClienteAsistencia)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteClienteOrganizacion(@pIdClienteOrganizacion int)
returns bit
AS
BEGIN
	if exists (Select c.IdClienteOrganizacion from ClienteOrganizacion c where c.IdClienteOrganizacion = @pIdClienteOrganizacion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCondicion(@pIdCondicion int)
returns bit
AS
BEGIN
	if exists (Select c.IdCondicion from Condicion c where c.IdCondicion = @pIdCondicion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCondicionEnProveedores(@pIdCondicion int)
returns bit
AS
BEGIN
	if exists (Select cp.IdCondicion from CondicionesProveedor cp where cp.IdCondicion = @pIdCondicion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteCondicionesProveedor(@pIdCondicionesProveedor int)
returns bit
AS
BEGIN
	if exists (Select c.IdCondicionesProveedor from CondicionesProveedor c where c.IdCondicionesProveedor = @pIdCondicionesProveedor)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteEmpleado(@pIdEmpleado int)
returns bit
AS
BEGIN
	if exists (Select c.IdEmpleado from Empleado c where c.IdEmpleado = @pIdEmpleado)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteEmpresaAsistencia(@pIdEmpresaAsistencia int)
returns bit
AS
BEGIN
	if exists (Select ea.IdEmpresaAsistencia from EmpresaAsistencia ea where ea.IdEmpresaAsistencia = @pIdEmpresaAsistencia)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteIdioma(@pIdIdioma int)
returns bit
AS
BEGIN
	if exists (Select c.IdIdioma from Idioma c where c.IdIdioma = @pIdIdioma)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteIdiomaEnEmpleado(@pIdIdioma int)
returns bit
AS
BEGIN
	if exists (Select ie.IdIdioma from IdiomaEmpleado ie where ie.IdIdioma = @pIdIdioma)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteIdiomaEmpleado(@pIdIdiomaEmpleado int)
returns bit
AS
BEGIN
	if exists (Select id.IdIdiomaEmpleado from IdiomaEmpleado id where id.IdIdiomaEmpleado = @pIdIdiomaEmpleado)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteIdiomaEnCliente(@pIdIdioma int)
returns bit
AS
BEGIN
	if exists (Select ie.IdIdioma from IdiomaCliente ie where ie.IdIdioma = @pIdIdioma)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteIdiomaCliente(@pIdIdiomaCliente int)
returns bit
AS
BEGIN
	if exists (Select id.IdIdiomaCliente from IdiomaCliente id where id.IdIdiomaCliente = @pIdIdiomaCliente)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteLlamada(@pIdLlamada int)
returns bit
AS
BEGIN
	if exists (Select c.IdLlamada from Llamada c where c.IdLlamada = @pIdLlamada)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteLlamadaCliente(@pIdLlamadaCliente int)
returns bit
AS
BEGIN
	if exists (Select lc.IdLlamadaCliente from LlamadaCliente lc where lc.IdLlamadaCliente = @pIdLlamadaCliente)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteLlamadaEmpleado(@pIdLlamadaEmpleado int)
returns bit
AS
BEGIN
	if exists (Select lc.IdLlamadaEmpleado from LlamadaEmpleado lc where lc.IdLlamadaEmpleado = @pIdLlamadaEmpleado)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteLlamadaOrganizacion(@pIdLlamadaOrganizacion int)
returns bit
AS
BEGIN
	if exists (Select lc.IdLlamadaOrganizacion from LlamadaOrganizacion lc where lc.IdLlamadaOrganizacion = @pIdLlamadaOrganizacion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteLlamadaSolicitud(@pIdLlamadaSolicitud int)
returns bit
AS
BEGIN
	if exists (Select lc.IdLlamadaSolicitud from LlamadaSolicitud lc where lc.IdLlamadaSolicitud = @pIdLlamadaSolicitud)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteOrganizacion(@pIdOrganizacion int)
returns bit
AS
BEGIN
	if exists (Select c.IdOrganizacion from Organizacion c where c.IdOrganizacion = @pIdOrganizacion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteOrganizacionAsistencia(@pIdOrganizacionAsistencia int)
returns bit
AS
BEGIN
	if exists (Select c.IdOrganizacionAsistencia from OrganizacionAsistencia c where c.IdOrganizacionAsistencia = @pIdOrganizacionAsistencia)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExistePago(@pIdPago int)
returns bit
AS
BEGIN
	if exists (Select c.IdPago from Pago c where c.IdPago = @pIdPago)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExistePagoCliente(@pIdPagoCliente int)
returns bit
AS
BEGIN
	if exists (Select pc.IdPagoCliente from PagoCliente pc where pc.IdPagoCliente = @pIdPagoCliente)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExistePagoOrganizacion(@pIdPagoOrganizacion int)
returns bit
AS
BEGIN
	if exists (Select pc.IdPagoOrganizacion from PagoOrganizacion pc where pc.IdPagoOrganizacion = @pIdPagoOrganizacion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExistePagoPaquete(@pIdPagoPaquete int)
returns bit
AS
BEGIN
	if exists (Select pc.IdPagoPaquete from PagoPaquete pc where pc.IdPagoPaquete = @pIdPagoPaquete)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExistePagoServicio(@pIdPagoServicio int)
returns bit
AS
BEGIN
	if exists (Select pc.IdPagoServicio from PagoServicio pc where pc.IdPagoServicio = @pIdPagoServicio)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExistePaquete(@pIdPaquete int)
returns bit
AS
BEGIN
	if exists (Select c.IdPaquete from Paquete c where c.IdPaquete = @pIdPaquete)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExistePaqueteServicio(@pIdPaqueteServicio int)
returns bit
AS
BEGIN
	if exists (Select ps.IdPaqueteServicio from PaqueteServicio ps where ps.IdPaqueteServicio = @pIdPaqueteServicio)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteProveedor(@pIdProveedor int)
returns bit
AS
BEGIN
	if exists (Select c.IdProveedor from Proveedor c where c.IdProveedor = @pIdProveedor)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteProveedorServicio(@pIdProveedorServicio int)
returns bit
AS
BEGIN
	if exists (Select c.IdProveedorServicio from ProveedorServicio c where c.IdProveedorServicio = @pIdProveedorServicio)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteServicio(@pIdServicio int)
returns bit
AS
BEGIN
	if exists (Select c.IdServicio from Servicio c where c.IdServicio = @pIdServicio)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteSolicitud(@pIdSolicitud int)
returns bit
AS
BEGIN
	if exists (Select c.IdSolicitud from Solicitud c where c.IdSolicitud = @pIdSolicitud)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteSolicitudServicio(@pIdSolicitudServicio int)
returns bit
AS
BEGIN
	if exists (Select ss.IdSolicitudServicio from SolicitudServicio ss where ss.IdSolicitudServicio = @pIdSolicitudServicio)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteTelefonoCallCenter(@pIdTelefonoCallCenter int)
returns bit
AS
BEGIN
	if exists (Select c.IdTelefonoCallCenter from TelefonoCallCenter c where c.IdTelefonoCallCenter = @pIdTelefonoCallCenter)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteTelefonoCliente(@pIdTelefonoCliente int)
returns bit
AS
BEGIN
	if exists (Select c.IdTelefonoCliente from TelefonoCliente c where c.IdTelefonoCliente = @pIdTelefonoCliente)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteTelefonoEmpleado(@pIdTelefonoEmpleado int)
returns bit
AS
BEGIN
	if exists (Select c.IdTelefonoEmpleado from TelefonoEmpleado c where c.IdTelefonoEmpleado = @pIdTelefonoEmpleado)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteTelefonoEmpresaAsistencia(@pIdTelefonoEmpresaAsistencia int)
returns bit
AS
BEGIN
	if exists (Select c.IdTelefonoEmpresaAsistencia from TelefonoEmpresaAsistencia c where c.IdTelefonoEmpresaAsistencia = @pIdTelefonoEmpresaAsistencia)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteTelefonoOrganizacion(@pIdTelefonoOrganizacion int)
returns bit
AS
BEGIN
	if exists (Select c.IdTelefonoOrganizacion from TelefonoOrganizacion c where c.IdTelefonoOrganizacion = @pIdTelefonoOrganizacion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteTelefonoProveedor(@pIdTelefonoProveedor int)
returns bit
AS
BEGIN
	if exists (Select c.IdTelefonoProveedor from TelefonoProveedor c where c.IdTelefonoProveedor = @pIdTelefonoProveedor)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteTipoPago(@pIdTipoPago int)
returns bit
AS
BEGIN
	if exists (Select c.IdTipoPago from TipoPago c where c.IdTipoPago = @pIdTipoPago)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteClientePaquete(@pIdClientePaquete int)
returns bit
AS
BEGIN
	if exists (Select cp.IdClientePaquete from ClientePaquete cp where cp.IdClientePaquete = @pIdClientePaquete)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteDisponibilidadProveedor(@pIdDisponibilidadProveedor int)
returns bit
AS
BEGIN
	if exists (Select dp.IdDisponibilidadProveedor from DisponibilidadProveedor dp where dp.IdDisponibilidadProveedor = @pIdDisponibilidadProveedor)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteServicioAsistencia(@pIdServicioAsistencia int)
returns bit
AS
BEGIN
	if exists (Select cp.IdServicioAsistencia from ServicioAsistencia cp where cp.IdServicioAsistencia = @pIdServicioAsistencia)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteProveedorSolicitud(@pIdProveedorSolicitud int)
returns bit
AS
BEGIN
	if exists (Select ps.IdProveedorSolicitud from ProveedorSolicitud ps where ps.IdProveedorSolicitud = @pIdProveedorSolicitud)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteOrganizacionPaquete(@pIdOrganizacionPaquete int)
returns bit
AS
BEGIN
	if exists (Select ps.IdOrganizacionPaquete from OrganizacionPaquete ps where ps.IdOrganizacionPaquete = @pIdOrganizacionPaquete)
		return 1
	return 0
END
GO

CREATE FUNCTION fn_ExisteSolicitudPaquete(@pSolicitudPaquete int)
returns int
AS
BEGIN
	if exists (Select ps.IdSolicitudPaquete from SolicitudPaquete ps where ps.IdSolicitudPaquete = @pSolicitudPaquete)
		return 1
	return 0
END
GO


-----------------------------------------------------------------------------------------------
--								Funciones de la Funcionalidad
-----------------------------------------------------------------------------------------------

CREATE FUNCTION [dbo].fn_VerificarClienteBaneado(@pIdCliente int)
returns bit
AS
BEGIN
	if ((Select c.estado from Cliente c where c.IdCliente = @pIdCliente) = 'INACTIVO')
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ExisteClienteEnOrganizacion(@pIdCliente int, @pIdOrganizacion int)
returns bit
AS
BEGIN
	if exists (Select co.IdOrganizacion from ClienteOrganizacion co where co.IdCliente = @pIdCliente and co.IdOrganizacion = @pIdOrganizacion)
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_ProveedoresParaElPaquete(@pIdPaquete int)
returns money
AS
BEGIN
    declare @Servicio int
    declare @ProveedoresPaquete table(Precio money)

    declare ServiciosPaquete cursor for --Escogo todos los servicios del paquete
        Select ps.IdServicio From PaqueteServicio ps
        where ps.IdPaquete = @pIdPaquete

    open ServiciosPaquete 
    fetch next from ServiciosPaquete into @Servicio

    while @@FETCH_STATUS = 0
    BEGIN
        declare @Proveedor int
        declare @Precio money

        Select top 1 @Precio = p.Precio From Proveedor p --Obtener un proveedor para cada servicio
            inner join ProveedorServicio ps on ps.IdProveedor = p.IdProveedor
            where ps.IdServicio = @Servicio
            order by p.Precio asc --Mas barato

        insert into @ProveedoresPaquete(Precio)
        values(@Precio)

        fetch next from ServiciosPaquete into @Servicio
    END
    close ServiciosPaquete
    Deallocate ServiciosPaquete

    declare @MontoRetorno money
    Set @MontoRetorno = (Select sum(Precio) from @ProveedoresPaquete) / 30 --Obtener la sumatoria de todos los precios

    return @MontoRetorno
END
GO

CREATE FUNCTION [dbo].fn_ValidaCalificarCliente(@pIdCliente int, @pIdProveedor int)
returns bit
AS
BEGIN
    if (Select p.IdProveedor From Proveedor p
        inner join ProveedorServicio ps on ps.IdProveedor = p.IdProveedor
        inner join PagoServicio Pags on Pags.IdServicio = ps.IdServicio
        inner join PagoCliente pc on pc.IdPago = Pags.IdPago
        inner join Pago Pa on Pa.IdPago = pc.IdPago
        where pc.IdCliente = @pIdCliente
        and Pa.Estado = 'CANCELADO' --Puede calificar cuando el cliente haya pagado
        and p.IdProveedor = @pIdProveedor) = @pIdProveedor
        return 1
    return 0
END
GO

CREATE FUNCTION [dbo].fn_VerificarEstadoServicio(@pIdServicio int)
returns bit
AS
BEGIN
	if (select s.estado from Servicio s where s.IdServicio = @pIdServicio) = 'DISPONIBLE'
		return 1
	return 0
END
GO

CREATE FUNCTION [dbo].fn_BuscarServicio(@pIdAsistencia int)
returns int
AS
BEGIN
	declare @Servicio int
	set @Servicio = -1 -- si no existe
	select @Servicio = a.IdServicio from Asistencia a
	where a.IdAsistencia = @pIdAsistencia

	return @Servicio
END
GO

CREATE FUNCTION [dbo].fn_RetornaEmpleadoPorIdioma(@pIdCliente int)
returns @EmpleadoIdiomas table(IdEmpleado int)
AS
BEGIN	
	declare @IdiomaCliente int

	select top 1 @IdiomaCliente = ic.IdIdioma from IdiomaCliente ic
	where IdCliente = @pIdCliente

	declare @Idioma int
	declare @Empleado int

	declare DatosEmpIdioma cursor for		
		Select e.IdEmpleado from Empleado e
		inner join IdiomaEmpleado ie on ie.IdEmpleado = e.IdEmpleado
		where ie.IdIdioma = @IdiomaCliente
	
	open DatosEmpIdioma
	fetch next from DatosEmpIdioma into @Empleado

	while @@FETCH_STATUS = 0
	BEGIN
		insert into @EmpleadoIdiomas(IdEmpleado)
		values (@Empleado)		
		fetch next from DatosEmpIdioma into @Empleado
	END

	close DatosEmpIdioma
	deallocate DatosEmpIdioma
	return
END
GO

CREATE FUNCTION [dbo].fn_SeleccionarProveedor(@pIdServicio int, @pHoraRequerida time)
returns int
AS
BEGIN
	declare @ProveedorApto int
	declare @Disponibilidad time
	declare @Calificacion tinyint

	declare @ProveedoresDisponibles table(IdProveedorDisponible int, Precio money)

	declare @Servicio int
	declare @Precio money

	/*select @Servicio = s.IdServicio from Servicio s
    inner join SolicitudServicio ss on ss.IdSolicitud=@pIdSolicitud
    --where s.IdServicio=ss.IdServicio*/

	declare Proveedores cursor for
		select ps.IdProveedor, dp.disponibilidad, cp.calificacion, p.Precio from ProveedorServicio ps
		inner join Proveedor p on ps.IdProveedor = p.IdProveedor
		inner join DisponibilidadProveedor dp on dp.IdProveedor = ps.IdProveedor
		inner join CalificacionesProveedor cp on ps.IdProveedor = cp.IdProveedor
		where ps.IdServicio = @pIdServicio and p.estado = 'ACTIVO'

	open Proveedores
	fetch next from Proveedores into @ProveedorApto, @Disponibilidad, @Calificacion, @Precio

	while @@FETCH_STATUS = 0
	BEGIN
		if @pHoraRequerida = @Disponibilidad
		BEGIN
			if @Calificacion > 3
			BEGIN
				insert into @ProveedoresDisponibles(IdProveedorDisponible, Precio)
				values(@ProveedorApto, @Precio)
			END
		END
		fetch next from Proveedores into @ProveedorApto, @Disponibilidad, @Calificacion, @Precio
	END

	close Proveedores
	deallocate Proveedores

	declare @ProveedorEscogido int

	select @ProveedorEscogido= vpd.IdProveedorDisponible from @ProveedoresDisponibles vpd
	where vpd.Precio=(Select min(vpd2.Precio) from @ProveedoresDisponibles vpd2)

	return @ProveedorEscogido

END
GO

ALTER FUNCTION [dbo].fn_RetornarSolicitudServicio(@pIdCliente int, @pIdServicio int)
returns int
AS
BEGIN
	declare @SolicitudServicio int = -1
    set @SolicitudServicio= isnull((Select top 1 ss.IdSolicitudServicio
                                From SolicitudServicio ss
                                inner join LlamadaCliente cl on cl.IdCliente = @pIdCliente
                                inner join LlamadaSolicitud ls on ls.IdSolicitud = ss.IdSolicitud
                                inner join PagoCliente pc on pc.IdCliente = @pIdCliente
                                inner join Pago p on p.IdPago = pc.IdPago
                                where ss.IdServicio = @pIdServicio
                                and ls.IdSolicitud = ss.IdSolicitud
                                and ls.IdLlamada = cl.IdLlamada
                                --and p.Estado != 'CANCELADO'
								and ss.estado = 'EN PROCESO'
                                ), @SolicitudServicio)
    return @SolicitudServicio
END
GO

CREATE FUNCTION [dbo].fn_RetornaPrecioServicio(@pIdSolicitudServicio int)
returns money
AS
BEGIN
    declare @Solicitud int
    set @Solicitud = (Select ss.IdSolicitud from SolicitudServicio ss where ss.IdSolicitudServicio = @pIdSolicitudServicio)

    declare @Precio money = -1
    set @Precio = (Select p.Precio from Proveedor p
                    inner join ProveedorSolicitud ps on ps.IdSolicitud = @Solicitud
                    inner join SolicitudServicio ss on ss.IdSolicitudServicio = @pIdSolicitudServicio
                    where ps.IdProveedor = p.IdProveedor
                    and ss.IdSolicitud = ps.IdSolicitud)
    return @Precio
END
GO

CREATE FUNCTION fn_VerificaBaneadoProveedor(@pIdProveedor int)
returns bit
AS
BEGIN
    if (Select p.Estado from Proveedor p where p.IdProveedor = @pIdProveedor) = 'INACTIVO'
        return 1
    return 0
END
GO

CREATE FUNCTION fn_VerificaClientePaquete(@pIdCliente int, @pIdPaquete int)
returns bit
AS
BEGIN
	if (select count(cp.IdClientePaquete) from ClientePaquete cp where cp.IdCliente = @pIdCliente and cp.IdPaquete = @pIdPaquete) >= 1
		return 1
	return 0
END
GO

CREATE FUNCTION fn_VerificaClienteEnOrganizacionEnEmpresaAsistencia(@pIdCliente int)
returns bit
AS
BEGIN
	declare @Organizacion int
	declare @Bandera int

	declare OrganizacionesCliente cursor for
		select o.IdOrganizacion from Organizacion o
		inner join ClienteOrganizacion co on co.IdOrganizacion = o.IdOrganizacion
		where co.IdCliente = @pIdCliente

	open OrganizacionesCliente

	fetch next from OrganizacionesCliente into @Organizacion

	while @@FETCH_STATUS = 0
	BEGIN
		if (select o.IdEmpresaAsistencia from Organizacion o where o.IdOrganizacion = @Organizacion) = 1 -- Id de la EmpresaAsistencia
		BEGIN
			set @Bandera = 1
			break
		END
		fetch next from OrganizacionesCliente into @Organizacion
	END

	close OrganizacionesCliente
	deallocate OrganizacionesCliente

	if @Bandera = 1
	BEGIN
		return 1
	END
	return 0
END
GO

CREATE FUNCTION fn_VerificaClienteEnPaqueteServicio(@pIdCliente int, @pIdServicio int)
returns bit
AS
BEGIN
	if exists(select p.IdPaquete from ClientePaquete cp
				inner join PaqueteServicio ps on cp.IdPaquete = ps.IdPaquete
				inner join Paquete p on p.IdPaquete = ps.IdPaquete
				where cp.IdCliente = @pIdCliente and ps.IdServicio = @pIdServicio)
		return 1
	return 0
END
GO


CREATE FUNCTION fn_VerificaPagoClienteRealizado(@pIdCliente int, @pIdServicio int)
returns bit
AS
BEGIN
	if (select p.estado from Pago p
		inner join PagoCliente pc on pc.IdPago = p.IdPago
		inner join PagoServicio ps on ps.IdPago = pc.IdPago
		where pc.IdCliente = @pIdCliente and ps.IdServicio = @pIdServicio and ps.IdPago != NULL) = 'CANCELADO'
		return 1
	return 0
END
GO

CREATE FUNCTION VerificaEstadoDelServicio(@pIdServicio int)
returns bit
AS
BEGIN
    if (Select s.Estado from Servicio s where s.IdServicio = @pIdServicio) = 'DISPONIBLE'
        return 1
    return 0
END
GO

--------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION [dbo].fn_Split (@separador char(1), @IdsAsistencias varchar(100))
returns table
AS
RETURN (
	WITH Pieces(Id, start, stop) AS (
		select 1, 1, CHARINDEX(@separador, @IdsAsistencias)
		union ALL
		select Id + 1, stop + 1, CHARINDEX(@separador, @IdsAsistencias, stop + 1)
		from Pieces
		WHERE stop > 0)

	select Id,
	SUBSTRING(@IdsAsistencias, start, CASE WHEN stop > 0 THEN stop-start ELSE 100 END) AS IdAsistencia
	from Pieces)
GO

