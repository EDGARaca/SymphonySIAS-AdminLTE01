<%-- 
    Document   : editarProfesor
    Created on : 29/10/2025, 7:20:37 a. m.
    Author     : Spiri
--%>



<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycom.symphonysias.adminlte01.dao.ProfesorDAO" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.Profesor" %>

<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null || !(rol.equals("administrador") || rol.equals("coordinador académico") || rol.equals("director"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("listarProfesores.jsp?error=id");
        return;
    }

    int id = Integer.parseInt(idParam);
    ProfesorDAO dao = new ProfesorDAO();
    Profesor profesor = dao.buscarPorId(id);

    if (profesor == null) {
        response.sendRedirect("listarProfesores.jsp?error=noencontrado");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Profesor | SymphonySIAS</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .container-box {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container-box">
        <h4 class="text-primary text-center mb-4">
            <i class="fas fa-user-edit"></i> Edición de Profesor
        </h4>

        <form action="EditarProfesorServlet" method="post" accept-charset="UTF-8">
            <input type="hidden" name="id" value="<%= profesor.getId() %>">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Nombre</label>
                    <input type="text" name="nombre" class="form-control" value="<%= profesor.getNombre() %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Apellido</label>
                    <input type="text" name="apellido" class="form-control" value="<%= profesor.getApellido() %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Documento</label>
                    <input type="text" name="documento" class="form-control" value="<%= profesor.getDocumento() %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Dirección</label>
                    <input type="text" name="direccion" class="form-control" value="<%= profesor.getDireccion() %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Teléfono</label>
                    <input type="text" name="telefono" class="form-control" value="<%= profesor.getTelefono() %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Correo electrónico</label>
                    <input type="email" name="correo" class="form-control" value="<%= profesor.getCorreo() %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Fecha de nacimiento</label>
                    <input type="date" name="fecha_nacimiento" class="form-control" value="<%= profesor.getFecha_nacimiento() %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Especialidad</label>
                    <input type="text" name="especialidad" class="form-control" value="<%= profesor.getEspecialidad() %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Género</label>
                    <select name="genero" class="form-control">
                        <option value="masculino" <%= "masculino".equals(profesor.getGenero()) ? "selected" : "" %>>Masculino</option>
                        <option value="femenino" <%= "femenino".equals(profesor.getGenero()) ? "selected" : "" %>>Femenino</option>
                        <option value="otro" <%= "otro".equals(profesor.getGenero()) ? "selected" : "" %>>Otro</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Estado</label>
                    <select name="estado" class="form-control">
                        <option value="activo" <%= "activo".equals(profesor.getEstado()) ? "selected" : "" %>>Activo</option>
                        <option value="inactivo" <%= "inactivo".equals(profesor.getEstado()) ? "selected" : "" %>>Inactivo</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Usuario que registró</label>
                    <input type="text" class="form-control" value="<%= profesor.getUsuario_registro() %>" readonly>
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Guardar cambios
                </button>
            </div>
        </form>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>