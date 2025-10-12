<%-- 
    Document   : header.jsp
    Created on : 4/10/2025, 8:38:48 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>

<%
    //Validacion de sesión
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

<%-- Navbar superior --%> 
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <%-- Contenido del navbar --%>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item">
            <a class="nav-link" href="ChangePassword.jsp"><i class="fas fa-key"></i>Cambiar contraseña</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i>Cerrar sesión</a>
        </li>    
    </ul>
</nav>






