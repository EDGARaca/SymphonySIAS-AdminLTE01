<%-- 
    Document   : cursoLibre
    Created on : 31/10/2025, 10:17:03 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>

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

    <jsp:include page="header.jsp" />
    <jsp:include page="sidebar.jsp" />

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

                    <%-- Acceso a listado --%>
                    <div class="col-md-4 mb-3">
                        <a href="listarCursoLibre.jsp" class="btn btn-outline-success btn-block">
                            <i class="fas fa-list-alt"></i> Listar Cursos Libres
                        </a>
                    </div>

                    <%-- Acceso a búsqueda con filtro (opcional) --%>
                    <div class="col-md-4 mb-3">
                        <a href="buscarCursoLibre.jsp" class="btn btn-outline-info btn-block">
                            <i class="fas fa-filter"></i> Buscar con Filtro
                        </a>
                    </div>

                    <%-- Acceso a registro --%>
                    <div class="col-md-4 mb-3">
                        <a href="registroCursoLibre.jsp" class="btn btn-outline-success btn-block">
                            <i class="fas fa-plus-circle"></i> Registrar Curso Libre
                        </a>
                    </div>

                    <%-- Acceso a exportación PDF --%>
                    <div class="col-md-4 mb-3">
                        <a href="ExportarCursosLibresServlet" class="btn btn-outline-danger btn-block">
                            <i class="fas fa-file-pdf"></i> Exportar PDF
                        </a>
                    </div>

                </div>
            </div>
        </section>
    </div>

    <jsp:include page="footer.jsp" />

</div>
</body>
</html>