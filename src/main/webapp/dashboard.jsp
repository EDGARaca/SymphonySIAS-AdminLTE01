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
        <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
        <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">       
    </head>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">
            
            <%-- Navbar --%>
            <jsp:include page="header.jsp" />
            
            <%-- Sidebar --%>
            <jsp:include page="sidebar.jsp" />
            
            <%-- Content Wrapper --%>
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
                                <%
                                    switch (rol) {
                                        case "admin":
                                %>
                                            <div class="alert alert-info">
                                                <i class="fas fa-user-shield"></i> Acceso completo como <strong>Administrador</strong>. Puedes gestionar usuarios, clases, contenidos y reportes.
                                            </div>
                                <%
                                            break;
                                        case "docente":
                                %>
                                            <div class="alert alert-warning">
                                                <i class="fas fa-chalkboard-teacher"></i> Acceso como <strong>Docente</strong>. Puedes visualizar tus clases, contenidos asignados y notificaciones.
                                            </div>
                                <%
                                            break;
                                        case "estudiante":
                                %>
                                            <div class="alert alert-success">
                                                <i class="fas fa-user-graduate"></i> Acceso como <strong>Estudiante</strong>. Puedes consultar tus horarios, contenidos y mensajes institucionales.
                                            </div>
                                <%
                                            break;
                                        case "funcionario":
                                %>
                                            <div class="alert alert-secondary">
                                                <i class="fas fa-briefcase"></i> Acceso como <strong>Funcionario</strong>. Puedes revisar reportes administrativos y notificaciones internas.
                                            </div>
                                <%
                                            break;
                                        default:
                                %>
                                            <div class="alert alert-danger">
                                                <i class="fas fa-exclamation-triangle"></i> Rol no reconocido. Contacta al administrador del sistema.
                                            </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </section>                    
            </div>                        
        </div>
                            
        <%-- Scripts --%>
        <jsp:include page="footer.jsp" />
                
        <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
        <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/adminlte/js/adminlte.min.js"></script> 
    
    </body>
</html>
