<%-- 
    Document   : profesores
    Created on : 20/10/2025, 4:40:03 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.Profesor" %>
<%@ page import="com.mycom.symphonysias.adminlte01.dao.ProfesorDAO" %>

<%
    ProfesorDAO dao = new ProfesorDAO();
    List<Profesor> lista = dao.listar();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Profesores - SymphonySIAS</title>
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">

        <!-- Encabezado institucional -->
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid text-center">
                    <h4 class="text-primary"><i class="fas fa-chalkboard-teacher"></i> Gestión de Profesores</h4>
                    <p class="text-muted">Listado institucional de profesores registrados</p>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid px-3">
                    <div class="card">
                        <div class="card-header bg-warning">
                            <h3 class="card-title"><i class="fas fa-users"></i> Profesores registrados</h3>
                            <div class="card-tools">
                                <a href="registrarProfesor.jsp" class="btn btn-sm btn-outline-dark">
                                    <i class="fas fa-user-plus"></i> Registrar Profesor
                                </a>
                                <a href="ExportarProfesoresServlet" class="btn btn-sm btn-outline-success">
                                    <i class="fas fa-file-pdf"></i> Exportar PDF
                                </a>
                            </div>
                        </div>

                        <div class="card-body">
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
                            <% if (lista.isEmpty()) { %>
                                <div class="alert alert-info text-center">
                                    <i class="fas fa-info-circle"></i> No hay profesores registrados actualmente.
                                </div>
                            <% } else { %>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-sm">
                                        <thead class="table-warning text-center">
                                            <tr>
                                                <th>ID</th>
                                                <th>Nombre</th>
                                                <th>Apellido</th>
                                                <th>Documento</th>
                                                <th>Correo</th>
                                                <th>Especialidad</th>
                                                <th>Estado</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Profesor p : lista) { %>
                                                <tr>
                                                    <td><%= p.getId() %></td>
                                                    <td><%= p.getNombre() %></td>
                                                    <td><%= p.getApellido() %></td>
                                                    <td><%= p.getDocumento() %></td>
                                                    <td><%= p.getCorreo() %></td>
                                                    <td><%= p.getEspecialidad() %></td>
                                                    <td><%= p.getEstado() %></td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </section>

        </div>
    </div>

    <!-- Scripts -->
    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>
