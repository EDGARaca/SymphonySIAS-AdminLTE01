<%-- 
    Document   : listarCursosPorProfesor
    Created on : 28/11/2025, 3:37:00 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre" %>

<%
    List<CursoLibre> listaCursos = (List<CursoLibre>) request.getAttribute("listaCursos");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Cursos Libres</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
</head>
<body>
<div class="container mt-4">
    <h4 class="text-primary"><i class="fas fa-book"></i> Mis Cursos Libres</h4>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th><th>Nombre</th><th>Horario</th><th>Valor</th><th>Frecuencia</th><th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <% if (listaCursos != null) {
                   for (CursoLibre c : listaCursos) { %>
                       <tr>
                           <td><%= c.getId() %></td>
                           <td><%= c.getNombre() %></td>
                           <td><%= c.getHorario() %></td>
                           <td><%= c.getValor() %></td>
                           <td><%= c.getFrecuencia() %></td>
                           <td><%= c.getEstado() %></td>
                           <td>
                               <!-- Botón para ver estudiantes inscritos en este curso -->
                               <a href="EstudianteServlet?accion=listarPorCurso&idCurso=<%= c.getId() %>" 
                                  class="btn btn-sm btn-info">
                                   <i class="fas fa-users"></i> Ver Estudiantes
                               </a>
                           </td>                     
                       </tr>
            <%     }
               } %>
        </tbody>
    </table>
</div>
</body>
</html>