<%-- 
    Document   : listarEstudiantePorProfesor
    Created on : 28/11/2025, 3:32:17 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rol") : null;

    // Solo permitir acceso a PROFESOR
    if (usuario == null || rol == null || !rol.equalsIgnoreCase("PROFESOR")) {
        response.sendRedirect("login.jsp?logout=true");
        return;
    }

    int idProfesor = Integer.parseInt(request.getParameter("idProfesor"));

    CursoLibreDAO dao = new CursoLibreDAO();
    List<CursoLibre> listaCursos = dao.listarCursosPorProfesor(idProfesor);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Cursos Libres</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <%-- Navbar y Sidebar --%>
    <jsp:include page="componentes/header.jsp" />
    <jsp:include page="componentes/sidebar.jsp" />

    <div class="content-wrapper">

        <section class="content-header">
            <div class="container-fluid">
                <h4 class="mb-3 text-primary">
                    <i class="fas fa-book"></i> Mis Cursos Libres
                </h4>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-chalkboard-teacher"></i> Cursos registrados
                        </h5>
                    </div>
                    <div class="card-body table-responsive">
                        <% if (listaCursos == null || listaCursos.isEmpty()) { %>
                            <div class="alert alert-warning text-center">
                                <i class="fas fa-exclamation-triangle"></i> No tiene cursos registrados actualmente.
                            </div>
                        <% } else { %>
                            <table class="table table-bordered table-hover table-striped">
                                <thead class="thead-dark text-center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Horario</th>
                                        <th>Valor</th>
                                        <th>Frecuencia</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (CursoLibre curso : listaCursos) { %>
                                        <tr>
                                            <td><%= curso.getId() %></td>
                                            <td><%= curso.getNombre() %></td>
                                            <td><%= curso.getHorario() != null ? curso.getHorario() : "-" %></td>
                                            <td><%= curso.getValor() %></td>
                                            <td><%= curso.getFrecuencia() %></td>
                                            <td><%= curso.getEstado() %></td>
                                            <td class="text-center">
                                                <a href="CursoLibreServlet?accion=verEstudiantes&idCurso=<%= curso.getId() %>"
                                                    class="btn btn-sm btn-info">
                                                    <i class="fas fa-users"></i> Ver Estudiantes
                                                </a>

                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } %>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="componentes/footer.jsp" />
    </div>
</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>