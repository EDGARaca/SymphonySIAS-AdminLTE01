<%-- 
    Document   : header.jsp
    Created on : 4/10/2025, 8:38:48 p. m.
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
    System.out.println("[HEADER] Sesión activa: " + usuario + " (" + rol + ")");
%>

<%-- Navbar superior fijo --%>
<nav class="main-header navbar navbar-expand navbar-dark bg-primary sticky-top shadow-sm">

    <%-- Logo institucional --%>
    <a class="navbar-brand ml-3" href="dashboard.jsp">
        <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" style="height:45px; opacity:0.9; border-radius:8px;">
    </a>

    <%-- Lema institucional --%>
    <span class="navbar-text text-light ml-3">
        <i class="fas fa-music"></i> ¡Somos una Escuela de Música que te ayuda a impulsar tu desarrollo musical!
    </span>

    <%-- Información de sesión --%>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown">
            <a class="nav-link text-light" data-toggle="dropdown" href="#">
                <i class="fas fa-user-circle fa-2x text-success align-middle me-3"></i>
                <strong><%= nombre %></strong> (<%= rol %>)
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-light" href="ChangePassword.jsp">
                <i class="fas fa-key"></i> Cambiar contraseña
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-light" href="CerrarSesionServlet">
                <i class="fas fa-sign-out-alt"></i> Cerrar sesión
            </a>
        </li>
    </ul>
</nav>






