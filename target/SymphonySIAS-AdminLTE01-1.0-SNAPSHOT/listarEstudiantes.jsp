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
            <div class="container-fluid">
                <h4><i class="fas fa-users"></i> Estudiantes registrados</h4>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-body table-responsive">
                        <table class="table table-bordered table-hover table-striped">
                            <thead class="thead-dark text-center">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Documento</th>
                                    <th>Dirección</th>
                                    <th>Teléfono</th>
                                    <th>Email</th>
                                    <th>Fecha Nac.</th>
                                    <th>Género</th>
                                    <th>Estado</th>
                                    <th>Registrado por</th>
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
                                    <td><%= est.getEmail() %></td>
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
</body>
</html>