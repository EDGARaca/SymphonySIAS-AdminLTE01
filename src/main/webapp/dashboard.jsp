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
                        <div class="row align-items-center mb-3">
                            <div class="col-12 col-md-6 text-center mb-2">
                                <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" style="max-height:220px;">
                            </div>
                            <div class="col-12 col-md-6 text-center mb-2">
                                <img src="assets/adminlte/img/banda5.jpg" alt="Fotografía institucional" style="max-height:300px; border-radius:8px;">
                            </div>
                        </div>

                        <div class="text-center mb-4 px-3">
                            <h5 class="text-primary text-wrap">
                                <i class="fas fa-music"></i> ¡Somos una Escuela de Música que te ayuda a impulsar tu desarrollo musical!
                            </h5>
                        </div>
                        <h5 class="m-0">Bienvenido, <strong><%= nombre %></strong> (<%= rol %>)</h5>
                        <p class="text-muted">Sistema de información estudiantil SymphonySIAS</p>
                        <p>Usuario activo: <%= usuario %></p>

                        <% if ("administrador".equals(rol)) { %>
                            <div class="alert alert-info mt-2">
                                <i class="fas fa-user-shield"></i> Acceso completo como <strong>Administrador</strong>. Puedes gestionar usuarios, clases, contenidos y reportes.
                            </div>
                        <% } %>
                    </div>
                </section>
                    
                <section class="content">
                    <div class="container-fluid px-3">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><i class="fas fa-school"></i> Accesos a módulos institucionales</h3>
                            </div>
                            <div class="card-body">                             
                                <div class="row text-center">
                                    <div class="col-12 col-sm-6 col-md-3 mb-3">
                                        <a href="adminSias.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-tools"></i> ADMIN SIAS
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="gestionEstudiantes.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-user-graduate"></i> Gestión Estudiantes
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="gestionProfesores.jsp" class="btn btn-outline-warning btn-block">
                                            <i class="fas fa-chalkboard-teacher"></i> Gestión Profesores
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="gestionContable.jsp" class="btn btn-outline-dark btn-block">
                                            <i class="fas fa-calculator"></i> Auxiliar Contable
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="gestionAdministrativo.jsp" class="btn btn-outline-secondary btn-block">
                                            <i class="fas fa-user-clock"></i> Auxiliar Administrativo
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="gestionClases.jsp" class="btn btn-outline-info btn-block">
                                            <i class="fas fa-calendar-alt"></i> Clases y Horarios
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="gestionCoordinador.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-user-cog"></i> Coordinador Académico
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="gestionDirector.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-user-tie"></i> Gestión Director
                                        </a>
                                    </div>
                                </div>
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
