<%-- 
    Document   : login.jsp
    Created on : 1/10/2025, 11:26:12 a. m.
    Author     : Spiri
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login - SymphonySIAS</title>
        <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h3 class="mb-4">Inicio de sesión</h3>
            
            <%-- Formulario de acceso --%>
            <form action="LoginServlet" method="post">
                <input type="text" name="usuario" placeholder="Usuario" class="form-control mb-2" required>
                <input type="password" name="clave" placeholder="Clave" class="form-control mb-2" required>
                <button type="submit" class="btn btn-primary">Ingresar</button>
            </form>
            
             <%-- Mensaje de error si las credenciales fallan --%>
            <% if (request.getAttribute("error") != null) {%>
            <p class="text-danger mt-2"><%= request.getAttribute("error") %></p>            
            <% } %>            
        </div>        
    </body>
</html>