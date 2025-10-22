<%-- 
    Document   : listarProfesores
    Created on : 22/10/2025, 12:10:50 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.util.*"%>

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
    System.out.println("[VISTA] Sesión activa: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nombre de la Vista</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <%-- Encabezado institucional --%>
    <jsp:include page="header.jsp" />

    <%-- Menú lateral dinámico --%>
    <jsp:include page="sidebar.jsp" />

    <%-- Contenido principal --%>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <h4 class="mb-3 text-primary">
                    <i class="fas fa-chalkboard-teacher"></i> Título de la Vista
                </h4>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <%-- Aquí va el contenido específico de la vista --%>
            </div>
        </section>
    </div>

    <%-- Pie de página institucional --%>
    <jsp:include page="footer.jsp" />

</div>
</body>
</html>
