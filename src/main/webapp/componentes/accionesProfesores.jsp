<%-- 
    Document   : accionesProfesores
    Created on : 3/12/2025, 1:05:29 p. m.
    Author     : Spiri
--%>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.Profesor" %>

<%
    // Recuperar rol desde sesión y normalizar
    String rol = (String) session.getAttribute("rol");
    String rolN = (rol != null) ? rol.trim().toLowerCase() : "";

    // Recuperar profesor actual
    Profesor profesor = (Profesor) request.getAttribute("profesor");
    String estado = (profesor != null && profesor.getEstado() != null) 
                    ? profesor.getEstado().trim().toLowerCase() 
                    : "";
%>

<!-- Acciones disponibles según rol -->
<div class="acciones-profesor">

    <%-- Acciones para AdminSIAS, Director y Coordinador Académico --%>
    <% if ("administrador sias".equals(rolN) 
            || "director".equals(rolN) 
            || "coordinador académico".equals(rolN)) { %>

        <!-- Ver cursos asignados -->
        <a href="CursoLibreServlet?accion=listarPorProfesor&id=<%= profesor.getId() %>" 
           class="btn btn-sm btn-info" title="Ver cursos asignados">
            <i class="fas fa-book"></i>
        </a>

        <!-- Ver estudiantes inscritos -->
        <a href="EstudianteServlet?accion=listarPorProfesor&id=<%= profesor.getId() %>" 
           class="btn btn-sm btn-primary" title="Ver estudiantes inscritos">
            <i class="fas fa-users"></i>
        </a>

        <!-- Editar profesor -->
        <a href="editarProfesor.jsp?id=<%= profesor.getId() %>" 
           class="btn btn-sm btn-warning" title="Editar profesor">
            <i class="fas fa-edit"></i>
        </a>

        <% if ("inactivo".equals(estado)) { %>
            <!-- Activar profesor -->
            <a href="ProfesorServlet?accion=activar&id=<%= profesor.getId() %>" 
               class="btn btn-sm btn-success" title="Activar profesor"
               onclick="return confirm('¿Activar este profesor?');">
                <i class="fas fa-check-circle"></i>
            </a>

            <!-- Eliminar definitivamente -->
            <a href="ProfesorServlet?accion=eliminar&id=<%= profesor.getId() %>" 
               class="btn btn-sm btn-danger" title="Eliminar definitivamente"
               onclick="return confirm('⚠ ¿Está seguro de eliminar definitivamente este profesor?');">
                <i class="fas fa-trash-alt"></i>
            </a>
        <% } else { %>
            <!-- Inactivar profesor -->
            <a href="ProfesorServlet?accion=inactivar&id=<%= profesor.getId() %>" 
               class="btn btn-sm btn-secondary" title="Inactivar profesor"
               onclick="return confirm('¿Marcar este profesor como inactivo?');">
                <i class="fas fa-ban"></i>
            </a>
        <% } %>
    <% } %>

    <%-- Acciones para rol Profesor (limitadas) --%>
    <% if ("profesor".equals(rolN)) { %>
        <!-- Ver cursos asignados -->
        <a href="CursoLibreServlet?accion=listarPorProfesor&id=<%= profesor.getId() %>" 
           class="btn btn-sm btn-info" title="Ver cursos asignados">
            <i class="fas fa-book"></i>
        </a>

        <!-- Ver estudiantes inscritos -->
        <a href="EstudianteServlet?accion=listarPorProfesor&id=<%= profesor.getId() %>" 
           class="btn btn-sm btn-primary" title="Ver estudiantes inscritos">
            <i class="fas fa-users"></i>
        </a>
    <% } %>
</div>