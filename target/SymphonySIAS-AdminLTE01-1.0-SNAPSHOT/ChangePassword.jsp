<%-- 
    Document   : ChangePassword
    Created on : 14/10/2025, 11:14:20 a. m.
    Author     : Spiri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="javax.servlet.http.HttpSession" %>

<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cambiar clave</title>
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
</head>
<body class="hold-transition layout-top-nav">
    <div class="container mt-5">
        <h3><i class="fas fa-key"></i> Cambiar clave</h3>
        <% if (request.getAttribute("mensaje") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> <%= request.getAttribute("mensaje") %>
            </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        <form action="CambiarClaveServlet" method="post">
            <div class="form-group">
                <label>Clave actual</label>
                <input type="password" name="claveActual" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Nueva clave</label>
                <input type="password" name="claveNueva" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Confirmar nueva clave</label>
                <input type="password" name="claveConfirmacion" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Actualizar clave</button>
            <a href="dashboard.jsp" class="btn btn-secondary ml-2">
                <i class="fas fa-arrow-left"></i> Regresar al panel
            </a>
        </form>
    </div>
</body>
</html>