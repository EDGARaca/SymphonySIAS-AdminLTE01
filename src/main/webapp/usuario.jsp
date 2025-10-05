<%-- 
    Document   : usuario.jsp
    Created on : 4/10/2025, 10:30:17 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%
    // Validación de sesion y rol
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    
    if (usuario == null || !"ADMIN".equals(rol)) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    // Trazabilidad en consola del servidor
    System.out.println("[USUARIOS] Acceso autorizado por: " + usuario + " (" + rol + ")" );  
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestion de Usuarios - SymphonySIAS</title>
        <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="assets/adminlte/dist/css/adminlte.min.css">
    </head>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">
            
            <%-- Navbar --%>
            <jsp:include page="header.jsp" />
            
            <%-- Sidebar --%>
            <jsp:include page="sidebar.jsp" />
            
            <%-- Content --%>
            <div class="content-wrapper">
                <section class="content-header">
                    <div class="container-fluid">
                        <h1 class="m-0">Gestión de Usuarios</h1>                                      
                    </div>
                </section>
                    
                <section class="content">
                    <div class="container-fluid">
                        <p>Aquí irá el contenido de gestión de usuarios para administradores.</p>
                        <%-- Aquí puedo agregar tabla de usuarios, botones de edición, etc. --%>
                    </div>
                </section>                    
            </div>
                    
            <%-- Footer --%>
            <jsp:include page="footer.jsp" />
                            
        </div>
    </body>
</html>
