<%-- 
    Document   : buscarProfesores
    Created on : 25/10/2025, 10:40:25 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>

<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || nombre == null || rol == null){
        response.sendRedirect("login.jsp");
        return;
    }

    System.out.println("[BUSCAR PROFESORES] Sesión activa: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscar Profesores</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <jsp:include page="componentes/header.jsp" />
    <jsp:include page="componentes/sidebar.jsp" />

    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <h4 class="mb-3 text-info">
                    <i class="fas fa-filter"></i> Buscar Profesores
                </h4>
                <p class="text-muted">Filtra profesores por nombre, documento o estado institucional.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- Formulario de búsqueda -->
                <form action="BuscarProfesoresServlet" method="get" class="mb-4">
                    <div class="row">
                        <div class="col-md-4">
                            <input type="text" name="criterio" class="form-control" placeholder="Ingrese criterio de búsqueda" required>
                        </div>
                        <div class="col-md-4">
                            <select name="tipoFiltro" class="form-control">
                                <option value="nombre">Nombre</option>
                                <option value="apellido">Apellido</option>
                                <option value="documento">Documento</option>
                                <option value="estado">Estado</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-info btn-block">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </div>
                </form>

                <!-- Tabla de resultados -->
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <i class="fas fa-table"></i> Resultados de búsqueda
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-light">
                                <tr>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Documento</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    ArrayList<String[]> resultados = (ArrayList<String[]>) request.getAttribute("resultados");
                                    if (resultados != null && !resultados.isEmpty()) {
                                        for (String[] fila : resultados) {
                                %>
                                <tr>
                                    <td><%= fila[0] %></td>
                                    <td><%= fila[1] %></td>
                                    <td><%= fila[2] %></td>
                                    <td><%= fila[3] %></td>
                                </tr>
                                <% 
                                        }
                                    } else if (request.getParameter("criterio") != null) {
                                %>
                                <tr>
                                    <td colspan="4" class="text-center text-muted">No se encontraron resultados para el criterio ingresado.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </section>
    </div>

    <jsp:include page="componentes/footer.jsp" />

</div>
</body>
</html>