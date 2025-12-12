<!-- 
    Document   : accionesProfesores
    Created on : 3/12/2025, 1:05:29 p. m.
    Author     : Spiri
--%>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.Profesor" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/componentes/roles.jspf" %> <!-- Inclusión del fragmento de roles -->

<%
    // Recuperar profesor actual desde request
    Profesor profesor = (Profesor) request.getAttribute("profesor");
    String estado = (profesor != null && profesor.getEstado() != null)
        ? profesor.getEstado().trim().toLowerCase()
        : "";
%>

<!-- Acciones disponibles según rol -->
<div class="acciones-profesor">

    <!-- Bloque para Admin, Director y Coordinador -->
    <c:if test="${isAdmin || isDirector || isCoord}">
        <!-- Ver cursos asignados -->
        <a href="CursoLibreServlet?accion=listarPorProfesor&id=${profesor.id}" class="btn btn-sm btn-info" title="Ver cursos asignados">
            <i class="fas fa-book"></i>
        </a>
        <!-- Ver estudiantes inscritos -->
        <a href="EstudianteServlet?accion=listarPorProfesor&id=${profesor.id}" class="btn btn-sm btn-primary" title="Ver estudiantes inscritos">
            <i class="fas fa-users"></i>
        </a>
        <!-- Editar profesor -->
        <a href="editarProfesor.jsp?id=${profesor.id}" class="btn btn-sm btn-warning" title="Editar profesor">
            <i class="fas fa-edit"></i>
        </a>

        <!-- Activar/Inactivar/Eliminar según estado -->
        <c:if test="${estado == 'inactivo'}">
            <a href="ProfesorServlet?accion=activar&id=${profesor.id}" class="btn btn-sm btn-success" title="Activar profesor"
               onclick="return confirm('¿Activar este profesor?');">
                <i class="fas fa-check-circle"></i>
            </a>
            <a href="ProfesorServlet?accion=eliminar&id=${profesor.id}" class="btn btn-sm btn-danger" title="Eliminar definitivamente"
               onclick="return confirm('⚠ ¿Está seguro de eliminar definitivamente este profesor?');">
                <i class="fas fa-trash-alt"></i>
            </a>
        </c:if>
        <c:if test="${estado != 'inactivo'}">
            <a href="ProfesorServlet?accion=inactivar&id=${profesor.id}" class="btn btn-sm btn-secondary" title="Inactivar profesor"
               onclick="return confirm('¿Marcar este profesor como inactivo?');">
                <i class="fas fa-ban"></i>
            </a>
        </c:if>
    </c:if>

    <!-- Bloque para rol Profesor (acciones limitadas) -->
    <c:if test="${isProfesor}">
        <a href="CursoLibreServlet?accion=listarPorProfesor&id=${profesor.id}" class="btn btn-sm btn-info" title="Ver cursos asignados">
            <i class="fas fa-book"></i>
        </a>
        <a href="EstudianteServlet?accion=listarPorProfesor&id=${profesor.id}" class="btn btn-sm btn-primary" title="Ver estudiantes inscritos">
            <i class="fas fa-users"></i>
        </a>
    </c:if>
</div>