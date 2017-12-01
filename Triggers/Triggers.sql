-----------------------------------------------------------------------------------------------
--								Crear Asistencia al crear Servicio
-----------------------------------------------------------------------------------------------

CREATE TRIGGER tr_CrearAsistencia
	ON Servicio
	AFTER INSERT
AS
BEGIN
	declare @Tipo varchar(50)
    Set @Tipo = (Select i.tipo From inserted i)
 
    declare @IdServicio int
    Set @IdServicio = (Select i.IdServicio From inserted i)
    exec sp_CreateAsistencia @Tipo, 1, @IdServicio

    declare @Proveedor int
    Set @Proveedor = (Select top 1 p.IdProveedor from Proveedor p order by NEWID())

    exec sp_CreateProveedorServicio @IdServicio, @Proveedor
END
GO

-----------------------------------------------------------------------------------------------
--				Poner INACTIVO al Proveedor por sus malas calificaciones recibidas
--						3 calificaiones menores a 3 durante 1 mes
-----------------------------------------------------------------------------------------------

CREATE TRIGGER CastigarProveedor
	ON CalificacionesProveedor
	FOR Insert, Update
AS
BEGIN
	declare @IdCalificacionProveedor int
	declare @proveedor int
	declare @calificacion int
	declare @Rows int = 0
	declare @castigar int = 0

	set @IdCalificacionProveedor = (select i.IdCalificacionesProveedor from inserted i)

	set @proveedor = (select p.IdProveedor from Inserted p)

	declare Calificaciones cursor scroll for
		select cp.calificacion from Proveedor p
		inner join CalificacionesProveedor cp on p.IdProveedor = cp.IdProveedor
		where datediff(month, cp.fecha, getdate()) <= 1 and p.IdProveedor = @proveedor
		
		--SELECT DATEDIFF(month, '2005-12-31 23:59:59.9999999', '2005-12-01 00:00:00.0000000');
	open Calificaciones
	fetch next from Calificaciones into @calificacion

	while @@FETCH_STATUS = 0
    BEGIN
		set @Rows += 1
		fetch next from Calificaciones into  @calificacion
    END

	if @Rows >= 3
	BEGIN
		fetch first from Calificaciones into  @calificacion

		while @@FETCH_STATUS = 0
		BEGIN
			if @calificacion >= 3
			BEGIN
				set @castigar = 1
			END

			fetch next from Calificaciones into @calificacion
		END
	END
	else
		set @castigar = 1

	close Calificaciones
	deallocate Calificaciones
	
	if @castigar = 0
	BEGIN
		declare @FechaBaneado date
        declare @FechaDesbaneo date

        Set @FechaBaneado =  (select cast(GETDATE() as date))
        Set @FechaDesbaneo = (select cast(GETDATE() as date))
        Set @FechaDesbaneo = (Select DATEADD(month, 3 ,@FechaDesbaneo))

		exec sp_UpdateProveedor @pIdProveedor = @proveedor, @pEstado = 'INACTIVO'
		exec sp_UpdateCalificacionesProveedor @IdCalificacionProveedor, null, null, null, @FechaDesbaneo

		declare @nombre varchar(50) = (select p.nombre from Proveedor p where p.IdProveedor = @proveedor)
		print 'Se ha castigado al Proveedor ' + CONVERT(varchar(50), @proveedor) +': ' + @nombre
	END

END
GO


-----------------------------------------------------------------------------------------------
--				Poner INACTIVO al Cliente por sus malas calificaiones de los ultimos
--									5 servicios solicitados
/*
A los clientes se les califica también por parte de los proveedores, un cliente que constantemente 
reciba calificaciones menores a 3 (de los últimos 5 servicios solicitados), se inactiva y no se le 
brinda servicio.
*/
-----------------------------------------------------------------------------------------------

ALTER TRIGGER CastigarCliente
	ON CalificacionesCliente
	FOR Insert, Update
AS
BEGIN
	declare @IdClienteCalificado int
	set @IdClienteCalificado = (select c.IdCliente from Inserted c)

	declare @calificacion int
	declare @cantidadServicios int = 0
	declare @puedeCastigar int = 0

	declare ServiciosSolicitados cursor for

		select top 5 cc.calificacion from CalificacionesCliente cc
		inner join Cliente c on c.IdCliente = cc.IdCliente
		where c.IdCliente = 3

		order by cc.IdCalificacionesCliente desc

	open ServiciosSolicitados
	fetch next from ServiciosSolicitados into @calificacion

	while @@FETCH_STATUS = 0
    BEGIN
		set @cantidadServicios += 1

		if @calificacion < 3
		BEGIN
			set @puedeCastigar += 1
		END

		fetch next from ServiciosSolicitados into @calificacion
    END

	close ServiciosSolicitados
	deallocate ServiciosSolicitados

	if @puedeCastigar = @cantidadServicios and @cantidadServicios >= 5
	BEGIN

		Execute sp_UpdateCliente @IdClienteCalificado, @pEstado = 'INACTIVO'
		declare @nombre varchar(50) = (select c.nombre from Cliente c where c.IdCliente = @IdClienteCalificado)
		print 'El Cliente ' + CONVERT(varchar(50), @IdClienteCalificado) + ': ' + @nombre + ', ha sido bloquedo del sistema por malas calificaciones'

	END
END
GO
