<%-- 
    Document   : login.jsp
    Created on : 1/10/2025, 11:26:12 a. m.
    Author     : Spiri
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion != null) {
        sesion.invalidate();
    }
%>
<%
    String logout = request.getParameter("logout");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SymphonySIAS | Inicio de sesión</title>
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

            .login-box, .register-box {
            background: rgba(250, 250, 250, 0.96); /* Puedes ajustar el 0.92 a tu gusto */
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 460px;
            text-align: center;
            overflow: hidden;
        }

        .login-box img, .register-box img {
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
            padding: 12px 15px 12px 45px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            width: 100%;
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
            color: #6c757d;
        }
        
        .form-control {
            width: calc(100% - 10px); /* Ajuste dinámico */
            box-sizing: border-box;
}

        .btn-login, .btn-block {
            font-size: 1rem;
            padding: 12px;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover, .btn-block:hover {
            background-color: #0056b3;
        }

        .alert {
            font-size: 0.95rem;
            margin-bottom: 20px;
            border-radius: 8px;
            padding: 12px;
        }

        .text-muted {
            font-size: 0.9rem;
        }

        .text-muted a {
            color: #007bff;
            text-decoration: none;
        }

        .text-muted a:hover {
            text-decoration: underline;
        }
        
        .text-primary {
            color: #007bff !important;
        }
    </style>
</head>
<body>
    <div class="login-box text-center">
        <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" class="img-fluid mb-3" style="height:140px;">
        <h4 class="text-primary mb-4">
            <i class="fas fa-music"></i> Bienvenidos a SymphonySIAS | Acceso
        </h4>
        <%
            String registro = request.getParameter("registro");
            if ("exitoso".equals(registro)) {
        %>
            <div class="alert alert-success">¡Registro exitoso! Ahora puedes iniciar sesión.</div>
        <%
            }
        %>

        <% if ("true".equals(logout)) { %>
            <div class="alert alert-success">¡Has cerrado la sesión correctamente!</div>
        <% } %>

        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="LoginServlet" method="post" autocomplete="off">
            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-user" style="position: absolute; top: 50%; left: 15px; transform: translateY(-50%); color: #6c757d;"></i>
                <input type="text" name="usuario" id="usuario" class="form-control" placeholder="Ingrese su usuario" autocomplete="off" required style="padding-left: 45px;">
            </div>

            <div class="form-group text-left mb-4" style="position: relative;">
                <i class="fas fa-lock" style="position: absolute; top: 50%; left: 15px; transform: translateY(-50%); color: #6c757d;"></i>
                <input type="password" name="clave" id="clave" class="form-control" placeholder="Ingrese su contraseña" autocomplete="new-password" required style="padding-left: 45px;">
            </div>
            
            <button type="submit" class="btn btn-block" style="background-color: #007bff; color: white; border: none; padding: 12px; border-radius: 8px; font-size: 1rem;">LOGIN</button>

        </form>

        <p class="mt-4 text-muted">
            ¿No estás registrado? <a href="registro.jsp">Create an account</a>
        </p>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>