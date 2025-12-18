<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <%-- Brand / logo --%>
    <a href="<c:url value='/'/>" class="brand-link">
        <img src="${base}/assets/img/logo.png" alt="Logo SymphonySIAS" class="brand-image img-circle elevation-3" style="opacity:.8">
        <span class="brand-text font-weight-light">SymphonySIAS</span>
    </a>
        
    <%-- Sidebar content --%>
    <div class="sidebar">
        <%-- User panel opcional --%>
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
          <div class="info">
            <a href="#" class="d-block">
              <c:out value="${nombreActivo}" default="Usuario" /> (<c:out value="${rol}" default="Sin rol" />)
            </a>
          </div>
        </div>       
        
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" aria-label="Menú lateral SymphonySIAS">

                <!-- Panel Principal -->
                <li class="nav-header">Panel Principal</li>
                <li class="nav-item">
                    <a href="dashboard.jsp" class="nav-link <c:if test='${page eq "dashboard"}'>active</c:if>">
                        <i class="nav-icon fas fa-th-large"></i>
                        <p>Dashboard Institucional</p>
                    </a>
                </li>

                <!-- Módulos Institucionales -->
                <li class="nav-header">Módulos Institucionales</li>

                <!-- Gestión de Usuarios (solo Admin) -->
                <c:if test="${isAdmin}">
                    <li class="nav-item">
                        <a href="usuarios.jsp" class="nav-link">
                            <i class="nav-icon fas fa-users"></i>
                            <p>Gestión de Usuarios</p>
                        </a>
                    </li>
                </c:if>

                <!-- Administrador SIAS -->
                <c:if test="${isAdmin}">
                    <li class="nav-item">
                        <a href="AdministradorSIAS.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-shield"></i>
                            <p>AdministradorSIAS</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión Estudiantes -->
                <c:if test="${isAdmin or isDirector or isCoordinador or isAuxAdmin or isEstudiante or isProfesor}">
                    <li class="nav-item">
                        <a href="estudiantes.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-graduate"></i>
                            <p>Gestión Estudiantes</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión Profesores -->
                <c:if test="${isAdmin or isDirector or isCoordinador or isProfesor}">
                    <li class="nav-item">
                        <a href="ProfesorServlet?accion=vista" class="nav-link">
                            <i class="nav-icon fas fa-chalkboard-teacher"></i>
                            <p>Gestión Profesores</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión Auxiliar Contable -->
                <c:if test="${isAdmin or isAuxCont}">
                    <li class="nav-item">
                        <a href="reportesContables.jsp" class="nav-link">
                            <i class="nav-icon fas fa-file-invoice-dollar"></i>
                            <p>Gestión Auxiliar Contable</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión Auxiliar Administrativo -->
                <c:if test="${isAdmin or isAuxAdmin}">
                    <li class="nav-item">
                        <a href="ReporterServlet" class="nav-link">
                            <i class="nav-icon fas fa-file-export"></i>
                            <p>Gestión Auxiliar Administrativo</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión Director -->
                <c:if test="${isAdmin or isDirector}">
                    <li class="nav-item">
                        <a href="director.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-tie"></i>
                            <p>Gestión Director</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión Coordinador Académico -->
                <c:if test="${isAdmin or isCoordinador}">
                    <li class="nav-item">
                        <a href="coordinador.jsp" class="nav-link">
                            <i class="nav-icon fas fa-user-cog"></i>
                            <p>Gestión Coordinador Académico</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión Cursos Libres -->
                <c:if test="${isAdmin or isProfesor or isCoordinador or isEstudiante}">
                    <li class="nav-item">
                        <a href="cursoLibre.jsp" class="nav-link">
                            <i class="nav-icon fas fa-book-reader"></i>
                            <p>Gestión Cursos Libres</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión de Horarios -->
                <c:if test="${isAdmin or isProfesor or isEstudiante}">
                    <li class="nav-item">
                        <a href="horarios.jsp" class="nav-link">
                            <i class="nav-icon fas fa-calendar-alt"></i>
                            <p>Gestión de Horarios</p>
                        </a>
                    </li>
                </c:if>

                <!-- Gestión de Notas -->
                <c:if test="${isAdmin or isProfesor or isEstudiante}">
                    <li class="nav-item">
                        <a href="notas.jsp" class="nav-link">
                            <i class="nav-icon fas fa-clipboard-list"></i>
                            <p>Gestión de Notas</p>
                        </a>
                    </li>
                </c:if>

                <!-- Productos Musicales (visible para todos) -->
                <li class="nav-item">
                    <a href="catalogoProductos.jsp" class="nav-link">
                        <i class="nav-icon fas fa-shopping-cart"></i>
                        <p>Productos Musicales</p>
                    </a>
                </li>

                <!-- Usuarios y Roles (solo Admin) -->
                <c:if test="${isAdmin}">
                    <li class="nav-item">
                        <a href="UsuarioServlet" class="nav-link">
                            <i class="nav-icon fas fa-users-cog"></i>
                            <p>Usuarios y Roles</p>
                        </a>
                    </li>
                </c:if>

                <!-- Notificaciones (visible para todos) -->
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