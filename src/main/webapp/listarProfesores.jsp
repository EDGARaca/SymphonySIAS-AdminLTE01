<%-- 
    Document   : listarProfesores
    Created on : 22/10/2025, 12:10:50 a. m.
    Author     : Spiri
--%>


<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Profesor"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.ProfesorDAO"%>

<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null ||
        !(rol.equals("administrador") || rol.equals("coordinador académico") || rol.equals("director"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Trazabilidad en consola
    System.out.println("[PROFESORES] Sesión activa: " + usuario + " (" + rol + ")");

    ProfesorDAO dao = new ProfesorDAO();
    List<Profesor> lista = dao.listar();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Profesores</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <jsp:include page="header.jsp" />
    <jsp:include page="sidebar.jsp" />

    <div class="content-wrapper">

        <section class="content-header">
            <div class="content-header">
                <div class="container-fluid">
                    <% if ("administrador".equals(rol)) { %>
                        <div class="d-flex justify-content-end mb-3">
                            <a href="registroProfesor.jsp" class="btn btn-success">
                                <i class="fas fa-plus-circle"></i> Registrar nuevo profesor
                            </a>
                        </div>
                    <% } %>
                    <h4 class="mb-3 text-primary">
                        <i class="fas fa-chalkboard-teacher"></i> Listado de Profesores
                    </h4>
                </div>
            </div>

            <div class="container-fluid">
                <% String registrado = request.getParameter("registrado");
                   String editado = request.getParameter("editado");
                   String eliminado = request.getParameter("eliminado");
                   String error = request.getParameter("error");
                %>

                <% if (registrado != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>✔ Profesor registrado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (editado != null) { %>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <strong>✎ Profesor editado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (eliminado != null) { %>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>🗑 Profesor eliminado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>⚠ Ocurrió un error al procesar la solicitud.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } %>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-users"></i> Profesores registrados
                        </h5>
                        <div class="card-tools">
                            <a href="ExportarProfesoresServlet" class="btn btn-sm btn-outline-success">
                                <i class="fas fa-file-pdf"></i> Exportar PDF
                            </a>
                        </div>
                    </div>
                    <div class="card-body table-responsive">
                        <% if (request.getParameter("sinDatos") != null) { %>
                            <div class="alert alert-warning text-center">
                                <i class="fas fa-exclamation-triangle"></i> No hay registros disponibles para exportar.
                            </div>
                        <% } %>

                        <% if (request.getParameter("exportado") != null) { %>
                            <div class="alert alert-success text-center">
                                <i class="fas fa-file-export"></i> Exportación completada correctamente.
                            </div>
                        <% } %>

                        <table class="table table-bordered table-hover table-striped">
                            <thead class="thead-dark text-center">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Documento</th>
                                    <th>Direccion</th>
                                    <th>Telefono</th>
                                    <th>Correo</th>
                                    <th>Fecha_nacimiento</th>
                                    <th>Especialidad</th>
                                    <th>Genero</th>
                                    <th>Estado</th>
                                    <th>Usuario_registro</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Profesor p : lista) { %>
                                    <tr>
                                        <td><%= p.getId() %></td>
                                        <td><%= p.getNombre() %></td>
                                        <td><%= p.getApellido() %></td>
                                        <td><%= p.getDocumento() %></td>
                                        <td><%= p.getDireccion() %></td>
                                        <td><%= p.getTelefono() %></td>
                                        <td><%= p.getCorreo() %></td>
                                        <td><%= p.getFecha_nacimiento() %></td>
                                        <td><%= p.getEspecialidad() %></td>
                                        <td><%= p.getGenero() %></td>
                                        <td><%= p.getEstado() %></td>
                                        <td><%= p.getUsuario_registro() %></td>
                                        <td class="text-center">
                                            <a href="editarProfesor.jsp?id=<%= p.getId() %>" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="ProfesorServlet?accion=eliminar&id=<%= p.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar este profesor?');">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <jsp:include page="footer.jsp" />
</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>

<script>
    // Ocultar alertas después de 8 segundos
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            alert.classList.remove('show');
            alert.classList.add('fade');
        });
    }, 8000);
</script>
</body>
</html>