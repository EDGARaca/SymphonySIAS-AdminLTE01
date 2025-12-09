<%-- 
    Document   : dashboard
    Created on : 1/10/2025, 8:04:14 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="componentes/roles.jspf" %>

<%
    // Validación de sesión con trazabilidad (rol se define en roles.jspf, no redeclarar aquí)
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre  = (session != null) ? (String) session.getAttribute("nombreActivo")  : null;

    if (usuario == null || nombre == null || session.getAttribute("rol") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    System.out.println("[DASHBOARD] Sesión activa: " + usuario + " (" + session.getAttribute("rol") + ")");
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

                                <!-- Administrador SIAS -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isAdmin}">
                                        <a href="AdministradorSIAS.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-tools"></i> AdministradorSIAS <br><small>(Administrador)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!isAdmin}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-tools"></i> AdministradorSIAS <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Gestión Estudiantes -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isAdmin or isDirector or isCoordinador or isAuxAdmin or isProfesor or isEstudiante}">
                                        <a href="estudiantes.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-user-graduate"></i> Gestión Estudiantes <br><small>(Roles autorizados)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isAdmin or isDirector or isCoordinador or isAuxAdmin or isProfesor or isEstudiante)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-graduate"></i> Gestión Estudiantes <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Gestión Profesores -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isAdmin or isDirector or isCoordinador or isProfesor}">
                                        <a href="ProfesorServlet?accion=vista" class="btn btn-outline-warning btn-block">
                                            <i class="fas fa-chalkboard-teacher"></i> Gestión Profesores <br><small>(Admin, Director, Coordinador, Profesor)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isAdmin or isDirector or isCoordinador or isProfesor)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-chalkboard-teacher"></i> Gestión Profesores <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Gestión Cursos Libres -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isAdmin or isCoordinador or isProfesor or isEstudiante}">
                                        <a href="cursoLibre.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-book-reader"></i> Gestión Cursos Libres <br><small>(Administrador, Coordinador)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isAdmin or isCoordinador or isProfesor or isEstudiante)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-book-reader"></i> Gestión Cursos Libres <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Auxiliar Contable -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isAuxCont or isAdmin}">
                                        <a href="gestionContable.jsp" class="btn btn-outline-dark btn-block">
                                            <i class="fas fa-calculator"></i> Auxiliar Contable <br><small>(Aux. Contable)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isAuxCont or isAdmin)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-calculator"></i> Auxiliar Contable <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Auxiliar Administrativo -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isAuxAdmin or isAdmin}">
                                        <a href="gestionAdministrativo.jsp" class="btn btn-outline-secondary btn-block">
                                            <i class="fas fa-user-clock"></i> Auxiliar Administrativo <br><small>(Aux. Administrativo)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isAuxAdmin or isAdmin)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-clock"></i> Auxiliar Administrativo <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Clases y Horarios -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isProfesor or isAdmin or isCoordinador or isDirector or isEstudiante}">
                                        <a href="gestionClases.jsp" class="btn btn-outline-info btn-block">
                                            <i class="fas fa-calendar-alt"></i> Clases y Horarios <br><small>(Profesor, Coordinador, Director)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isProfesor or isAdmin or isCoordinador or isDirector or isEstudiante)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-calendar-alt"></i> Clases y Horarios <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Horarios -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isEstudiante or isAdmin or isProfesor}">
                                        <a href="horarios.jsp" class="btn btn-outline-info btn-block">
                                            <i class="fas fa-clock"></i> Horarios <br><small>(Estudiante)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isEstudiante or isAdmin or isProfesor)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-clock"></i> Horarios <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Coordinador Académico -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isCoordinador or isAdmin}">
                                        <a href="gestionCoordinador.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-user-cog"></i> Coordinador Académico <br><small>(Coordinador)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isCoordinador or isAdmin)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-cog"></i> Coordinador Académico <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Gestión Director -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isDirector or isAdmin}">
                                        <a href="gestionDirector.jsp" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-user-tie"></i> Gestión Director <br><small>(Director)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isDirector or isAdmin)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-user-tie"></i> Gestión Director <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Contenidos -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isProfesor or isAdmin or isEstudiante}">
                                        <a href="contenidos.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-book-reader"></i> Contenidos <br><small>(Profesor, Estudiante)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isProfesor or isAdmin or isEstudiante)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-book-reader"></i> Contenidos <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Gestión de Notas -->
                                <div class="col-md-3 mb-3">
                                    <c:if test="${isProfesor or isAdmin or isEstudiante or isCoordinador or isDirector}">
                                        <a href="gestionNotas.jsp" class="btn btn-outline-success btn-block">
                                            <i class="fas fa-clipboard-list"></i> Gestión de Notas <br><small>(Profesor, Estudiante, Coordinador, Director)</small>
                                        </a>
                                    </c:if>
                                    <c:if test="${!(isProfesor or isAdmin or isEstudiante or isCoordinador or isDirector)}">
                                        <a href="#" class="btn btn-outline-secondary btn-block disabled" style="pointer-events: none;">
                                            <i class="fas fa-clipboard-list"></i> Gestión de Notas <br><small>(No disponible)</small>
                                        </a>
                                    </c:if>
                                </div>

                                <!-- Notificaciones (todos los roles) -->
                                <div class="col-md-3 mb-3">
                                    <a href="notificaciones.jsp" class="btn btn-outline-danger btn-block">
                                        <i class="fas fa-bell"></i> Notificaciones <br><small>(Todos los roles)</small>
                                    </a>
                                </div>

                                <!-- Productos Musicales -->
                                <div class="col-md-3 mb-3">
                                    <a href="catalogoProductos.jsp" class="btn btn-outline-info btn-block">
                                        <i class="fas fa-shopping-cart fa-lg"></i> Productos Musicales <br><small>Compra instrumentos</small>
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <%-- Scripts y componentes opcionales --%>
            <c:if test="${!isAdmin}">
                <jsp:include page="componentes/chatbot.jspf" />
            </c:if>

            <jsp:include page="componentes/footer.jsp" />
        </div>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>