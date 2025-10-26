<%-- 
    Document   : editarEstudiante
    Created on : 16/10/2025, 9:35:20 p. m.
    Author     : Spiri
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Profesor"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.ProfesorDAO"%>

<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null ||
        !(rol.equals("administrador") || rol.equals("coordinador académico") || rol.equals("director"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Obtener ID del profesor
    String idStr = request.getParameter("id");
    int id = (idStr != null) ? Integer.parseInt(idStr) : 0;

    ProfesorDAO dao = new ProfesorDAO();
    Profesor prof = dao.buscarPorId(id);

    if (prof == null) {
        response.sendRedirect("listarProfesores.jsp?error=notfound");
        return;
    }

    String editado = request.getParameter("editado");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Profesor</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .register-box {
            background: rgba(255, 255, 255, 0.92);
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 520px;
            text-align: center;
        }

        .register-box img {
            height: 80px;
            margin-bottom: 20px;
        }

        h5 {
            font-size: 1.3rem;
            font-weight: 600;
            color: #007bff;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 6px;
            color: #343a40;
            display: block;
            text-align: left;
        }

        .form-control {
            font-size: 1rem;
            padding: 12px 15px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            width: 100%;
            box-sizing: border-box;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        .btn-block {
            font-size: 1rem;
            padding: 12px;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            border: none;
        }

        .btn-block:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container mt-3">
    <% if (editado != null) { %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <strong>✎ Cambios guardados correctamente.</strong>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <% } else if (error != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>⚠ No se pudo guardar los cambios.</strong>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <% } %>
</div>

<div class="register-box text-center">
    <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" class="img-fluid mb-3" style="height:120px;">
    <h5 class="text-primary mb-4">
        <i class="fas fa-user-edit"></i> Edición de profesor
    </h5>

    <form action="ProfesorServlet" method="post" autocomplete="off">
        <input type="hidden" name="accion" value="editar">
        <input type="hidden" name="id" value="<%= prof.getId() %>">

        <div class="form-group text-left">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" value="<%= prof.getNombre() %>" required>
        </div>

        <div class="form-group text-left">
            <label class="form-label">Apellido</label>
            <input type="text" name="apellido" class="form-control" value="<%= prof.getApellido() %>" required>
        </div>

        <div class="form-group text-left">
            <label class="form-label">Documento</label>
            <input type="text" name="documento" class="form-control" value="<%= prof.getDocumento() %>" required>
        </div>

        <div class="form-group text-left">
            <label class="form-label">Dirección</label>
            <input type="text" name="direccion" class="form-control" value="<%= prof.getDireccion() %>">
        </div>

        <div class="form-group text-left">
            <label class="form-label">Teléfono</label>
            <input type="text" name="telefono" class="form-control" value="<%= prof.getTelefono() %>">
        </div>

        <div class="form-group text-left">
            <label class="form-label">Correo</label>
            <input type="email" name="correo" class="form-control" value="<%= prof.getCorreo() %>" required>
        </div>

        <div class="form-group text-left">
            <label class="form-label">Fecha de nacimiento</label>
            <input type="date" name="fechaNacimiento" class="form-control"
                   value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(prof.getFechaNacimiento()) %>" required>
        </div>

        <div class="form-group text-left">
            <label class="form-label">Especialidad</label>
            <input type="text" name="especialidad" class="form-control" value="<%= prof.getEspecialidad() %>">
        </div>

        <div class="form-group text-left">
            <label class="form-label">Género</label>
            <select name="genero" class="form-control" required>
                <option value="masculino" <%= prof.getGenero().equals("masculino") ? "selected" : "" %>>Masculino</option>
                <option value="femenino" <%= prof.getGenero().equals("femenino") ? "selected" : "" %>>Femenino</option>
                <option value="otro" <%= prof.getGenero().equals("otro") ? "selected" : "" %>>Otro</option>
            </select>
        </div>

        <div class="form-group text-left">
            <label class="form-label">Estado</label>
            <select name="estado" class="form-control" required>
                <option value="activo" <%= prof.getEstado().equals("activo") ? "selected" : "" %>>Activo</option>
                <option value="inactivo" <%= prof.getEstado().equals("inactivo") ? "selected" : "" %>>Inactivo</option>
            </select>
        </div>

        <button type="submit" class="btn btn-block">Guardar cambios</button>
        <a href="listarProfesores.jsp" class="btn btn-secondary mt-3">Cancelar</a>
    </form>
</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>