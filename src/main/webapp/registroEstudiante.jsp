<%-- 
    Document   : registroEstudiante.jsp
    Created on : 16/10/2025, 7:55:40 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SymphonySIAS | Registro Estudiante</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 40px 0;
            overflow-x: hidden;
        }

        .container-fluid {
            padding-left: 40px;
            padding-right: 40px;
        }

        .form-box {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px 60px;
            border-radius: 12px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: auto;
        }

        h5 {
            font-size: 1.4rem;
            font-weight: 600;
            color: #007bff;
            margin-top: 20px;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 6px;
            color: #343a40;
        }

        .form-control {
            font-size: 1rem;
            padding: 10px 14px;
            border-radius: 8px;
            border: 1px solid #ced4da;
        }

        .mb-3 {
            margin-bottom: 1rem !important;
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
    <div class="container-fluid">
        <div class="form-box">
            <div class="text-center">
                <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" class="img-fluid" style="height:80px;">
                <h5><i class="fas fa-user-graduate"></i> Registro de Estudiante</h5>
            </div>

            <form action="EstudianteServlet" method="post" autocomplete="UTF-8">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="nombre">Nombre</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="apellido">Apellido</label>
                        <input type="text" name="apellido" id="apellido" class="form-control" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="documento">Documento</label>
                        <input type="text" name="documento" id="documento" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="direccion">Dirección</label>
                        <input type="text" name="direccion" id="direccion" class="form-control">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="telefono">Teléfono</label>
                        <input type="text" name="telefono" id="telefono" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="correo">Correo</label>
                        <input type="email" name="correo" id="correo" class="form-control" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="fechaNacimiento">Fecha de nacimiento</label>
                        <input type="date" name="fechaNacimiento" id="fechaNacimiento" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="genero">Género</label>
                        <select name="genero" id="genero" class="form-control" required>
                            <option value="">Seleccione</option>
                            <option value="masculino">Masculino</option>
                            <option value="femenino">Femenino</option>
                            <option value="otro">Otro</option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="estado">Estado</label>
                        <select name="estado" id="estado" class="form-control" required>
                            <option value="activo">Activo</option>
                            <option value="inactivo">Inactivo</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="usuario_registro">Usuario que registra</label>
                        <input type="text" name="usuario_registro" id="usuario_registro" class="form-control" value="<%= session.getAttribute("usuarioActivo") %>" readonly>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-block">Guardar estudiante</button>
                    <a href="listarEstudiantes.jsp" class="btn btn-secondary mt-3">
                        <i class="fas fa-arrow-left"></i> Cancelar y volver al listado
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>