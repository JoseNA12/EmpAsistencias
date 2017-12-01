
-------------------------------------------------------------------------------------------------------
--									Crear Solicitud (Crear Paquete)
							  --Execute sp_SolicitarAsistencias 3, 3, '4,3,1,2'
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_SolicitarAsistencias(
	@pIdCliente int,
	@pIdOrganizacion int,
	@pIdsAsistencias varchar(100))
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		if [dbo].fn_VerificarClienteBaneado(@pIdCliente) = 0
		BEGIN
			if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1
			BEGIN
				if [dbo].fn_ExisteClienteEnOrganizacion(@pIdCliente, @pIdOrganizacion) = 1
				BEGIN
					declare @IdAsistencia int
					declare @existeAsistencia bit -- bandera
					set @existeAsistencia = 1

					declare DatosIds cursor for
						select i.IdAsistencia from [dbo].fn_Split(',', @pIdsAsistencias) i
			
					open DatosIds
					fetch next from DatosIds into @IdAsistencia

					while @@FETCH_STATUS = 0
					BEGIN
						if [dbo].fn_ExisteAsistencia(@IdAsistencia) = 0
						BEGIN
							print 'La Asistencia ' + CONVERT(varchar(50), @IdAsistencia) + ' no se encuentra en la base de datos'
							set @existeAsistencia = 0
						END
						else
						BEGIN
							declare @Servicio2 int
							set @Servicio2 = [dbo].fn_BuscarServicio(@IdAsistencia)

							if [dbo].fn_VerificarEstadoServicio(@Servicio2) != 1
							BEGIN
								declare @nombreServicio varchar(50)
								set @nombreServicio = (select a.tipo from Asistencia a where a.IdAsistencia = @IdAsistencia)
								print 'El Servicio ' + CONVERT(varchar(10), @Servicio2) + ': ' + @nombreServicio + ' no esta disponible por el momento'
								set @existeAsistencia = 0
							END
						END
				
						fetch next from DatosIds into @IdAsistencia
					END

					close DatosIds
					deallocate DatosIds
					-------- Todos los Id de las asistencias estan en la BD --------

					if @existeAsistencia = 0
					BEGIN
						Raiserror('Error al crear el paquete. Hay una Asistencia inexistente en la base de datos o un Servicio no esta disponible ', 0, 0)
						return
					END
					else
					BEGIN
						Execute sp_CreatePaquete 1

						declare @MiPaquete int -- Obtener el id del paquete creado e ir metiendo las asistencias
						select top 1 @MiPaquete = p.IdPaquete from Paquete p
						order by p.IdPaquete desc

						Execute sp_CreateClientePaquete @pIdCliente, @MiPaquete
						Execute sp_CreateOrganizacionPaquete @pIdOrganizacion, @MiPaquete

						Execute sp_CreateSolicitud
						declare @MiSolicitud int
						set @MiSolicitud = (select top 1 s.IdSolicitud from Solicitud s order by s.IdSolicitud desc)

						Execute sp_CreateSolicitudPaquete @MiSolicitud, @MiPaquete

						declare DatosIds_2 cursor for
							select i.IdAsistencia from [dbo].fn_Split(',', @pIdsAsistencias) i
			
						open DatosIds_2
						fetch next from DatosIds_2 into @IdAsistencia


						while @@FETCH_STATUS = 0
						BEGIN
							declare @MiServicio int
							set @MiServicio = [dbo].fn_BuscarServicio(@IdAsistencia)

							Execute sp_CreatePaqueteServicio @MiPaquete, @MiServicio
							Execute sp_CreateClienteAsistencia @pIdCliente, @IdAsistencia			

							fetch next from DatosIds_2 into @IdAsistencia
						END
						close DatosIds_2
						deallocate DatosIds_2

						print 'La Solicitud de las Asistencias se completado con exito, su paquete esta listo!'
					END
				END
				else
					Raiserror('El Cliente indicado no tiene relacion con la Organizacion indica', 0, 0)
			END
			else
				Raiserror('La Organizacion indicada no existe en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado se encuentra baneado del sistema', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-------------------------------------------------------------------------------------------------------
--								    Crear Solicitud (Escoger Paquete)
								 --Execute sp_SolicitarPaquete 8, 6, 4
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_SolicitarPaquete(
	@pIdCliente int,
	@pIdOrganizacion int,
	@pIdPaquete int)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		if [dbo].fn_VerificarClienteBaneado(@pIdCliente) = 0
		BEGIN
			if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1
			BEGIN
				if [dbo].fn_ExisteClienteEnOrganizacion(@pIdCliente, @pIdOrganizacion) = 1
				BEGIN
					if [dbo].fn_ExistePaquete(@pIdPaquete) = 1
					BEGIN
						if [dbo].fn_VerificaClientePaquete(@pIdCliente, @pIdPaquete) = 0
						BEGIN
							Execute sp_CreateSolicitud

							declare @MiSolicitud int
							set @MiSolicitud = (select top 1 s.IdSolicitud from Solicitud s order by s.IdSolicitud desc)

							Execute sp_CreateClientePaquete @pIdCliente, @pIdPaquete
							Execute sp_CreateOrganizacionPaquete @pIdOrganizacion, @pIdPaquete
							Execute sp_CreateSolicitudPaquete @MiSolicitud, @pIdPaquete

							declare @Asistencia int

							declare ClienteAsistencias cursor for --Obtener las asistencias del paquete
								select a.IdServicio from PaqueteServicio ps
								inner join Asistencia a on a.IdServicio = ps.IdServicio
								where ps.IdPaquete = @pIdPaquete

							open ClienteAsistencias

							fetch next from ClienteAsistencias into @Asistencia

							while @@FETCH_STATUS = 0
							BEGIN
								Execute sp_CreateClienteAsistencia @pIdCliente, @Asistencia

								fetch next from ClienteAsistencias into @Asistencia
							END

							close ClienteAsistencias
							deallocate ClienteAsistencias
						

							print 'La Solicitud del Paquete se ha realizado con exito'
						END
						else
							Raiserror('El Cliente ingresado ya posee el paquete', 0, 0)
					END
					else
						Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
				END
				else
					Raiserror('El Cliente indicado no tiene relacion con la Organizacion indicada', 0, 0)
			END
			else
				Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado se encuentra baneado del sistema', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO


-------------------------------------------------------------------------------------------------------
--										  Realizar Llamada
--					IdCliente, IdServicio, Calificacion, HoraRequerida (hh:mm:ss)
							--Execute sp_RealizarLlamada 8, 2, 5, '4:45:00'
			--Proveedor, no tiene buenas calificaciones, esta inactivo o no esta en el horario del mae
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_RealizarLlamada(
	@pIdCliente int,
	@pIdServicio int,
	@pCalificacion tinyint,
	@HoraRequerida time)
AS
BEGIN
	if @pCalificacion between 0 and 5
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1
		BEGIN
			if [dbo].fn_ExisteServicio(@pIdServicio) = 1
			BEGIN
				Execute sp_CreateLlamada 1

				declare @LlamadaCreada int
				Select top 1 @LlamadaCreada = L.IdLlamada from Llamada L
				order by L.IdLlamada desc
			
				Execute sp_CreateLlamadaCliente @LlamadaCreada, @pIdCliente

				declare @EmpleadoQueAtiende int =- 1
				set @EmpleadoQueAtiende = isnull((Select top 1 * from [dbo].fn_RetornaEmpleadoPorIdioma(@pIdCliente) order by newid()),@EmpleadoQueAtiende)
			
				if (@EmpleadoQueAtiende != -1)
				BEGIN
					Execute sp_CreateLlamadaEmpleado @LlamadaCreada, @EmpleadoQueAtiende

					if [dbo].fn_VerificarClienteBaneado(@pIdCliente) = 0
					BEGIN

						if [dbo].fn_VerificaClienteEnOrganizacionEnEmpresaAsistencia(@pIdCliente) = 1
						BEGIN
							if [dbo].VerificaEstadoDelServicio(@pIdServicio) = 1
							BEGIN
								Execute sp_CreateSolicitud

								declare @SolicitudCreada int
								select top 1 @SolicitudCreada = S.IdSolicitud from Solicitud S
								order by S.IdSolicitud desc

								declare @ProveedorSeleccionado int = -1
								set @ProveedorSeleccionado = isnull([dbo].fn_SeleccionarProveedor(@pIdServicio, @HoraRequerida), @ProveedorSeleccionado)

								if (@ProveedorSeleccionado != -1)
								BEGIN
									Execute sp_CreateLlamadaSolicitud @LlamadaCreada, @SolicitudCreada
									Execute sp_CreateProveedorSolicitud @ProveedorSeleccionado, @SolicitudCreada
									Execute sp_CreateSolicitudServicio @SolicitudCreada, @pIdservicio, 'EN PROCESO', @pCalificacion

									declare @Asistencia int
									Set @Asistencia = (select a.IdAsistencia from Asistencia a where a.IdServicio = @pIdServicio)

									Execute sp_CreateClienteAsistencia @pIdCliente, @Asistencia

									declare @precio int
									set @precio = (select p.precio from Proveedor p where p.IdProveedor = @ProveedorSeleccionado)-- [dbo].fn_RetornaPrecioServicio(@SolicitudCreada)
									Execute sp_CreatePago @precio, 'PENDIENTE', null

									declare @PagoCreado int
									select top 1 @PagoCreado = p.IdPago from Pago p
									order by p.IdPago desc

									Execute sp_CreatePagoServicio @PagoCreado, @pIdServicio
									Execute sp_CreatePagoCliente @PagoCreado, @pIdCliente

									print 'La Solicitud se ha creado correctamente!'
								END
								else
								BEGIN
									Execute sp_DeleteSolicitud @SolicitudCreada
									Raiserror('Ningun proveedor puede realizar el servicio solicitado', 0, 0)
								END
							END
							else
								Raiserror('El Servicio ingresado no se encuentra disponible por el momento', 0, 0)
						END
						else
							Raiserror('El Cliente ingresado no pertenece a ninguna Organizacion relacionada a la Empresa de Asistencias', 0, 0)
					END
					else
						Raiserror('El Cliente ingresado se encuentra baneado (INACTIVO)', 0, 0)
				END
				else
					Raiserror('No existe ningun Empleado que hable el idioma del Cliente', 0, 0)
			END
			else
				Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Calificacion ingresada debe de estar en un rango de 0 a 5', 0, 0)
END
GO

-------------------------------------------------------------------------------------------------------
--									    Efectuar Pago Cliente
								--Execute sp_EfectuarPagoCliente 8, 2, 1
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_EfectuarPagoCliente(
	@pIdCliente int,
	@pIdServicio int,
	@pIdTipoPago int)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		if [dbo].fn_ExisteServicio(@pIdServicio) = 1
		BEGIN
			if [dbo].fn_ExisteTipoPago(@pIdTipoPago) = 1
			BEGIN
				if [dbo].fn_VerificaClienteEnPaqueteServicio(@pIdCliente, @pIdServicio) = 0
				BEGIN
					declare @MiSolicitudServicio int = -1
					set @MiSolicitudServicio = [dbo].fn_RetornarSolicitudServicio(@pIdCliente, @pIdServicio)

					if @MiSolicitudServicio != -1
					BEGIN
						if [dbo].fn_VerificaPagoClienteRealizado(@pIdCliente, @pIdServicio) = 0
						BEGIN
							declare @Pago int
                            Set @Pago = (Select top 1 p.IdPago From Pago p 
                                        inner join PagoCliente pc on pc.IdPago = p.IdPago
                                        inner join PagoServicio ps on ps.IdPago = p.IdPago
                                        inner join SolicitudServicio ss on ss.IdServicio = ps.IdServicio
                                        where pc.IdCliente = @pIdCliente
                                        and ps.IdServicio = @pIdServicio
                                        and ss.IdSolicitudServicio = @MiSolicitudServicio
                                        and p.Estado = 'PENDIENTE'
										
										order by p.IdPago)

                            declare @Fecha date
                            Set @Fecha = (select cast(GETDATE() as date))
                            declare @Hora time
                            Set @Hora = (select cast(GETDATE() as time))
                            exec sp_UpdateSolicitudServicio @MiSolicitudServicio, null, null, 'TERMINADO', null
							exec sp_UpdatePago @Pago, null, 'CANCELADO', @Fecha, @Hora, @pIdTipoPago

							declare @Calificacion tinyint
							set @Calificacion = (select ss.calificacion from SolicitudServicio ss
												where ss.IdSolicitudServicio = @MiSolicitudServicio)

							declare @Proveedor int
							set @Proveedor = (select ps.IdProveedor from ProveedorSolicitud ps
												inner join SolicitudServicio ss on ss.IdSolicitud = ps.IdSolicitud
												where ss.IdSolicitudServicio =  @MiSolicitudServicio)


							exec sp_CreateCalificacionesProveedor @Proveedor, @Calificacion

							print 'El Pago se ha realizado con exito!'
						END
						else
							Raiserror('El Cliente ya ha cancelado el servicio', 0, 0)
					END
					else
						Raiserror('El Cliente ingresado no tiene ninguna solicitud del servicio indicado, o ya ha cancelado sus servicios', 0, 0)
				END
				else
					Raiserror('El pago lo debe de realizar la Organizacion, el servicio indicado está en el paquete del Cliente', 0, 0)
			END
			else
				Raiserror('El Tipo de Pago ingresado no se encuentra en la base de datos', 0, 0)	
		END
		else
			Raiserror('El Servicio ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-------------------------------------------------------------------------------------------------------
--									    Efectuar Pago Orgnizacion
							--Execute sp_EfectuarPagoOrganizacion 6, 4, 8, 1
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_EfectuarPagoOrganizacion(
	@pIdOrganizacion int,
	@pIdPaquete int,
	@pIdCliente int,
	@pTipoPago int)
AS
BEGIN
	if [dbo].fn_ExisteOrganizacion(@pIdOrganizacion) = 1
	BEGIN
		if [dbo].fn_ExisteCliente(@pIdCliente) = 1
		BEGIN
			if [dbo].fn_ExistePaquete(@pIdPaquete) = 1
			BEGIN
				if [dbo].fn_ExisteTipoPago(@pTipoPago) = 1
				BEGIN
					if [dbo].fn_VerificaClientePaquete(@pIdCliente, @pIdPaquete) = 1
					BEGIN
						if [dbo].fn_ExisteClienteEnOrganizacion(@pIdCliente, @pIdOrganizacion) = 1
						BEGIN
							declare @Precio money
							set @Precio = [dbo].fn_ProveedoresParaElPaquete(@pIdPaquete)

							Execute sp_CreatePago @Precio, 'REALIZADO', @pTipoPago

							declare @IdPago int
							set @IdPago = (select top 1 p.IdPago from Pago p order by p.IdPago desc)

							Execute sp_CreatePagoOrganizacion @IdPago, @pIdOrganizacion
							Execute sp_CreatePagoPaquete @IdPago, @pIdPaquete

							print 'El Pago se ha realizado con exito!'
						END
						else
							Raiserror('El Cliente no pertenece a la Organizacion ingresada', 0, 0)
					END
					else
						Raiserror('El Cliente no posee el Paquete ingresado', 0, 0)
				END
				else
					Raiserror('El Tipo de Pago ingresado no se encuentra en la base de datos', 0, 0)
			END
			else
				Raiserror('El Paquete ingresado no se encuentra en la base de datos', 0, 0)
		END
		else
			Raiserror('El Cliente ingresado no se encuentra en la base de datos', 0, 0)
	END
	else
		Raiserror('La Organizacion ingresada no se encuentra en la base de datos', 0, 0)
END
GO

-------------------------------------------------------------------------------------------------------
--									    Calificar Cliente
							--Execute sp_CalificarCliente 1, 4, 3
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_CalificarCliente(
	@pIdProveedor int,
	@pIdCliente int,
	@Calificacion tinyint)
AS
BEGIN
    if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1
    BEGIN
        if [dbo].fn_ExisteCliente(@pIdCliente) = 1
        BEGIN
            if (@Calificacion >= 0 and @Calificacion <= 5)
            BEGIN
                if [dbo].fn_ValidaCalificarCliente(@pIdCliente, @pIdProveedor) = 1
                BEGIN
                    exec sp_CreateCalificacionesCliente @pIdCliente, @Calificacion

					print 'La calificacion se ha realizado'
                END
                else
                    Raiserror('No se pudo realizar la calificacion. El paquete no se ha cancelado o el servicio del cliente no esta asociado al proveedor ingresado', 0, 0) 
            END
            else
                Raiserror('La Calificacion ingresada debe de estar en un rango de 0 a 5', 0, 0)
        END
        else
            Raiserror('El Cliente ingresado no existe en la base de datos', 0, 0)
    END
    else
        Raiserror('El Proveedor ingresado no existe en la base de datos', 0, 0)
END
GO

-------------------------------------------------------------------------------------------------------
--									    Desbanear Proveedor
--									  despues de tres meses
							  --Execute DesbanearProveedor 1, 4, 3
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_DesbanearProveedor(
	@pIdProveedor int)
AS
BEGIN
    if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1
    BEGIN
        if [dbo].fn_VerificaBaneadoProveedor(@pIdProveedor) = 1
        BEGIN
            declare @UltimaCalificacion int=-1
            Set @UltimaCalificacion= isnull((select top 1 cp.IdCalificacionesProveedor From CalificacionesProveedor cp
                                        where cp.IdProveedor = @pIdProveedor order by cp.IdCalificacionesProveedor desc),@UltimaCalificacion)
            if (@UltimaCalificacion) != -1
            BEGIN
                declare @FechaDesbaneo date = null
                Set @FechaDesbaneo = isnull((select cp.FechaDesbaneo from CalificacionesProveedor cp
                                        where cp.IdCalificacionesProveedor = @UltimaCalificacion), @FechaDesbaneo)
                declare @FechaActual date 
                Set @FechaActual= (select cast(GETDATE() as date))
               
			    if (@FechaActual >= @FechaDesbaneo)
                BEGIN
                    exec sp_UpdateProveedor @pIdProveedor, @pEstado = 'ACTIVO'

					print 'El proveedor ha sido desbaneado del sistema'
                END
                else
                    raiserror('No se puede desbanear al proveedor porque no ha cumplido los tres meses de castigo', 0, 0)
            END
            else
                raiserror('El proveedor no tiene ninguna calificacion', 0, 0)
        END
        else
            raiserror('El proveedor no se encuentra baneado', 0, 0)
    END
    else
        raiserror('El proveedor indicado no existe en la base de datos', 0, 0)
END
GO


--***************************************************************************************************--
-------------------------------------------------------------------------------------------------------
-------------------------------------------- CONSULTAS ------------------------------------------------
-------------------------------------------------------------------------------------------------------
--***************************************************************************************************--


-------------------------------------------------------------------------------------------------------
--							Organizaciones que solicitan mas servicios
						--Execute sp_OrganizacionesQueSolicitanMasServicios
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_OrganizacionesQueSolicitanMasServicios
AS
BEGIN
	Select o.Nombre as 'Organizacion', count(op.IdPaquete) as 'Cantidad Paquetes'
    From Paquete p
    inner join OrganizacionPaquete op on  op.IdPaquete = p.IdPaquete
    inner join Organizacion o on o.IdOrganizacion = op.IdOrganizacion
    group by o.nombre 
    order by [Cantidad Paquetes] desc

    select o.nombre as 'Organizacion', c.Nombre as 'Cliente',a.Tipo as 'Servicio que posee el Cliente'
    from Organizacion o
    inner join ClienteOrganizacion co on co.IdOrganizacion=o.IdOrganizacion
    inner join Cliente c on c.IdCliente=co.IdCliente
    inner join ClienteAsistencia ca on ca.IdCliente = c.IdCliente
    inner join Asistencia a on a.IdAsistencia = ca.IdAsistencia

	order by o.nombre
END
GO

-------------------------------------------------------------------------------------------------------
--							Consultar Calificaciones de un Proveedor
						--Execute sp_ConsultarCalificacionesProveedores
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_ConsultarCalificacionesProveedores(
	@pIdProveedor int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		select p.nombre, cp.calificacion from Proveedor p
		inner join CalificacionesProveedor cp on p.IdProveedor = cp.IdProveedor

		where p.IdProveedor = isnull(@pIdProveedor, p.IdProveedor)
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-------------------------------------------------------------------------------------------------------
--								 Consultar Servicios de un Proveedor
							 --Execute sp_ConsultarServiciosProveedores
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE [dbo].sp_ConsultarServiciosProveedores(
	@pIdProveedor int = null)
AS
BEGIN
	if [dbo].fn_ExisteProveedor(@pIdProveedor) = 1 or @pIdProveedor is null
	BEGIN
		select p.nombre, a.Tipo from Proveedor p
		inner join ProveedorServicio ps on p.IdProveedor = ps.IdProveedor
		inner join Asistencia a on ps.IdServicio = a.IdServicio
		where p.IdProveedor = isnull(@pIdProveedor, p.IdProveedor)
		order by p.nombre
	END
	else
		Raiserror('El Proveedor ingresado no se encuentra en la base de datos', 0, 0)
END
GO

-------------------------------------------------------------------------------------------------------
--                               Servicios que dejan mas ganancias
				--Execute sp_ServiciosQueDejanMasGanancia '2017-11-23', '2017-11-28'
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_ServiciosQueDejanMasGanancia(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
	select a.tipo, sum(p.Monto) as 'Monto' from Asistencia a
	inner join Servicio s on s.IdServicio = a.IdServicio
	inner join PagoServicio ps on ps.IdServicio = s.IdServicio
    inner join Pago p on p.IdPago = ps.IdPago
    where (p.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null

    group by a.tipo
    order by [Monto] desc
END
GO

-------------------------------------------------------------------------------------------------------
--                                  Servicios que dejan menos ganancias
				--Execute sp_ServiciosQueDejanMenosGanancia '2017-11-23', '2017-11-28'
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_ServiciosQueDejanMenosGanancia(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
    Select a.tipo , sum(p.Monto) as 'Monto' From Asistencia a
	inner join Servicio s on s.IdServicio = a.IdServicio
    inner join PagoServicio ps on ps.IdServicio = s.IdServicio
    inner join Pago p on p.IdPago = ps.IdPago
    where (p.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null

    group by a.tipo 
    order by [Monto] asc
END
GO

------------------------------------------------------------------------------------------------------
--                                      Clientes que mas solicitan
							--Execute sp_ClientesQueMasSolicitanServicios
-----------------------------------------------------------------------------------------------------
ALTER PROCEDURE sp_ClientesQueMasSolicitanServicios(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
    Select c.Nombre, count(s.IdSolicitud) as 'Solicitudes'
    From Cliente c
    inner join LlamadaCliente cl on cl.IdCliente = c.IdCliente
    inner join LlamadaSolicitud ls on ls.IdLlamada = cl.IdLlamada
    inner join Solicitud s on s.IdSolicitud = ls.IdSolicitud
    where (s.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null
    group by c.Nombre
    Order by [Solicitudes] desc
END
GO

------------------------------------------------------------------------------------------------------
--                                      Clientes que menos solicitan
							--Execute sp_ClientesQueMenosSolicitanServicios
-------------------------------------------------------------------------------------------------------
ALTER PROCEDURE sp_ClientesQueMenosSolicitanServicios(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
    Select c.Nombre, count(s.IdSolicitud) as 'Solicitudes'
    From Cliente c
    inner join LlamadaCliente cl on cl.IdCliente = c.IdCliente
    inner join LlamadaSolicitud ls on ls.IdLlamada = cl.IdLlamada
    inner join Solicitud s on s.IdSolicitud = ls.IdSolicitud
    where (s.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null
    group by c.Nombre
    Order by [Solicitudes] asc
END
GO

-------------------------------------------------------------------------------------------------------
--                                      Servicios mas solicitados
						--Execute sp_ServiciosMasSolicitados '2017-11-23','2017-11-27'
-------------------------------------------------------------------------------------------------------
ALTER PROCEDURE sp_ServiciosMasSolicitados(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
    Select a.tipo, count(sol.Idsolicitud) as 'Solicitudes' From Asistencia a
	inner join Servicio s on s.IdServicio = a.IdServicio
    inner join SolicitudServicio ss on ss.IdServicio = s.IdServicio
    inner join Solicitud sol on sol.IdSolicitud = ss.IdSolicitud
    where (sol.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null
    group by a.tipo
    order by [Solicitudes] desc
END
GO

-----------------------------------------------------------------------------------------------------------------
--                                      Servicios menos solicitados
						--Execute sp_ServiciosMenosSolicitados '2017-11-23','2017-11-27'
-----------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE sp_ServiciosMenosSolicitados(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
    Select a.tipo, count(sol.Idsolicitud) as 'Solicitudes' From Asistencia a
	inner join Servicio s on s.IdServicio = a.IdServicio
    inner join SolicitudServicio ss on ss.IdServicio = s.IdServicio
    inner join Solicitud sol on sol.IdSolicitud = ss.IdSolicitud
    where (sol.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null
    group by a.tipo
    order by [Solicitudes] asc
END
GO

-------------------------------------------------------------------------------------------------------
--								 Consultar Servicios en Proceso
							 --Execute sp_ConsultarServiciosEnProceso
-------------------------------------------------------------------------------------------------------

ALTER PROCEDURE [dbo].sp_ConsultarServiciosEnProceso
AS
BEGIN
	select (a.tipo) as 'Servicio', (c.nombre) as 'Cliente',
	(select datediff(day, s.fecha, getdate())) as 'Retraso Dias'

	from Cliente c
	inner join ClienteAsistencia ca on ca.IdCliente = c.IdCliente
	inner join Asistencia a on ca.IdAsistencia = a.IdAsistencia
	inner join SolicitudServicio ss on a.IdServicio = ss.IdServicio
	inner join Solicitud s on s.IdSolicitud = ss.IdSolicitud

	where ss.estado = 'EN PROCESO'
END
GO

---------------------------------------------------------------------------------------------------------
--                                  Consultar mejores proveedores
						    --Execute sp_ConsultarMejoresProveedores
---------------------------------------------------------------------------------------------------------
ALTER PROCEDURE sp_ConsultarMejoresProveedores(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
    Select p.Nombre, cp.Calificacion
    From Proveedor p
    inner join CalificacionesProveedor cp on cp.IdProveedor=p.IdProveedor
    where (cp.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null
    order by cp.Calificacion desc
END
GO

---------------------------------------------------------------------------------------------------------
--                                    Consultar peores proveedores
							 --Execute sp_ConsultarPeoresProveedores
---------------------------------------------------------------------------------------------------------
ALTER PROCEDURE sp_ConsultarPeoresProveedores(@FechaInicial date = null, @FechaFinal date = null)
AS
BEGIN
    Select p.Nombre, cp.Calificacion
    From Proveedor p
    inner join CalificacionesProveedor cp on cp.IdProveedor=p.IdProveedor
    where (cp.Fecha between @FechaInicial and @FechaFinal) or @FechaInicial is null or @FechaFinal is null
    order by cp.Calificacion asc
END
GO
