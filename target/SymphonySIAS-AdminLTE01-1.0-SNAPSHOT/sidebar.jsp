<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    // Validación de sesión (ya debe estar activa desde header.jsp
    String rol= (session != null) ? (String) session.getAttribute("rolActivo") : null;
%>

<%-- Menú lateral --%>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="dashboard.jsp" class="brand-link">
        <span class="brand-text font-weight-light">SymphonySIAS</span>
    </a>
    
    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column">
                
                <li class="nav-item">
                    <a href="dashboard.jsp" class="nav-link active">
                        <i class="nav-icon fas fa-home"></i>
                        <p>Inicio</p>
                    </a>
                </li>
                    
                <li class="nav-item">
                    <a href="ReporterServlet" class="nav-link">
                        <i class="nav-icon fas fa-home"></i>
                        <p>Resportes Institucionales</p>
                    </a>
                </li>
                    
                <li class="nav-item">
                    <a href="ChatbotServlet" class="nav-link">
                        <i class="nav-icon fas fa-robot"></i>
                        <p>Chatbot SymphonySIAS</p>
                    </a>
                </li>
                
                <% if ("ADMIN".equals(rol)) { %>
                <li class="nav-item">
                    <a href="UsuariosServlet" class="nav-link">
                        <i class="nav-icon fas fa-user-cog"></i>
                        <p>Gestión de Usuarios</p>
                    </a>
                </li>
                <% } %>
                
            </ul>
        </nav>
    </div>
</aside>


