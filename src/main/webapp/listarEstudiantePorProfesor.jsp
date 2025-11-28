<%-- 
    Document   : listarEstudiantePorProfesor
    Created on : 28/11/2025, 3:32:17 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.Estudiante" %>

<%
    // Recuperar la lista enviada por el servlet
    List<Estudiante> listaEstudiantes = (List<Estudiante>) request.getAttribute("listaEstudiantes");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Estudiantes Inscritos</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
</head>
<body>
<div class="container mt-4">
    <h4 class="text-primary"><i class="fas fa-users"></i> Estudiantes Inscritos</h4>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Documento</th>
                <th>Correo</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <% 
               if (listaEstudiantes != null && !listaEstudiantes.isEmpty()) {
                   for (Estudiante e : listaEstudiantes) { %>
                       <tr>
                           <td><%= e.getId() %></td>
                           <td><%= e.getNombre() %></td>
                           <td><%= e.getApellido() %></td>
                           <td><%= e.getDocumento() %></td>
                           <td><%= e.getCorreo() %></td>
                           <td><%= e.getEstado() %></td>
                       </tr>
            <%     }
               } else { %>
                   <tr>
                       <td colspan="6" class="text-center text-muted">
                           No hay estudiantes inscritos para este profesor.
                       </td>
                   </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>