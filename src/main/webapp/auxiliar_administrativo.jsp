<%-- 
    Document   : auxiliar_administrativo
    Created on : 22/10/2025, 12:05:59 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    if (rol == null || !"auxiliar administrativo".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Auxiliar Administrativo</title>
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
                <h4><i class="fas fa-file-export"></i> Gestión Auxiliar Administrativo</h4>
                <p class="text-muted">Accede a exportaciones y reportes institucionales.</p>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <a href="ReporterServlet" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-file-export"></i> Exportar Reportes
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