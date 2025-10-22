<%-- 
    Document   : auditoria
    Created on : 22/10/2025, 11:40:27 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>

<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || nombre == null || rol == null){
        response.sendRedirect("login.jsp");
        return;
    }

    System.out.println("[ADMINISTRADORSIAS] Sesión activa: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>AdministradorSIAS</title>
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
                    <i class="fas fa-user-shield"></i> Panel AdministradorSIAS
                </h4>
                <p class="text-muted">Accede a todos los módulos institucionales para pruebas, auditoría y desarrollo.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <%-- Accesos rápidos a los 12 módulos --%>
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
                        <a href="asignaturas.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-book-open"></i> Asignaturas
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

    <jsp:include page="footer.jsp" />

</div>
</body>
</html>
