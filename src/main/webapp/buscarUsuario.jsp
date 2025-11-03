<%-- 
    Document   : buscarUsuario
    Created on : 1/11/2025, 11:00:04 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.util.ArrayList"%>

<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || nombre == null || rol == null){
        response.sendRedirect("login.jsp");
        return;
    }

    System.out.println("[BUSCAR USUARIOS] Sesión activa: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscar Usuarios</title>
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
            <div class="container-fluid">
                <h4 class="mb-3 text-info">
                    <i class="fas fa-filter"></i> Buscar Usuarios
                </h4>
                <p class="text-muted">Filtra usuarios por nombre, rol o estado institucional.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- Formulario de búsqueda -->
                <form action="BuscarUsuariosServlet" method="get" class="mb-4">
                    <div class="row">
                        <div class="col-md-4">
                            <input type="text" name="nombre" class="form-control" placeholder="Nombre del usuario" value="<%= request.getParameter("nombre") != null ? request.getParameter("nombre") : "" %>">
                        </div>
                        <div class="col-md-4">
                            <select name="rol" class="form-control">
                                <option value="">-- Rol --</option>
                                <option value="ADMINISTRADOR SIAS">ADMINISTRADOR SIAS</option>
                                <option value="DIRECTOR">DIRECTOR</option>
                                <option value="COORDINADOR ACADÉMICO">COORDINADOR ACADÉMICO</option>
                                <option value="AUXILIAR ADMINISTRATIVO">AUXILIAR ADMINISTRATIVO</option>
                                <option value="AUXILIAR CONTABLE">AUXILIAR CONTABLE</option>
                                <option value="DOCENTE">DOCENTE</option>
                                <option value="ESTUDIANTE">ESTUDIANTE</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <select name="estado" class="form-control">
                                <option value="">-- Estado --</option>
                                <option value="true">Activo</option>
                                <option value="false">Inactivo</option>
                            </select>
                        </div>
                        <div class="col-md-4 mt-3">
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
                                    <th>Usuario</th>
                                    <th>Correo</th>
                                    <th>Rol</th>
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
                                    <td><%= "true".equals(fila[4]) ? "Activo" : "Inactivo" %></td>
                                </tr>
                                <%
                                        }
                                    } else if (request.getParameter("nombre") != null || request.getParameter("rol") != null || request.getParameter("estado") != null) {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center text-muted">No se encontraron usuarios con los filtros aplicados.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </section>
    </div>

    <jsp:include page="footer.jsp" />

</div>
</body>
</html>

