<%-- 
    Document   : listarCursoLibre.jsp
    Created on : 30/10/2025, 10:12:12 p. m.
    Author     : Spiri
--%>


<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO"%>

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
    System.out.println("[CURSOS LIBRES] Sesión activa: " + usuario + " (" + rol + ")");

    CursoLibreDAO dao = new CursoLibreDAO();
    List<CursoLibre> lista = dao.listar();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Cursos Libres</title>
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
                            <a href="registroCursoLibre.jsp" class="btn btn-success">
                                <i class="fas fa-plus-circle"></i> Registrar nuevo curso
                            </a>
                        </div>
                    <% } %>
                    <h4 class="mb-3 text-success">
                        <i class="fas fa-book-open"></i> Cursos Libres Registrados
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
                        <strong>✔ Curso registrado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (editado != null) { %>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <strong>✎ Curso editado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (eliminado != null) { %>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>🗑 Curso eliminado correctamente.</strong>
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
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-list-alt"></i> Cursos registrados
                        </h5>
                        <div class="card-tools">
                            <a href="ExportarCursosLibresServlet" class="btn btn-sm btn-outline-light">
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

                        <table class="table table-bordered table-hover table-striped text-center">
                            <thead class="thead-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Valor</th>
                                    <th>Frecuencia</th>
                                    <th>Estado</th>
                                    <th>Usuario que registró</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (CursoLibre c : lista) { %>
                                    <tr>
                                        <td><%= c.getId() %></td>
                                        <td><%= c.getNombre() %></td>
                                        <td>$<%= c.getValor() %></td>
                                        <td><%= c.getFrecuencia() %></td>
                                        <td><%= c.getEstado() %></td>
                                        <td><%= c.getUsuario_registro() %></td>
                                        <td>
                                            <a href="editarCursoLibre.jsp?id=<%= c.getId() %>" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="CursoLibreServlet?accion=eliminar&id=<%= c.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar este curso?');">
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