<%-- 
    Document   : asignaturas
    Created on : 22/10/2025, 12:09:32 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    if (rol == null || (!"administrador".equals(rol) && !"coordinador académico".equals(rol))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Asignaturas</title>
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
                <h4><i class="fas fa-book-open"></i> Gestión de Asignaturas</h4>
                <p class="text-muted">Administra asignaturas y contenidos académicos.</p>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <a href="registroAsignatura.jsp" class="btn btn-outline-success btn-block">
                            <i class="fas fa-plus"></i> Registrar Asignatura
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="listarAsignaturas.jsp" class="btn btn-outline-info btn-block">
                            <i class="fas fa-list"></i> Listar Asignaturas
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