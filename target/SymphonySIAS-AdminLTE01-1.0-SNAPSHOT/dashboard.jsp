<%-- 
    Document   : dashboard
    Created on : 1/10/2025, 8:04:14 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="javax.servlet.http.HttpSession" %>

<%
    // Validación de sesion
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    
    if (usuario == null || nombre == null ||rol == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Trazabilidad en consola del servidor
    System.out.println("Acceso autorizado al dashboard por usuario: " + usuario);  
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard - SymphonySIAS</title>
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
                        <h1 class="m-0">Bienvenido, <strong><%= nombre %></strong> (<%= rol %>)</h1>                                      
                        <p>Usuario activo: <%= usuario %></p>
                    </div>
                </section>
                    
                <section class="content">
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Panel principal</h3>
                            </div>
                            <div class="card-body">
                                <p>Este es el dashboard institucional de SymphonySIAS.</p>
                                <%-- Aquí puedo agregar módulos, reportes, gráficos, etc --%>
                            </div>
                        </div>
                    </div>
                </section>                    
            </div>
                            
        </div>
                            
        <%-- Scripts --%>
        <jsp:include page="footer.jsp" />
    </body>
</html>
