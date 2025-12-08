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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    <style>
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

        .input-wrapper i.fas.fa-lock {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.1rem;
            pointer-events: none;
            z-index: 1;
        }
        
        .input-wrapper i.fas.fa-eye,
        .input-wrapper i.fas.fa-eye-slash {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.1rem;
            cursor: pointer;
            z-index: 2;
        }

        .input-field {
            width: 100%;
            padding: 15px 50px 15px 50px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            background: white;
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
        
        #toggleClave {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 2;
        }

        #toggleClave:hover i {
            color: #007bff;
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

    <form id="loginForm" action="LoginServlet" method="post" autocomplete="off">
      <!-- Campo usuario -->
      <div class="form-group text-left mb-4" style="position: relative;">
        <i class="fas fa-user" style="position: absolute; top: 50%; left: 15px; transform: translateY(-50%); color: #6c757d;"></i>
        <input type="text" name="usuario" id="usuario" class="form-control"
               placeholder="Ingrese su usuario" autocomplete="off" required
               style="padding-left: 45px; padding-right: 45px;">
      </div>

      <!-- Campo contraseña con ícono de ojo -->
      <div class="form-group text-left mb-4" style="position: relative;">
        <i class="fas fa-lock" style="
          position: absolute;
          top: 50%;
          left: 15px;
          transform: translateY(-50%);
          color: #6c757d;
          pointer-events: none;
          z-index: 1;
        "></i>

        <input type="password" name="clave" id="clave" class="form-control"
               placeholder="Ingrese su contraseña" autocomplete="new-password" required
               style="padding-left: 45px; padding-right: 45px; height: 45px;">

        <span id="toggleClave" style="
          position: absolute;
          top: 50%;
          right: 15px;
          transform: translateY(-50%);
          cursor: pointer;
          z-index: 2;
          display: none;
        ">
          <i class="fas fa-eye" id="iconClave" style="color: #6c757d;"></i>
        </span>
      </div>

      <!-- Botón -->
      <button type="submit" class="btn btn-block"
              style="background-color: #007bff; color: white; border: none; padding: 12px; border-radius: 8px; font-size: 1rem;">
        LOGIN
      </button>
    </form>

    <div class="register-link">
      ¿No tienes cuenta? <a href="registro.jsp">Crear una cuenta</a>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

  <script>
  (function(){
    console.log("🧹 Limpieza preventiva iniciada...");
    document.querySelectorAll('input[type="text"],input[type="password"]').forEach(i=>{
      i.value="";
      i.setAttribute("value","");
    });
  })();

  document.addEventListener("DOMContentLoaded",function(){
    const u=document.getElementById("usuario"),
          c=document.getElementById("clave"),
          f=document.getElementById("loginForm"),
          t=document.getElementById("toggleClave"),
          ic=document.getElementById("iconClave");

    console.log("✅ Login form cargado");

    function limpiar(){
      u.value=""; c.value="";
      u.setAttribute("value",""); c.setAttribute("value","");
      console.log("🧹 Campos limpiados");
    }

    u.addEventListener("input",e=>{
      const v=e.target.value||"";
      console.log("👤 Usuario:",v,"| Longitud:",v.length);
    });

    c.addEventListener("input",e=>{
      const v=e.target.value||"";
      console.log("🔒 Clave longitud:",v.length);
      if(v.length>0){
        t.style.display="block";
      }else{
        t.style.display="none";
        c.type="password";
        ic.classList.replace("fa-eye-slash","fa-eye");
      }
    });

    u.addEventListener("keydown",e=>{
      if(e.key==="Enter"){
        e.preventDefault();
        c.focus();
      }
    });

    f.addEventListener("submit",e=>{
      e.preventDefault();
      const us=u.value.trim(), cl=c.value.trim();
      console.log("📤 INTENTANDO ENVIAR LOGIN:","Usuario:",us,"Clave longitud:",cl.length);
      if(!us){alert("⚠️ Por favor ingrese su usuario");u.focus();return;}
      if(!cl){alert("⚠️ Por favor ingrese su contraseña");c.focus();return;}
      if(cl.length<1){alert("⚠️ La contraseña no puede estar vacía");c.focus();return;}
      console.log("✅ Validaciones OK, enviando formulario...");
      f.submit();
    });

    setTimeout(()=>{
      if(u.value!==""||c.value!==""){
        console.warn("⚠️ DETECTADO: El navegador autocompletó los campos");
        console.log("Usuario autocompletado:",u.value,"Clave autocompletada (longitud):",c.value.length);
        limpiar();
      }
    },500);

    // Toggle ver/ocultar contraseña
    t.addEventListener("click",()=>{
      console.log("Toggle ojo clickeado. Tipo actual:", c.type);
      if(c.type==="password"){
        c.type="text";
        ic.classList.remove("fa-eye");
        ic.classList.add("fa-eye-slash");
      }else{
        c.type="password";
        ic.classList.remove("fa-eye-slash");
        ic.classList.add("fa-eye");
      }
    });
  });
</script>
</body>
</html>