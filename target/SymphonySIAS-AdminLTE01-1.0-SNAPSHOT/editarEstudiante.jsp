<%-- 
    Document   : editarEstudiante
    Created on : 16/10/2025, 9:35:20 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Estudiante"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.EstudianteDAO"%>


<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null || 
        !(rol.equals("administrador") || rol.equals("coordinador académico") || rol.equals("director"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Obtener ID del estudiante
    String idStr = request.getParameter("id");
    int id = (idStr != null) ? Integer.parseInt(idStr) : 0;

    EstudianteDAO dao = new EstudianteDAO();
    Estudiante est = dao.buscarPorId(id);

    if (est == null) {
        response.sendRedirect("listarEstudiantes.jsp?error=notfound");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Estudiante</title>
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

        .form-group i {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: #6c757d;
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
<body style="background-color: #f4f6f9;">
    <%
    String editado = request.getParameter("editado");
    String error = request.getParameter("error");
    %>

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
            <i class="fas fa-user-edit"></i> Edición de estudiante
        </h5>

        <form action="EstudianteServlet" method="post" autocomplete="off">
            <input type="hidden" name="accion" value="editar">
            <input type="hidden" name="id" value="<%= est.getId() %>">

            <!-- Campo: Nombre -->
            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-id-card"></i>
                <input type="text" name="nombre" class="form-control" placeholder="Nombre" value="<%= est.getNombre() %>" required style="padding-left: 45px;">
            </div>

            <!-- Campo: Apellido -->
            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-user"></i>
                <input type="text" name="apellido" class="form-control" placeholder="Apellido" value="<%= est.getApellido() %>" required style="padding-left: 45px;">
            </div>

            <!-- Campo: Documento -->
            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-id-badge"></i>
                <input type="text" name="documento" class="form-control" placeholder="Documento" value="<%= est.getDocumento() %>" required style="padding-left: 45px;">
            </div>

            <!-- Campo: Dirección -->
            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-map-marker-alt"></i>
                <input type="text" name="direccion" class="form-control" placeholder="Dirección" value="<%= est.getDireccion() %>" style="padding-left: 45px;">
            </div>

            <!-- Campo: Teléfono -->
            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-phone"></i>
                <input type="text" name="telefono" class="form-control" placeholder="Teléfono" value="<%= est.getTelefono() %>" style="padding-left: 45px;">
            </div>

            <!-- Campo: Correo -->
            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-envelope"></i>
                <input type="email" name="correo" class="form-control" placeholder="Correo electrónico" value="<%= est.getCorreo() %>" required style="padding-left: 45px;">
            </div>

            <!-- Campo: Fecha de nacimiento -->
            <div class="form-group text-left mb-4">
                <label for="fechaNacimiento" class="form-label">Fecha de nacimiento</label>
                <input type="date" name="fechaNacimiento" class="form-control" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(est.getFechaNacimiento()) %>" required>
            </div>

            <!-- Campo: Género -->
            <div class="form-group text-left mb-4">
                <label for="genero" class="form-label">Género</label>
                <select name="genero" class="form-control" required>
                    <option value="masculino" <%= est.getGenero().equals("masculino") ? "selected" : "" %>>Masculino</option>
                    <option value="femenino" <%= est.getGenero().equals("femenino") ? "selected" : "" %>>Femenino</option>
                    <option value="otro" <%= est.getGenero().equals("otro") ? "selected" : "" %>>Otro</option>
                </select>
            </div>

            <!-- Campo: Estado -->
            <div class="form-group text-left mb-4">
                <label for="estado" class="form-label">Estado</label>
                <select name="estado" class="form-control" required>
                    <option value="activo" <%= est.getEstado().equals("activo") ? "selected" : "" %>>Activo</option>
                    <option value="inactivo" <%= est.getEstado().equals("inactivo") ? "selected" : "" %>>Inactivo</option>
                </select>
            </div>

            <!-- Campo: Usuario que registró -->
            <div class="form-group text-left mb-4">
                <label for="usuario_registro" class="form-label">Usuario que registró</label>
                <input type="text" name="usuario_registro" class="form-control" value="<%= est.getUsuarioRegistro() %>" readonly>
            </div>

            <button type="submit" class="btn btn-block">Guardar cambios</button>
            <a href="listarEstudiantes.jsp" class="btn btn-secondary mt-3">Cancelar</a>
        </form>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
