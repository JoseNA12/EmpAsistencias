
-------------------------------------------------------------------------------------------------------
--									Crear Solicitud (Crear Paquete)

--								IdCliente, IdOrganizacion, 'a,b,c,d'
							  Execute sp_SolicitarAsistencias 3, 5, '4,9,1,2'


-------------------------------------------------------------------------------------------------------
--								    Crear Solicitud (Escoger Paquete)

--								 IdCliente, IdOrganizacion, IdPaquete
								 Execute sp_SolicitarPaquete 4, 4, 26

-------------------------------------------------------------------------------------------------------
--										  Realizar Llamada

--					IdCliente, IdServicio, Calificacion, HoraRequerida (hh:mm:ss)
							Execute sp_RealizarLlamada 4, 11, 5, '11:30:00'


-------------------------------------------------------------------------------------------------------
--									    Efectuar Pago Cliente

--								IdCliente, IdServicio, IdTipoPago
								Execute sp_EfectuarPagoCliente 4, 11, 1


-------------------------------------------------------------------------------------------------------
--									    Efectuar Pago Organizacion

--							IdOrganizacion, IdPaquete, IdCliente, IdTipoPago
							Execute sp_EfectuarPagoOrganizacion 4, 26, 4, 1


-------------------------------------------------------------------------------------------------------
--									    Calificar Cliente

--							IdProveedor, IdCliente, Calificacion
							Execute sp_CalificarCliente 10, 4, 2


-------------------------------------------------------------------------------------------------------
--							Desbanear Proveedor despues de tres meses

--								        IdProveedor
							  Execute sp_DesbanearProveedor 1





-------------------------------------------------------------------------------------------------------
-------------------------------------------- CONSULTAS ------------------------------------------------
-------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------
--							Organizaciones que solicitan mas servicios
						Execute sp_OrganizacionesQueSolicitanMasServicios


-------------------------------------------------------------------------------------------------------
--							Consultar Calificaciones de un Proveedor

--										IdProveedor
						Execute sp_ConsultarCalificacionesProveedores


-------------------------------------------------------------------------------------------------------
--								 Consultar Servicios de un Proveedor

--											IdProveedor
							 Execute sp_ConsultarServiciosProveedores


-------------------------------------------------------------------------------------------------------
--                               Servicios que dejan mas ganancias

--									FechasInicial, FechaFinal
				Execute sp_ServiciosQueDejanMasGanancia '2017-11-23', '2017-11-30'


-------------------------------------------------------------------------------------------------------
--                                  Servicios que dejan menos ganancias

--								        FechasInicial, FechaFinal
				Execute sp_ServiciosQueDejanMenosGanancia '2017-11-23', '2017-11-28'


-------------------------------------------------------------------------------------------------------
--                                      Clientes que mas solicitan

--										FechasInicial, FechaFinal
							Execute sp_ClientesQueMasSolicitanServicios


------------------------------------------------------------------------------------------------------
--                                      Clientes que menos solicitan

--										FechasInicial, FechaFinal
							Execute sp_ClientesQueMenosSolicitanServicios


-------------------------------------------------------------------------------------------------------
--                                      Servicios mas solicitados

--										FechasInicial, FechaFinal
						Execute sp_ServiciosMasSolicitados '2017-11-23','2017-11-30'


-------------------------------------------------------------------------------------------------------
--                                      Servicios menos solicitados

--										FechasInicial, FechaFinal
						Execute sp_ServiciosMenosSolicitados '2017-11-23','2017-11-30'


-------------------------------------------------------------------------------------------------------
--								 Consultar Servicios en Proceso
							 Execute sp_ConsultarServiciosEnProceso


---------------------------------------------------------------------------------------------------------
--                                  Consultar mejores proveedores

--									FechasInicial, FechaFinal
						    Execute sp_ConsultarMejoresProveedores 


---------------------------------------------------------------------------------------------------------
--                                    Consultar peores proveedores

--									FechasInicial, FechaFinal
							 Execute sp_ConsultarPeoresProveedores






Execute sp_CreateCallCenter 'Nombre', 'aqui', 1, 89887655
Execute sp_DeleteCallCenter 5

Execute sp_CreateCliente 'Nombre', 'ACTIVO', 'Direccion', 4, 5, 897645
Execute sp_DeleteCliente

Execute sp_CreateServicio 'DISPONIBLE', 'Servicio de prueba'
execute sp_DeleteServicio 16
execute sp_UpdateServicio 17, null, 'Nuevo tipo'

execute sp_CreateAsistencia 'Asistencia Prueba', 1, 26
execute sp_DeleteAsistencia

Execute sp_CreateEmpleado 'Nombre', 'Cartago', 12000, 1, 3, 896745
Execute sp_DeleteEmpleado 28

Execute sp_CreateOrganizacion 1, 'nueva organizacion', 'aqui', 896754
Execute sp_UpdateIdioma 9, 'nueva idioma'

execute sp_CreateIdioma 'mi idioma'

execute sp_CreateIdiomaEmpleado 7, 5

execute sp_DeleteProveedor 27

execute sp_CreateProveedorServicio 12, 9

execute sp_UpdatePaqueteServicio 76, 6, 8

execute sp_UpdateLlamadaCliente 8, 8, 15

execute sp_CreateTipoPago 'prueba'
execute sp_DeleteTipoPago 6

execute sp_CreateProveedorServicio 18, 10

execute sp_CreateCalificacionesProveedor 2, 1

execute sp_CreateCalificacionesCliente 5, 2
















--DELETE'S--
/*
delete from Pago
delete from PagoCliente
delete from PagoOrganizacion
delete from PagoPaquete
delete from PagoServicio

delete from Solicitud
delete from SolicitudPaquete
delete from SolicitudServicio

delete from Llamada
delete from LlamadaCliente
delete from LlamadaEmpleado
delete from LlamadaSolicitud

delete from OrganizacionPaquete
delete from ClienteAsistencia
delete from ClientePaquete
*/
