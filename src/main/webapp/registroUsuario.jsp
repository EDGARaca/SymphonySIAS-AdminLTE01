<%-- 
    Document   : registroUsuario
    Created on : 27/10/2025, 11:10:42 a. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SymphonySIAS | Registro de Usuario</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <style>
        body {
            background: url('assets/adminlte/img/pentagrama.jpg') no-repeat left bottom;
            background-size: cover;
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .register-box {
            background: rgba(250, 250, 250, 0.96);
            padding: 40px 30px;
            border-radius: 12px;            
            box-sizing: border-box;
            width: 100%;
            max-width: 460px;
            text-align: center;
            overflow: hidden;
        }

        .register-box img {
            height: 80px;
            margin-bottom: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
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
            padding: 12px 15px 12px 40px;
            padding-left: 40px;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #ced4da;
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        .form-group i {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            font-size: 16px;
            color: #6c757d;
        }

        .btn-register {
            font-size: 1rem;
            padding: 12px;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            border: none;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .btn-register:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="register-box text-center">
        <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" class="img-fluid mb-3" style="height:140px;">
        <h4 class="text-primary mb-4">
            <i class="fas fa-user-plus"></i> Registro de Usuario
        </h4>

        <form action="CrearUsuarioServlet" method="post" autocomplete="off">
            <div class="form-group text-left">
                <i class="fas fa-id-card"></i>
                <input type="text" name="nombre" class="form-control" placeholder="Nombre completo" required>
            </div>

            <div class="form-group text-left">
                <i class="fas fa-user"></i>
                <input type="text" name="usuario" class="form-control" placeholder="Nombre de usuario" required>
            </div>

            <div class="form-group text-left">
                <i class="fas fa-lock"></i>
                <input type="password" name="clave" class="form-control" placeholder="Contraseña" required>
            </div>

            <div class="form-group text-left">
                <i class="fas fa-envelope"></i>
                <input type="email" name="correo" class="form-control" placeholder="Correo electrónico" required>
            </div>
            
            <div class="form-group text-left">
                <i class="fas fa-user-tag"></i>
                <select name="rol" class="form-control" required>
                    <option value="">Seleccione un rol</option>
                    <option value="admin">Administrador</option>
                    <option value="docente">Docente</option>
                    <option value="estudiante">Estudiante</option>
                    <option value="coordinador">Coordinador Académico</option>
                    <option value="director">Director</option>
                    <option value="auxadmin">Auxiliar Administrativo</option>
                    <option value="auxcont">Auxiliar Contable</option>
                </select>
            </div>

            <div class="form-group text-left">
                <i class="fas fa-toggle-on"></i>
                <select name="estado" class="form-control" required>
                    <option value="true">Activo</option>
                    <option value="false">Inactivo</option>
                </select>
            </div>

            <button type="submit" class="btn-register">Registrar</button>
        </form>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>