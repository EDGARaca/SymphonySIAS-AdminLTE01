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
</head>
<body style="background-color: #f4f6f9;">
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h5><i class="fas fa-user-edit"></i> Editar estudiante</h5>
            </div>
            <div class="card-body">
                <form action="EstudianteServlet" method="post">
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="id" value="<%= est.getId() %>">

                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" name="nombre" class="form-control" value="<%= est.getNombre() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Apellido</label>
                        <input type="text" name="apellido" class="form-control" value="<%= est.getApellido() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Documento</label>
                        <input type="text" name="documento" class="form-control" value="<%= est.getDocumento() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Dirección</label>
                        <input type="text" name="direccion" class="form-control" value="<%= est.getDireccion() %>">
                    </div>

                    <div class="form-group">
                        <label>Teléfono</label>
                        <input type="text" name="telefono" class="form-control" value="<%= est.getTelefono() %>">
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" value="<%= est.getEmail() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Fecha de nacimiento</label>
                        <input type="date" name="fechaNacimiento" class="form-control" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(est.getFechaNacimiento()) %>" required>
                    </div>

                    <div class="form-group">
                        <label>Género</label>
                        <select name="genero" class="form-control" required>
                            <option value="masculino" <%= est.getGenero().equals("masculino") ? "selected" : "" %>>Masculino</option>
                            <option value="femenino" <%= est.getGenero().equals("femenino") ? "selected" : "" %>>Femenino</option>
                            <option value="otro" <%= est.getGenero().equals("otro") ? "selected" : "" %>>Otro</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Estado</label>
                        <select name="estado" class="form-control" required>
                            <option value="activo" <%= est.getEstado().equals("activo") ? "selected" : "" %>>Activo</option>
                            <option value="inactivo" <%= est.getEstado().equals("inactivo") ? "selected" : "" %>>Inactivo</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Usuario que registró</label>
                        <input type="text" name="usuario_registro" class="form-control" value="<%= est.getUsuarioRegistro() %>" readonly>
                    </div>

                    <button type="submit" class="btn btn-success">Guardar cambios</button>
                    <a href="listarEstudiantes.jsp" class="btn btn-secondary">Cancelar</a>
                </form>
            </div>
        </div>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
