<%-- 
    Document   : login.jsp
    Created on : 1/10/2025, 11:26:12 a. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Solo invalidar sesión si viene del parámetro logout
    String logout = request.getParameter("logout");
    if ("true".equals(logout)) {
        HttpSession sesion = request.getSession(false);
        if (sesion != null) {
            sesion.invalidate();
        }
    }
    
    String error = (String) request.getAttribute("error");
    String registro = request.getParameter("registro");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SymphonySIAS | Inicio de sesión</title>
    <!-- Bootstrap desde CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome desde CDN -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: url('assets/adminlte/img/pentagrama.jpg') no-repeat center center fixed;
            background-size: cover;
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.97);
            padding: 50px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 480px;
        }

        .logo-container {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-container img {
            max-height: 120px;
            margin-bottom: 15px;
        }

        .login-title {
            color: #007bff;
            font-size: 1.4rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 30px;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 25px;
        }

        .input-wrapper i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.1rem;
            pointer-events: none;
            z-index: 1;
        }

        .input-field {
            width: 100%;
            padding: 15px 20px 15px 50px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .input-field:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        .input-field::placeholder {
            color: #aaa;
        }

        .btn-submit {
            width: 100%;
            padding: 15px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .alert-custom {
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.95rem;
        }

        .alert-success-custom {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger-custom {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #6c757d;
            font-size: 0.95rem;
        }

        .register-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-container">
            <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS">
            <h1 class="login-title">
                <i class="fas fa-music"></i> SymphonySIAS | Acceso
            </h1>
        </div>

        <% if ("exitoso".equals(registro)) { %>
            <div class="alert-custom alert-success-custom">
                <i class="fas fa-check-circle"></i> ¡Registro exitoso! Ahora puedes iniciar sesión.
            </div>
        <% } %>

        <% if ("true".equals(logout)) { %>
            <div class="alert-custom alert-success-custom">
                <i class="fas fa-sign-out-alt"></i> ¡Has cerrado la sesión correctamente!
            </div>
        <% } %>

        <% if (error != null) { %>
            <div class="alert-custom alert-danger-custom">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post" id="loginForm" autocomplete="off">
            <div class="input-wrapper">
                <i class="fas fa-user"></i>
                <input 
                    type="text" 
                    name="usuario" 
                    id="usuario" 
                    class="input-field" 
                    placeholder="Usuario" 
                    autocomplete="off"
                    value=""
                    required>
            </div>

            <div class="input-wrapper">
                <i class="fas fa-lock"></i>
                <input 
                    type="password" 
                    name="clave" 
                    id="clave" 
                    class="input-field" 
                    placeholder="Contraseña" 
                    autocomplete="off"
                    value=""
                    required>
            </div>
            
            <button type="submit" class="btn-submit">
                <i class="fas fa-sign-in-alt"></i> INICIAR SESIÓN
            </button>
        </form>

        <div class="register-link">
            ¿No tienes cuenta? <a href="registro.jsp">Crear una cuenta</a>
        </div>
    </div>

    <!-- Scripts desde CDN -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // FORZAR LIMPIEZA INMEDIATA - antes de que cargue todo
        (function() {
            console.log('🧹 Limpieza preventiva iniciada...');
            const inputs = document.querySelectorAll('input[type="text"], input[type="password"]');
            inputs.forEach(function(input) {
                input.value = '';
                input.setAttribute('value', '');
            });
        })();

        document.addEventListener('DOMContentLoaded', function() {
            const usuarioInput = document.getElementById('usuario');
            const claveInput = document.getElementById('clave');
            const loginForm = document.getElementById('loginForm');
            
            console.log('✅ Login form cargado');
            
            // TRIPLE LIMPIEZA para asegurar que no quede nada del navegador
            function limpiarCampos() {
                usuarioInput.value = '';
                claveInput.value = '';
                usuarioInput.setAttribute('value', '');
                claveInput.setAttribute('value', '');
                console.log('🧹 Campos limpiados');
            }
            
            // Limpiar al cargar
            limpiarCampos();
            
            // Limpiar después de 50ms (por si el navegador autocompleta después)
            setTimeout(limpiarCampos, 50);
            
            // Limpiar después de 200ms (segunda verificación)
            setTimeout(limpiarCampos, 200);
            
            // Monitorear cambios en usuario
            usuarioInput.addEventListener('input', function(e) {
                const valor = e.target.value || '';
                console.log('👤 Usuario:', valor, '| Longitud:', valor.length);
            });
            
            // Monitorear cambios en clave
            claveInput.addEventListener('input', function(e) {
                const valor = e.target.value || '';
                console.log('🔒 Clave longitud:', valor.length);
            });
            
            // Prevenir Enter accidental en campo usuario
            usuarioInput.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    claveInput.focus();
                    return false;
                }
            });
            
            // Al enviar el formulario
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const usuario = usuarioInput.value.trim();
                const clave = claveInput.value.trim();
                
                console.log('📤 INTENTANDO ENVIAR LOGIN:');
                console.log('   Usuario:', usuario);
                console.log('   Clave longitud:', clave.length);
                
                // Validaciones
                if (!usuario || usuario === '') {
                    alert('⚠️ Por favor ingrese su usuario');
                    usuarioInput.focus();
                    return false;
                }
                
                if (!clave || clave === '') {
                    alert('⚠️ Por favor ingrese su contraseña');
                    claveInput.focus();
                    return false;
                }
                
                if (clave.length < 4) {
                    alert('⚠️ La contraseña debe tener al menos 4 caracteres');
                    claveInput.focus();
                    return false;
                }
                
                // Todo OK - enviar
                console.log('✅ Validaciones OK, enviando formulario...');
                loginForm.submit();
            });
            
            // EXTRA: Detectar si el navegador intenta autocompletar
            setTimeout(function() {
                if (usuarioInput.value !== '' || claveInput.value !== '') {
                    console.warn('⚠️ DETECTADO: El navegador autocompletó los campos');
                    console.log('   Usuario autocompletado:', usuarioInput.value);
                    console.log('   Clave autocompletada (longitud):', claveInput.value.length);
                    limpiarCampos();
                }
            }, 500);
        });
    </script>
</body>
</html>