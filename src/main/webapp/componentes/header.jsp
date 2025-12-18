<%-- 
    Document   : header.jsp
    Created on : 4/10/2025, 8:38:48 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/componentes/roles.jspf" %>


<nav class="main-header navbar navbar-expand navbar-white navbar-light" aria-label="Barra de navegación">
  <ul class="navbar-nav">
    <%-- Botón para alternar el menú lateral (sidebar) --%>
    <li class="nav-item">
      <a class="nav-link" data-widget="pushmenu" href="#" aria-label="Alternar menú lateral">
        <i class="fas fa-bars"></i>
      </a>
    </li>

    <%-- Logo e identidad institucional (lado izquierdo) --%>
    <li class="nav-item d-none d-sm-inline-block">
      <a class="navbar-brand d-flex align-items-center" href="<c:url value='/index.jsp'/>">
        <img src="<c:url value='/assets/adminlte/img/LogoSymphonySIAS.png'/>"
             alt="Logo SymphonySIAS" class="mr-2" style="height:32px; width:auto;">
        <span class="brand-text font-weight-normal">SymphonySIAS</span>
      </a>
        <a href="<c:url value='/dashboard.jsp'/>" class="nav-link"><h5>Inicio</h5></a>
    </li>
  </ul>
    
    <!-- Información de bienvenida -->
    <%-- Lado derecho del navbar: usuario activo y acciones rápidas --%>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item d-flex align-items-center">
        
      <span class="nav-link" aria-label="Usuario activo">
        <h5 class="m-0">Bienvenido, <i class="fas fa-user-circle mr-2"></i>
        <strong><c:out value="${sessionScope.nombreActivo}" default="Usuario"/></strong>
        <small class="text-muted">(<c:out value="${sessionScope.rol}" default="Sin rol"/>)</small></h5>
      </span>
    </li>

    <li class="nav-item">
      <a class="nav-link text-danger" href="${base}/LoginServlet?action=logout" aria-label="Cerrar sesión">
        <i class="fas fa-sign-out-alt"></i> Salir
      </a>
    </li>
  </ul>
</nav>

<%-- 
  Nota: Las alertas dinámicas por rol se mueven a dashboard.jsp dentro de content-wrapper 
  para que reciban el estilo correcto de AdminLTE (ver sección siguiente).
--%>
