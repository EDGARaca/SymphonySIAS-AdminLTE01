<%-- 
    Document   : usuario.jsp
    Created on : 4/10/2025, 10:30:17 p. m.
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

    System.out.println("[USUARIOS] Sesión activa: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
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
                <h4 class="mb-3 text-secondary">
                    <i class="fas fa-users-cog"></i> Módulo Usuarios
                </h4>
                <p class="text-muted">Accede a las funcionalidades del módulo usuarios según tu rol institucional.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <jsp:include page="listarUsuarios.jsp" />
            </div>
        </section>

        <jsp:include page="footer.jsp" />
    </div>

</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>