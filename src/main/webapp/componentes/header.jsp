<%-- 
    Document   : header.jsp
    Created on : 4/10/2025, 8:38:48 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
    String base = request.getContextPath();

    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rol") : null;

    if (usuario == null || nombre == null || rol == null){
        response.sendRedirect(base + "/login.jsp");
        return;
    }

    System.out.println("[HEADER] Sesión activa: " + usuario + " (" + rol + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Administrativo</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="<%= base %>/assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="<%= base %>/assets/adminlte/plugins/fontawesome-free/css/all.min.css">

    <!-- AdminLTE -->
    <link rel="stylesheet" href="<%= base %>/assets/adminlte/css/adminlte.min.css">

    <!-- Estilos personalizados -->
    <link rel="stylesheet" href="<%= base %>/assets/adminlte/css/custom.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

<!-- Navbar superior fijo -->
<nav class="main-header navbar navbar-expand navbar-dark bg-primary sticky-top shadow-sm">
    <a class="navbar-brand ml-3" href="<%= base %>/vistas/dashboard.jsp">
        <img src="<%= base %>/assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" style="height:45px; opacity:0.9; border-radius:8px;">
    </a>

    <span class="navbar-text text-light ml-3">
        <i class="fas fa-music"></i> ¡Somos una Escuela de Música que te ayuda a impulsar tu desarrollo musical!
    </span>

    <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown">
            <a class="nav-link text-light" data-toggle="dropdown" href="#">
                <i class="fas fa-user-circle fa-2x text-success align-middle me-3"></i>
                <strong><%= nombre %></strong> (<%= rol %>)
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-light" href="<%= base %>/ChangePassword.jsp">
                <i class="fas fa-key"></i> Cambiar contraseña
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-light" href="<%= base %>/CerrarSesionServlet">
                <i class="fas fa-sign-out-alt"></i> Cerrar sesión
            </a>
        </li>
    </ul>
</nav>



