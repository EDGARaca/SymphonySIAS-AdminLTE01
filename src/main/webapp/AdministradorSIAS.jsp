<%-- 
    Document   : AdministradorSIAS
    Created on : 7/11/2025, 9:26:21 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || nombre == null || rol == null || !"administrador sias".equals(rol.trim().toLowerCase())) {
        response.sendRedirect("login.jsp");
        return;
    }

    System.out.println("[AdministradorSIAS] Acceso autorizado por: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>AdministradorSIAS | SymphonySIAS</title>
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
                <h4 class="mb-3 text-primary">
                    <i class="fas fa-user-shield"></i> Panel AdministradorSIAS
                </h4>
                <p class="text-muted">Accede a todos los módulos institucionales para pruebas, auditoría y desarrollo.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <!-- Accesos rápidos -->
                    <div class="col-md-3 mb-3">
                        <a href="estudiantes.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-user-graduate"></i> Gestión Estudiantes
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="listarProfesores.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-chalkboard-teacher"></i> Gestión Profesores
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="reportesContables.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-file-invoice-dollar"></i> Auxiliar Contable
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="ReporterServlet" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-file-export"></i> Auxiliar Administrativo
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="director.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-user-tie"></i> Gestión Director
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="coordinador.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-user-cog"></i> Coordinador Académico
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="cursoLibre.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-book-reader"></i> Cursos Libres
                        </a>
                    </div>


                    <div class="col-md-3 mb-3">
                        <a href="horarios.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-calendar-alt"></i> Horarios
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="notas.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-clipboard-list"></i> Notas
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="UsuarioServlet" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-users-cog"></i> Usuarios y Roles
                        </a>
                    </div>

                    <div class="col-md-3 mb-3">
                        <a href="notificaciones.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-bell"></i> Notificaciones
                        </a>
                    </div>

                </div>
            </div>
        </section>
    </div>

    <jsp:include page="componentes/footer.jsp" />
</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>