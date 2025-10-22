<%-- 
    Document   : listarEstudiantes
    Created on : 16/10/2025, 9:09:53 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Estudiante"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.EstudianteDAO"%>

<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null || 
        !(rol.equals("administrador") || rol.equals("coordinador académico") || rol.equals("director"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Obtener lista de estudiantes
    EstudianteDAO dao = new EstudianteDAO();
    List<Estudiante> lista = dao.listarEstudiantes();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Estudiantes</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <%-- Navbar y Sidebar --%>
    <jsp:include page="header.jsp" />
    <jsp:include page="sidebar.jsp" />

    <div class="content-wrapper">
        
        <section class="content-header">
            <div class="content-header">
                <div class="container-fluid">
                    <% if ("administrador".equals(rol)) { %>
                        <div class="d-flex justify-content-end mb-3">
                            <a href="registroEstudiante.jsp" class="btn btn-success">
                                <i class="fas fa-plus-circle"></i> Registrar nuevo estudiante
                            </a>
                        </div>
                    <% } %>
                    <h4 class="mb-3 text-primary">
                        <i class="fas fa-user-graduate"></i> Listado de Estudiantes
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
                        <strong>✔ Estudiante registrado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (editado != null) { %>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <strong>✎ Estudiante editado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (eliminado != null) { %>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>🗑 Estudiante eliminado correctamente.</strong>
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
                            <i class="fas fa-users"></i> Estudiantes registrados
                        </h5>
                        <div class="card-tools">
                            <a href="ExportarEstudiantesServlet" class="btn btn-sm btn-outline-success">
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
                                    <th>Dirección</th>
                                    <th>Teléfono</th>
                                    <th>Correo</th>
                                    <th>Fecha Nac.</th>
                                    <th>Género</th>
                                    <th>Estado</th>
                                    <th>Reg. por</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Estudiante est : lista) {
                                %>
                                <tr>
                                    <td><%= est.getId() %></td>
                                    <td><%= est.getNombre() %></td>
                                    <td><%= est.getApellido() %></td>
                                    <td><%= est.getDocumento() %></td>
                                    <td><%= est.getDireccion() %></td>
                                    <td><%= est.getTelefono() %></td>
                                    <td><%= est.getCorreo() %></td>
                                    <td><%= est.getFechaNacimiento() %></td>
                                    <td><%= est.getGenero() %></td>
                                    <td><%= est.getEstado() %></td>
                                    <td><%= est.getUsuarioRegistro() %></td>
                                    <td class="text-center">
                                        <a href="editarEstudiante.jsp?id=<%= est.getId() %>" class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="EstudianteServlet?accion=eliminar&id=<%= est.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar este estudiante?');">
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
</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>

<script>
    // Ocultar alertas después de 4 segundos
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