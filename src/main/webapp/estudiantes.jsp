<%-- 
    Document   : estudiantes
    Created on : 22/10/2025, 9:17:08 a. m.
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
    System.out.println("[ESTUDIANTES] Sesión activa: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Estudiantes</title>
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
                <h4 class="mb-3 text-primary">
                    <i class="fas fa-user-graduate"></i> Módulo Estudiantes
                </h4>
                <p class="text-muted">Accede a las funcionalidades del módulo estudiantes según tu rol institucional.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <%-- Acceso a listado --%>
                    <div class="col-md-4 mb-3">
                        <a href="listarEstudiantes.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-list"></i> Listar Estudiantes
                        </a>
                    </div>
                    
                    <%-- Acceso a búsqueda con filtro --%>
                    <div class="col-md-4 mb-3">
                        <a href="buscarEstudiantes.jsp" class="btn btn-outline-info btn-block">
                            <i class="fas fa-filter"></i> Buscar con Filtro
                        </a>
                    </div>

                    <%-- Acceso a registro --%>
                    <div class="col-md-4 mb-3">
                        <a href="registroEstudiante.jsp" class="btn btn-outline-success btn-block">
                            <i class="fas fa-user-plus"></i> Registrar Estudiante
                        </a>
                    </div>

                    <%-- Acceso a exportación PDF --%>
                    <div class="col-md-4 mb-3">
                        <a href="ExportarEstudiantesServlet" class="btn btn-outline-danger btn-block">
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