<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="dashboard.jsp" class="brand-link">
        <span class="brand-text font-weight-light">SymphonySIAS</span>
    </a>

    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu">

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
                        <a href="usuarios.jsp" class="nav-link">
                            <i class="nav-icon fas fa-users"></i>
                            <p>Gestión de Usuarios</p>
                        </a>
                    </li>
                <% } %>


                <%-- 1. AdministradorSIAS --%>
                <% if ("administrador".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="auditoria.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-shield"></i>
                            <p>AdministradorSIAS</p>
                        </a>
                    </li>
                <% } %>

                <%-- 2. Gestión Estudiantes --%>
                <% if ("administrador".equals(rol) || "director".equals(rol) || "coordinador académico".equals(rol) || "auxiliar administrativo".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="estudiantes.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-graduate"></i>
                            <p>Gestión Estudiantes</p>
                        </a>
                    </li>
                <% } %>

                <%-- 3. Gestión Profesores --%>
                <% if ("administrador".equals(rol) || "director".equals(rol) || "coordinador académico".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="profesores.jsp" class="nav-link">
                            <i class="nav-icon fas fa-chalkboard-teacher"></i>
                            <p>Gestión Profesores</p>
                        </a>
                    </li>
                <% } %>

                <%-- 4. Gestión Auxiliar Contable --%>
                <% if ("administrador".equals(rol) || "auxiliar contable".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="reportesContables.jsp" class="nav-link">
                            <i class="nav-icon fas fa-file-invoice-dollar"></i>
                            <p>Gestión Auxiliar Contable</p>
                        </a>
                    </li>
                <% } %>

                <%-- 5. Gestión Auxiliar Administrativo --%>
                <% if ("administrador".equals(rol) || "auxiliar administrativo".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="ReporterServlet" class="nav-link">
                            <i class="nav-icon fas fa-file-export"></i>
                            <p>Gestión Auxiliar Administrativo</p>
                        </a>
                    </li>
                <% } %>

                <%-- 6. Gestión Director --%>
                <% if ("administrador".equals(rol) || "director".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="director.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-tie"></i>
                            <p>Gestión Director</p>
                        </a>
                    </li>
                <% } %>

                <%-- 7. Gestión Coordinador Académico --%>
                <% if ("administrador".equals(rol) || "coordinador académico".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="coordinador.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-cog"></i>
                            <p>Gestión Coordinador Académico</p>
                        </a>
                    </li>
                <% } %>

                <%-- 8. Gestión Cursos Libres --%>
                <% if ("administrador".equals(rol) || "coordinador académico".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="cursoLibre.jsp" class="nav-link">
                            <i class="nav-icon fas fa-book-reader"></i>
                            <p>Gestión Cursos Libres</p>
                        </a>
                    </li>
                <% } %>

                <%-- 9. Gestión de Horarios --%>
                <% if ("administrador".equals(rol) || "estudiante".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="horarios.jsp" class="nav-link">
                            <i class="nav-icon fas fa-calendar-alt"></i>
                            <p>Gestión de Horarios</p>
                        </a>
                    </li>
                <% } %>

                <%-- 10. Gestión de Notas --%>
                <% if ("administrador".equals(rol) || "docente".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="notas.jsp" class="nav-link">
                            <i class="nav-icon fas fa-clipboard-list"></i>
                            <p>Gestión de Notas</p>
                        </a>
                    </li>
                <% } %>

                <%-- 11. Autenticación, Usuarios y Roles --%>
                <% if ("administrador".equals(rol)) { %>
                    <li class="nav-item">
                        <a href="UsuarioServlet" class="nav-link">
                            <i class="nav-icon fas fa-users-cog"></i>
                            <p>Usuarios y Roles</p>
                        </a>
                    </li>
                <% } %>

                <%-- 12. Notificaciones --%>
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