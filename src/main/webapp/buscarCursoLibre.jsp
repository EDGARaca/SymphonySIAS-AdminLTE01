<%-- 
    Document   : buscarcursoLibre
    Created on : 31/10/2025, 10:30:33 p. m.
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

    if (usuario == null || rol == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // Parámetros de filtro
    String filtroEstado = request.getParameter("estado");
    String filtroNombre = request.getParameter("nombre");
    String filtroFrecuencia = request.getParameter("frecuencia");

    CursoLibreDAO dao = new CursoLibreDAO();
    List<CursoLibre> lista = dao.listar(); // Puedes reemplazar por método filtrar() si lo modularizas

    // Filtrado manual en JSP (temporal)
    List<CursoLibre> resultados = new java.util.ArrayList<>();
    for (CursoLibre c : lista) {
        boolean coincide = true;

        if (filtroEstado != null && !filtroEstado.isEmpty() && !c.getEstado().equalsIgnoreCase(filtroEstado)) {
            coincide = false;
        }
        if (filtroNombre != null && !filtroNombre.isEmpty() && !c.getNombre().toLowerCase().contains(filtroNombre.toLowerCase())) {
            coincide = false;
        }
        if (filtroFrecuencia != null && !filtroFrecuencia.isEmpty() && !c.getFrecuencia().equalsIgnoreCase(filtroFrecuencia)) {
            coincide = false;
        }

        if (coincide) {
            resultados.add(c);
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscar Cursos Libres</title>
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
                    <i class="fas fa-search"></i> Buscar Cursos Libres
                </h4>
                <form method="get" class="row g-3">
                    <div class="col-md-3">
                        <input type="text" name="nombre" class="form-control" placeholder="Nombre del curso" value="<%= filtroNombre != null ? filtroNombre : "" %>">
                    </div>
                    <div class="col-md-3">
                        <select name="frecuencia" class="form-control">
                            <option value="">-- Frecuencia --</option>
                            <option value="mensual" <%= "mensual".equals(filtroFrecuencia) ? "selected" : "" %>>Mensual</option>
                            <option value="semanal" <%= "semanal".equals(filtroFrecuencia) ? "selected" : "" %>>Semanal</option>
                            <option value="quincenal" <%= "quincenal".equals(filtroFrecuencia) ? "selected" : "" %>>Quincenal</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="estado" class="form-control">
                            <option value="">-- Estado --</option>
                            <option value="activo" <%= "activo".equals(filtroEstado) ? "selected" : "" %>>Activo</option>
                            <option value="inactivo" <%= "inactivo".equals(filtroEstado) ? "selected" : "" %>>Inactivo</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-outline-info btn-block">
                            <i class="fas fa-search"></i> Buscar
                        </button>
                    </div>
                </form>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-filter"></i> Resultados de búsqueda
                        </h5>
                    </div>
                    <div class="card-body table-responsive">
                        <% if (resultados.isEmpty()) { %>
                            <div class="alert alert-warning text-center">
                                <i class="fas fa-exclamation-circle"></i> No se encontraron cursos con los filtros aplicados.
                            </div>
                        <% } else { %>
                            <table class="table table-bordered table-hover table-striped text-center">
                                <thead class="thead-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Valor</th>
                                        <th>Frecuencia</th>
                                        <th>Estado</th>
                                        <th>Usuario</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (CursoLibre c : resultados) { %>
                                        <tr>
                                            <td><%= c.getId() %></td>
                                            <td><%= c.getNombre() %></td>
                                            <td>$<%= c.getValor() %></td>
                                            <td><%= c.getFrecuencia() %></td>
                                            <td><%= c.getEstado() %></td>
                                            <td><%= c.getUsuario_registro() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } %>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <jsp:include page="footer.jsp" />

</div>
</body>
</html>