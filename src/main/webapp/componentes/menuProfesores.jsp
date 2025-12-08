<%-- 
    Document   : menuProfesores
    Created on : 3/12/2025, 12:56:20 p. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Recuperar rol desde sesión y normalizar
    String rol = (String) session.getAttribute("rol");
    String rolN = (rol != null) ? rol.trim().toLowerCase() : "";
%>

<!-- Menú del módulo Profesores -->
<div class="row">

    <%-- Bloque Administrador SIAS --%>
    <% if ("administrador sias".equals(rolN)) { %>
        <div class="col-md-4 mb-3">
            <a href="listarProfesores.jsp" class="btn btn-outline-primary btn-block" title="Ver listado global de profesores">
                <i class="fas fa-list"></i> Listar Profesores
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="buscarProfesores.jsp" class="btn btn-outline-info btn-block" title="Buscar profesores con filtros">
                <i class="fas fa-filter"></i> Buscar con Filtro
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="registroProfesor.jsp" class="btn btn-outline-success btn-block" title="Registrar nuevo profesor">
                <i class="fas fa-user-plus"></i> Registrar Profesor
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="ExportarProfesoresServlet" class="btn btn-outline-danger btn-block" title="Exportar listado de profesores en PDF">
                <i class="fas fa-file-pdf"></i> Exportar PDF
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="CursoLibreServlet?accion=listarTodos" class="btn btn-outline-warning btn-block" title="Ver cursos libres por profesor">
                <i class="fas fa-book"></i> Cursos Libres por Profesor
            </a>
        </div>
    <% } %>

    <%-- Bloque Director / Coordinador académico --%>
    <% if ("director".equals(rolN) || "coordinador académico".equals(rolN)) { %>
        <div class="col-md-4 mb-3">
            <a href="CursoLibreServlet?accion=listarPorProfesor" class="btn btn-outline-warning btn-block" title="Ver cursos libres por profesor">
                <i class="fas fa-book"></i> Cursos por Profesor
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="EstudianteServlet?accion=listarPorProfesor" class="btn btn-outline-primary btn-block" title="Ver estudiantes inscritos por profesor">
                <i class="fas fa-users"></i> Estudiantes por Profesor
            </a>
        </div>
    <% } %>

    <%-- Bloque Profesor (solo acciones propias) --%>
    <% if ("profesor".equals(rolN)) { %>
        <div class="col-md-4 mb-3">
            <a href="CursoLibreServlet?accion=listarMisCursos" class="btn btn-outline-warning btn-block" title="Ver mis cursos libres">
                <i class="fas fa-book"></i> Mis Cursos Libres
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="EstudianteServlet?accion=listarMisEstudiantes" class="btn btn-outline-primary btn-block" title="Ver mis estudiantes inscritos">
                <i class="fas fa-users"></i> Estudiantes Inscritos
            </a>
        </div>
    <% } %>
</div>