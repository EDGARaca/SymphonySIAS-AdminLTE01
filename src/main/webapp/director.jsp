<%-- 
    Document   : director
    Created on : 22/10/2025, 11:46:19 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    if (usuario == null || rol == null || !"director".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Director</title>
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
                <h4><i class="fas fa-user-tie"></i> Panel Director</h4>
                <p class="text-muted">Accede a módulos estratégicos para gestión académica y administrativa.</p>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <a href="listarProfesores.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-chalkboard-teacher"></i> Profesores
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="estudiantes.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-user-graduate"></i> Estudiantes
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="reportesContables.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-file-invoice-dollar"></i> Reportes Contables
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