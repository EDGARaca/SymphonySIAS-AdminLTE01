<%-- 
    Document   : layout
    Created on : 13/12/2025, 9:04:44 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="base" value="/SymphonySIAS-AdminLTE01-1.0-SNAPSHOT" />

<%-- Definir base para rutas --%>
<c:set var="base" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SymphonySIAS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

  <%-- CSS globales (orden recomendado: Bootstrap, FontAwesome, AdminLTE, custom) --%>
  <link rel="stylesheet" href="<c:url value='/assets/adminlte/css/bootstrap.min.css'/> ">
    <link rel="stylesheet" href="<c:url value='/assets/adminlte/plugins/fontawesome-free/css/all.min.css'/> ">
    <link rel="stylesheet" href="<c:url value='/assets/adminlte/css/adminlte.min.css'/> ">    
    <link rel="stylesheet" href="<c:url value='/assets/adminlte/css/custom.css'/> ">
    <link rel="stylesheet" href="<c:url value='/assets/adminlte/css/estilos.css'/> ">  
</head>


<body class="hold-transition sidebar-mini layout-fixed">
  <div class="wrapper">

    <!-- Header institucional -->
    <jsp:include page="/componentes/header.jsp" />

    <!-- Sidebar -->
    <jsp:include page="/componentes/sidebar.jsp" />

    <%-- Contenedor principal de contenido AdminLTE --%>
    <div class="content-wrapper">
      <%-- Aquí se inyecta la página que desees (dashboard.jsp en raíz de webapp) --%>
      <jsp:include page="/dashboard.jsp" />
    </div>

    <!-- Footer -->
    <jsp:include page="/componentes/footer.jsp" />
    
  </div> <%-- /.wrapper --%>
  
  <%-- Scripts globales (orden: jQuery, Bootstrap, AdminLTE) --%>
  <script src="<c:url value='/assets/adminlte/plugins/jquery/jquery.min.js'/> "></script>
  <script src="<c:url value='/assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js'/> "></script>
  <script src="<c:url value='/assets/adminlte/js/adminlte.min.js'/> "></script>
</body>
</html>