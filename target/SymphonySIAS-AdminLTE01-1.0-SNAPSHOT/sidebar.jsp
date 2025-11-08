<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    // Validación de sesión (ya debe estar activa desde header.jsp
    String rol= (session != null) ? (String) session.getAttribute("rolActivo") : null;
%>

<%-- Menú lateral --%>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <%-- Logo --%>
    <a href="dashboard.jsp" class="brand-link">
        <span class="brand-text font-weight-light">SymphonySIAS</span>
    </a>
    <%-- Menú Lateral --%>
    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">                
                <%-- Gestión de Usuarios: solo para administrador SIAS --%>
                <% if ("administrador".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="UsuarioServlet" class="nav-link">
                            <i class="nav-icon fas fa-users"></i>
                            <p>Gestión de Usuarios</p>
                        </a>
                    </li>
                <% } %>

                <%-- Gestión Estudiantes: visible para director, coordinador académico, auxiliar administrativo --%>
                <% if ("director".equals(rol) || "coordinador académico".equals(rol) || "auxiliar administrativo".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="ReporterServlet" class="nav-link">
                            <i class="nav-icon fas fa-home"></i>
                            <p>Gestión Estudiantes</p>
                        </a>
                    </li>
                <% } %>

                <%-- Gestión Profesores: visible para director, coordinador académico --%>
                <% if ("director".equals(rol) || "coordinador académico".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="ChatbotServlet" class="nav-link">
                            <i class="nav-icon fas fa-robot"></i>
                            <p>Gestión Profesores</p>
                        </a>
                    </li>
                <% } %>
                
                <%-- Clases y contenidos: para docente, coordinador académico y director --%>
                <% if ("docente".equals(rol) || "coordinador académico".equals(rol) || "director".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="clases.jsp" class="nav-link">
                            <i class="fas fa-chalkboard"></i>
                            <p>Mis Clases</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="contenidos.jsp" class="nav-link">
                            <i class="fas fa-book"></i>
                            <p>Contenidos</p>
                        </a>
                    </li>
                <% } %>

                <%-- Reportes contables: solo para auxiliar contable --%>
                <% if ("auxiliar contable".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="reportesContables.jsp" class="nav-link">
                            <i class="fas fa-file-invoice-dollar"></i>
                            <p>Reportes Contables</p>
                        </a>
                    </li>
                <% } %>
                
                <% if ("auxiliar administrativo".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="ReporterServlet" class="nav-link">
                            <i class="fas fa-user-friends"></i>
                            <p>Gestión Estudiantes</p>
                        </a>
                    </li>
                <% } %>
                
                <% if ("estudiante".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="contenidos.jsp" class="nav-link">
                            <i class="fas fa-book-reader"></i>
                            <p>Contenidos</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="horarios.jsp" class="nav-link">
                            <i class="fas fa-calendar-alt"></i>
                            <p>Horarios</p>
                        </a>
                    </li>
                <% } %>
                
                

                <%-- Notificaciones: para todos los roles --%>
                <li class="nav-item">
                    <a href="notificaciones.jsp" class="nav-link">
                        <i class="fas fa-bell"></i>
                        <p>Notificaciones</p>
                    </a>
                </li>
                                              
            </ul>
        </nav>
    </div>
</aside>


