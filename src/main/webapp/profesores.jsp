<%-- 
    Document   : profesores
    Created on : 20/10/2025, 4:40:03 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="componentes/roles.jspf" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Profesores</title>
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
                    <i class="fas fa-chalkboard-teacher"></i> Módulo Profesores
                </h4>
                <p class="text-muted">Accede a las funcionalidades del módulo profesores según tu rol institucional.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <!-- Listar: todos los roles -->
                    <c:if test="${canList}">
                        <div class="col-md-4 mb-3">
                            <a href="listarProfesores.jsp" class="btn btn-outline-primary btn-block">
                                <i class="fas fa-list"></i> Listar Profesores
                            </a>
                        </div>
                    </c:if>

                    <!-- Buscar con filtro: admin/director/coordinador -->
                    <c:if test="${canFilter}">
                        <div class="col-md-4 mb-3">
                            <a href="buscarProfesores.jsp" class="btn btn-outline-info btn-block">
                                <i class="fas fa-filter"></i> Buscar con Filtro
                            </a>
                        </div>
                    </c:if>

                    <!-- Registrar: admin/director/coordinador -->
                    <c:if test="${canRegister}">
                        <div class="col-md-4 mb-3">
                            <a href="registroProfesor.jsp" class="btn btn-outline-success btn-block">
                                <i class="fas fa-user-plus"></i> Registrar Profesor
                            </a>
                        </div>
                    </c:if>

                    <!-- Exportar PDF: admin/director/coordinador -->
                    <c:if test="${canExport}">
                        <div class="col-md-4 mb-3">
                            <a href="ExportarProfesoresServlet" class="btn btn-outline-danger btn-block">
                                <i class="fas fa-file-pdf"></i> Exportar PDF
                            </a>
                        </div>
                    </c:if>

                    <!-- Accesos exclusivos de profesor -->
                    <c:if test="${isProfesor}">
                        <div class="col-md-4 mb-3">
                            <a href="CursoLibreServlet?accion=listarPorProfesor&id=${sessionScope.id_profesor}"
                               class="btn btn-outline-warning btn-block">
                                <i class="fas fa-book"></i> Mis Cursos Libres
                            </a>
                        </div>

                        <div class="col-md-4 mb-3">
                            <a href="EstudianteServlet?accion=listarPorProfesor&id=${sessionScope.id_profesor}"
                               class="btn btn-outline-info btn-block">
                                <i class="fas fa-users"></i> Estudiantes Inscritos
                            </a>
                        </div>
                    </c:if>

                </div>
            </div>
        </section>

        <jsp:include page="componentes/footer.jsp" />
    </div>

</div>

<!-- Scripts confiables -->
<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>

</body>
</html>