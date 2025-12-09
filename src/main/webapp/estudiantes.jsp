<%-- 
    Document   : estudiantes
    Created on : 22/10/2025, 9:17:08 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="componentes/roles.jspf" %>

<%
    // Validación de sesión con trazabilidad
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre  = (session != null) ? (String) session.getAttribute("nombreActivo")  : null;
    // Nota: el rol ya queda definido y normalizado en roles.jspf (no redeclarar aquí)

    if (usuario == null || nombre == null || session.getAttribute("rol") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    System.out.println("[ESTUDIANTES] Sesión activa: " + usuario + " (" + session.getAttribute("rol") + ")");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Estudiantes</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <jsp:include page="componentes/header.jsp" />
    <jsp:include page="componentes/sidebar.jsp" />

    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <h4 class="mb-3 text-primary">
                    <i class="fas fa-user-graduate"></i> Módulo Estudiantes
                </h4>
                <p class="text-muted">Accede a las funcionalidades del módulo estudiantes según tu rol institucional.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <!-- Listar: visible para todos los roles definidos -->
                    <div class="col-md-4 mb-3">
                        <a href="listarEstudiantes.jsp" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-list"></i> Listar Estudiantes
                        </a>
                    </div>

                    <!-- Buscar con filtro: admin, director, coordinador, auxadmin, profesor -->
                    <c:if test="${isAdmin or isDirector or isCoordinador or isAuxAdmin or isProfesor}">
                        <div class="col-md-4 mb-3">
                            <a href="buscarEstudiantes.jsp" class="btn btn-outline-info btn-block">
                                <i class="fas fa-filter"></i> Buscar con Filtro
                            </a>
                        </div>
                    </c:if>

                    <!-- Registrar: admin, director, coordinador, auxadmin -->
                    <c:if test="${isAdmin or isDirector or isCoordinador or isAuxAdmin}">
                        <div class="col-md-4 mb-3">
                            <a href="registroEstudiante.jsp" class="btn btn-outline-success btn-block">
                                <i class="fas fa-user-plus"></i> Registrar Estudiante
                            </a>
                        </div>
                    </c:if>

                    <!-- Exportar PDF: admin, director, coordinador -->
                    <c:if test="${isAdmin or isDirector or isCoordinador}">
                        <div class="col-md-4 mb-3">
                            <a href="ExportarEstudiantesServlet" class="btn btn-outline-danger btn-block">
                                <i class="fas fa-file-pdf"></i> Exportar PDF
                            </a>
                        </div>
                    </c:if>

                </div>
            </div>
        </section>

        <jsp:include page="componentes/footer.jsp" />
    </div>

</div>
</body>
</html>