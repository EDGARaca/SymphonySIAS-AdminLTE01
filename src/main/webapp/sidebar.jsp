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
                <li class="nav-item">
                    <a href="UsuarioServlet" class="nav-link">
                        <i class="nav-icon fas fa-users"></i>
                        <p>Gestión de Usuarios</p>
                    </a>
                </li>
                
                <%-- Más módulos --%>
                
                <li class="nav-item">
                    <a href="ReporterServlet" class="nav-link">
                        <i class="nav-icon fas fa-home"></i>
                        <p>Gestion Estudiantes</p>
                    </a>
                </li>
                    
                <li class="nav-item">
                    <a href="ChatbotServlet" class="nav-link">
                        <i class="nav-icon fas fa-robot"></i>
                        <p>Gestion Profesores</p>
                    </a>
                </li>
                                              
            </ul>
        </nav>
    </div>
</aside>


