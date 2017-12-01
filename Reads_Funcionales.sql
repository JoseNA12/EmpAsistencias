CREATE PROCEDURE sp_VerClientesOrganizaciones(@pIdCliente int)
AS
BEGIN
	if [dbo].fn_ExisteCliente(@pIdCliente) = 1
	BEGIN
		select c.nombre, o.nombre from Cliente c
		inner join ClienteOrganizacion co on co.IdCliente = c.IdCliente
		inner join Organizacion o on o.IdOrganizacion = co.IdOrganizacion
		where @pIdCliente = c.IdCliente
	END
	else
		raiserror('El cliente no existe en la base de datos',0,0)
END
GO

CREATE PROCEDURE sp_VerIdiomasEmpleado(@pIdEmpleado int)
AS
BEGIN
    if [dbo].fn_ExisteEmpleado(@pIdEmpleado) = 1
    BEGIN
        Select e.Nombre, i.Idioma
        From Empleado e 
        inner join IdiomaEmpleado ie on ie.IdEmpleado = e.IdEmpleado
        inner join Idioma i on i.IdIdioma=ie.IdIdioma
        where e.IdEmpleado = @pIdEmpleado
    END
    else
        raiserror('El empleado no existe en la base de datos',0,0)
END
GO

CREATE PROCEDURE sp_VerIdiomasCliente(@pIdCliente int)
AS
BEGIN
    if [dbo].fn_ExisteCliente(@pIdCliente)=1
    BEGIN
        Select c.Nombre, i.Idioma
        From Cliente c
        inner join IdiomaCliente ic on ic.IdCliente = c.IdCliente
        inner join Idioma i on i.IdIdioma = ic.IdIdioma
        where c.IdCliente = @pIdCliente
    END
    else
        raiserror('El cliente no existe en la base de datos',0,0)
END
GO

CREATE PROCEDURE VerServicioDeSolicitud(@pIdSolicitud int)
AS
BEGIN
    if [dbo].fn_ExisteSolicitud(@pIdSolicitud) = 1
    BEGIN
        Select s.IdSolicitud, serv.Tipo
        From Solicitud s
        inner join SolicitudServicio ss on ss.IdSolicitud = s.IdSolicitud
        inner join Servicio serv on serv.IdServicio = ss.IdServicio
        where s.IdSolicitud = @pIdSolicitud
    END
    else
        raiserror('La solicitud no existe en la base de datos',0,0)
END
GO