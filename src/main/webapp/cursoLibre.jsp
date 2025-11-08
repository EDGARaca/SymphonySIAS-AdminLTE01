<%-- 
    Document   : cursoLibre
    Created on : 31/10/2025, 10:17:03 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO"%>

<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || nombre == null || rol == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // Trazabilidad en consola
    System.out.println("[CURSOS LIBRES] Sesión activa: " + usuario + " (" + rol + ")");

    // Recuperar resultados si existen
    List<CursoLibre> resultados = (List<CursoLibre>) request.getAttribute("resultados");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Cursos Libres</title>
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
                <h4 class="mb-3 text-success">
                    <i class="fas fa-book-open"></i> Módulo Cursos Libres
                </h4>
                <p class="text-muted">Accede a las funcionalidades del módulo cursos libres según tu rol institucional.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <a href="listarCursoLibre.jsp" class="btn btn-outline-success btn-block">
                            <i class="fas fa-list-alt"></i> Listar Cursos Libres
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="registroCursoLibre.jsp" class="btn btn-outline-success btn-block">
                            <i class="fas fa-plus-circle"></i> Registrar Curso Libre
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="ExportarCursosLibresServlet" class="btn btn-outline-danger btn-block">
                            <i class="fas fa-file-pdf"></i> Exportar PDF
                        </a>
                    </div>
                </div>

                <!-- Formulario de búsqueda -->
                <div class="card mt-3">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-search"></i> Buscar Cursos Libres
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="get" action="FiltrarCursoLibreServlet" class="row g-3" onsubmit="return validarBusqueda();">
                            <div class="col-md-3">
                                <input type="text" name="nombre" class="form-control" placeholder="Nombre del curso">
                            </div>
                            <div class="col-md-3">
                                <select name="frecuencia" class="form-control">
                                    <option value="">-- Frecuencia --</option>
                                    <option value="mensual">Mensual</option>
                                    <option value="semanal">Semanal</option>
                                    <option value="quincenal">Quincenal</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select name="estado" class="form-control">
                                    <option value="">-- Estado --</option>
                                    <option value="activo">Activo</option>
                                    <option value="inactivo">Inactivo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-outline-info btn-block">
                                    <i class="fas fa-search"></i> Buscar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Resultados de búsqueda -->
                <% if (resultados != null) { %>
                <div class="card mt-3">
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
                <% } %>

            </div>
        </section>

        <jsp:include page="componentes/footer.jsp" />
    </div>
</div>

<script>
function validarBusqueda() {
    const nombre = document.querySelector('input[name="nombre"]').value.trim();
    const frecuencia = document.querySelector('select[name="frecuencia"]').value.trim();
    const estado = document.querySelector('select[name="estado"]').value.trim();

    if (nombre === "" && frecuencia === "" && estado === "") {
        alert("Debe ingresar al menos un criterio de búsqueda.");
        return false;
    }
    return true;
}
</script>

</body>
</html>