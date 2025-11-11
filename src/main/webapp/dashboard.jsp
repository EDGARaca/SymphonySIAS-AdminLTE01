<%-- 
    Document   : dashboard
    Created on : 1/10/2025, 8:04:14 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="javax.servlet.http.HttpSession" %>

<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    rol = (rol != null) ? rol.trim().toLowerCase() : "";


    if (usuario == null || nombre == null || rol == null) {
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
        <jsp:include page="componentes/header.jsp" />

        <%-- Sidebar --%>
        <jsp:include page="componentes/sidebar.jsp" />

        <%-- Content Wrapper --%>
        <div class="content-wrapper">
            <h3 class="text-primary text-center mt-3">[DASHBOARD] Rol activo: <%= rol %></h3>            
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row align-items-center mb-3">
                        <div class="col-12 col-md-6 text-center mb-2">
                            <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" style="max-height:220px; border-radius:8px;">
                        </div>
                        <div class="col-12 col-md-6 text-center mb-2">
                            <img src="assets/adminlte/img/banda5.jpg" alt="Fotografía institucional" style="max-height:300px; border-radius:8px;">
                        </div>
                    </div>
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

                                <!-- ADMIN SIAS -->
                                <div class="col-md-3 mb-3">
                                    <% if ("administrador sias".equals(rol)) { %>
                                        <a href="AdministradorSIAS.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-tools"></i> AdministradorSIAS <br><small>(Administrador)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-tools"></i> AdministradorSIAS <br><small>(Administrador)</small>
                                        </a>
                                    <% } %>
                                    
                                    
                                    
                                </div>

                                <!-- Gestión Estudiantes -->
                                <div class="col-md-3 mb-3">
                                    <% if ("administrador sias".equals(rol) || "director".equals(rol) || "coordinador académico".equals(rol) || "auxiliar administrativo".equals(rol)) { %>
                                        <a href="estudiantes.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-user-graduate"></i> Gestión Estudiantes <br><small>(Roles autorizados)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-graduate"></i> Gestión Estudiantes <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Gestión Profesores -->
                                <div class="col-md-3 mb-3">
                                    <% if ("administrador sias".equals(rol) || "director".equals(rol) || "coordinador académico".equals(rol)) { %>
                                        <a href="profesores.jsp" class="btn btn-outline-warning btn-block">
                                            <i class="fas fa-chalkboard-teacher"></i> Gestión Profesores <br><small>(Director, Coordinador)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-chalkboard-teacher"></i> Gestión Profesores <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                    
                                </div>
                                    
                                <!-- Gestión Cursos Libres -->
                                <div class="col-md-3 mb-3">
                                    <% if ("administrador sias".equals(rol) || "coordinador académico".equals(rol)) { %>
                                        <a href="cursoLibre.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-book-reader"></i> Gestión Cursos Libres <br><small>(Administrador, Coordinador)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-book-reader"></i> Gestión Cursos Libres <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>    

                                <!-- Auxiliar Contable -->
                                <div class="col-md-3 mb-3">
                                    <% if ("auxiliar contable".equals(rol)) { %>
                                        <a href="gestionContable.jsp" class="btn btn-outline-dark btn-block">
                                            <i class="fas fa-calculator"></i> Auxiliar Contable <br><small>(Aux. Contable)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-calculator"></i> Auxiliar Contable <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Auxiliar Administrativo -->
                                <div class="col-md-3 mb-3">
                                    <% if ("auxiliar administrativo".equals(rol)) { %>
                                        <a href="gestionAdministrativo.jsp" class="btn btn-outline-secondary btn-block">
                                            <i class="fas fa-user-clock"></i> Auxiliar Administrativo <br><small>(Aux. Administrativo)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-clock"></i> Auxiliar Administrativo <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Clases y Horarios -->
                                <div class="col-md-3 mb-3">
                                    <% if ("docente".equals(rol) || "coordinador académico".equals(rol) || "director".equals(rol)) { %>
                                        <a href="gestionClases.jsp" class="btn btn-outline-info btn-block">
                                            <i class="fas fa-calendar-alt"></i> Clases y Horarios <br><small>(Docente, Coordinador, Director)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-calendar-alt"></i> Clases y Horarios <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Horarios (Estudiante) -->
                                <div class="col-md-3 mb-3">
                                    <% if ("estudiante".equals(rol)) { %>
                                        <a href="horarios.jsp" class="btn btn-outline-info btn-block">
                                            <i class="fas fa-clock"></i> Horarios <br><small>(Estudiante)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-clock"></i> Horarios <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Coordinador Académico -->
                                <div class="col-md-3 mb-3">
                                    <% if ("coordinador académico".equals(rol)) { %>
                                        <a href="gestionCoordinador.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-user-cog"></i> Coordinador Académico <br><small>(Coordinador)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-cog"></i> Coordinador Académico <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Gestión Director -->
                                <div class="col-md-3 mb-3">
                                    <% if ("director".equals(rol)) { %>
                                        <a href="gestionDirector.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-user-tie"></i> Gestión Director <br><small>(Director)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-tie"></i> Gestión Director <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>
                                
                                <!-- Contenidos -->
                                <div class="col-md-3 mb-3">
                                    <% if ("docente".equals(rol) || "estudiante".equals(rol)) { %>
                                        <a href="contenidos.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-book-reader"></i> Contenidos <br><small>(Docente, Estudiante)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-book-reader"></i> Contenidos <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Gestión de Notas -->
                                <div class="col-md-3 mb-3">
                                    <% if ("docente".equals(rol) || "estudiante".equals(rol) || "coordinador académico".equals(rol) || "director".equals(rol)) { %>
                                        <a href="gestionNotas.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-clipboard-list"></i> Gestión de Notas <br><small>(Docente, Estudiante, Coordinador, Director)</small>
                                        </a>
                                    <% } else { %>
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-clipboard-list"></i> Gestión de Notas <br><small>(No disponible)</small>
                                        </a>
                                    <% } %>
                                </div>

                                <!-- Notificaciones (todos los roles) -->
                                <div class="col-md-3 mb-3">
                                    <a href="notificaciones.jsp" class="btn btn-outline-danger btn-block">
                                        <i class="fas fa-bell"></i> Notificaciones <br><small>(Todos los roles)</small>
                                    </a>
                                </div>
                                
                                <!-- Productos Músicales -->
                                <div class="col-lg-3 col-6">
                                    <div class="small-box bg-info">
                                        <div class="inner">
                                            <h4>Productos Musicales</h4>
                                            <p>Compra instrumentos</p>
                                        </div>
                                        <div class="icon">
                                            <i class="fas fa-shopping-cart"></i>
                                        </div>
                                        <a href="catalogoProductos.jsp" class="small-box-footer">
                                            Ir al catálogo <i class="fas fa-arrow-circle-right"></i>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <%-- Scripts --%>
            <% if (!"administrador sias".equals(rol)) { %>
                <jsp:include page="componentes/chatbot.jspf" />
            <% } %>


            <jsp:include page="componentes/footer.jsp" />                                   
        </div>   
    </div>    
    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>