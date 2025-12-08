<%-- 
    Document   : ChangePassword
    Created on : 14/10/2025, 11:14:20 a. m.
    Author     : Spiri
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

        <!-- Mensajes dinámicos -->
        <c:if test="${not empty mensaje}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${mensaje}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>

        <!-- Formulario -->
        <form action="CambiarClaveServlet" method="post" autocomplete="off">
            <div class="form-group">
                <label for="claveActual">Clave actual</label>
                <input type="password" id="claveActual" name="claveActual" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="claveNueva">Nueva clave</label>
                <input type="password" id="claveNueva" name="claveNueva" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="claveConfirmacion">Confirmar nueva clave</label>
                <input type="password" id="claveConfirmacion" name="claveConfirmacion" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success" aria-label="Actualizar clave">Actualizar clave</button>
            <a href="dashboard.jsp" class="btn btn-secondary ml-2" aria-label="Regresar al panel">
                <i class="fas fa-arrow-left"></i> Regresar al panel
            </a>
        </form>
    </div>
</body>
</html>