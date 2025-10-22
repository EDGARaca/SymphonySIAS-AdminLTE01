<%-- 
    Document   : coordinador_academico
    Created on : 22/10/2025, 11:46:47 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    if (usuario == null || rol == null || !"coordinador académico".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Coordinador Académico</title>
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
                <h4><i class="fas fa-user-cog"></i> Panel Coordinador Académico</h4>
                <p class="text-muted">Accede a módulos de planificación, asignaturas y seguimiento docente.</p>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <a href="asignaturas.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-book-open"></i> Asignaturas
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="listarProfesores.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-chalkboard-teacher"></i> Profesores
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="contenidos.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-book"></i> Contenidos
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
