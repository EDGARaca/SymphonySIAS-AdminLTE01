<%-- 
    Document   : menuProfesores
    Created on : 3/12/2025, 12:56:20 p. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="componentes/roles.jspf" %> <!-- Inclusión del fragmento de roles -->

<!-- Menú del módulo Profesores -->
<div class="row">

    <!-- Opciones exclusivas para Administrador -->
    <c:if test="${isAdmin}">
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
    </c:if>

    <!-- Opciones para Director y Coordinador -->
    <c:if test="${isDirector || isCoord}">
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
    </c:if>

    <!-- Opciones para Profesor (solo sus datos) -->
    <c:if test="${isProfesor}">
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
    </c:if>
</div>