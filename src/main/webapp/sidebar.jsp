<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    // Validación de sesión
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Logo -->
    <a href="dashboard.jsp" class="brand-link">
        <span class="brand-text font-weight-light">SymphonySIAS</span>
    </a>

    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <!-- Panel Principal -->
                <li class="nav-header">Panel Principal</li>
                <li class="nav-item">
                    <a href="dashboard.jsp" class="nav-link">
                        <i class="nav-icon fas fa-th-large"></i>
                        <p>Dashboard Institucional</p>
                    </a>
                </li>

                <!-- Módulos Institucionales -->
                <li class="nav-header">Módulos Institucionales</li>

                <% if ("administrador".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="UsuarioServlet" class="nav-link">
                            <i class="nav-icon fas fa-users"></i>
                            <p>Gestión de Usuarios</p>
                        </a>
                    </li>
                <% } %>
                
                <% if ("administrador".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="listarEstudiantes.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-graduate"></i>
                            <p>Gestión Estudiantes</p>
                        </a>
                    </li>
                <% } %>

                <% if ("director".equals(rol) || "coordinador académico".equals(rol) || "auxiliar administrativo".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="ReporterServlet" class="nav-link">
                            <i class="nav-icon fas fa-user-graduate"></i>
                            <p>Gestión Estudiantes</p>
                        </a>
                    </li>
                <% } %>

                <% if ("director".equals(rol) || "coordinador académico".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="ChatbotServlet" class="nav-link">
                            <i class="nav-icon fas fa-robot"></i>
                            <p>Gestión Profesores</p>
                        </a>
                    </li>
                <% } %>

                <% if ("docente".equals(rol) || "coordinador académico".equals(rol) || "director".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="clases.jsp" class="nav-link">
                            <i class="nav-icon fas fa-chalkboard-teacher"></i>
                            <p>Mis Clases</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="contenidos.jsp" class="nav-link">
                            <i class="nav-icon fas fa-book"></i>
                            <p>Contenidos</p>
                        </a>
                    </li>
                <% } %>

                <% if ("auxiliar contable".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="reportesContables.jsp" class="nav-link">
                            <i class="nav-icon fas fa-file-invoice-dollar"></i>
                            <p>Reportes Contables</p>
                        </a>
                    </li>
                <% } %>

                <% if ("estudiante".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="contenidos.jsp" class="nav-link">
                            <i class="nav-icon fas fa-book-reader"></i>
                            <p>Contenidos</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="horarios.jsp" class="nav-link">
                            <i class="nav-icon fas fa-calendar-alt"></i>
                            <p>Horarios</p>
                        </a>
                    </li>
                <% } %>

                <!-- Notificaciones -->
                <li class="nav-item">
                    <a href="notificaciones.jsp" class="nav-link">
                        <i class="nav-icon fas fa-bell"></i>
                        <p>Notificaciones</p>
                    </a>
                </li>

                <!-- Acciones rápidas -->
                <li class="nav-header">Acciones</li>
                <li class="nav-item">
                    <a href="ChangePassword.jsp" class="nav-link">
                        <i class="nav-icon fas fa-key text-success"></i>
                        <p>Cambiar Contraseña</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="LogoutServlet" class="nav-link">
                        <i class="nav-icon fas fa-power-off text-danger"></i>
                        <p>Cerrar Sesión</p>
                    </a>
                </li>

            </ul>
        </nav>
    </div>
</aside>