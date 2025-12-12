<%-- 
    Document   : listarCursoLibre.jsp
    Created on : 30/10/2025, 10:12:12 p. m.
    Author     : Spiri
--%>
<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="componentes/roles.jspf" %>

<%
    // Validación de sesión (ISO/IEC 25010 - Confiabilidad)
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
   

    if (usuario == null || nombre == null || rol == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // Trazabilidad en consola
    System.out.println("[LISTAR CURSOS LIBRES] Sesión activa: " + usuario + " (" + rol + ")");

    // Recuperar lista de cursos desde DAO
    CursoLibreDAO dao = new CursoLibreDAO();
    List<CursoLibre> cursos = dao.listar();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado Cursos Libres</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <jsp:include page="componentes/header.jsp" />
    <jsp:include page="componentes/sidebar.jsp" />

    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <h4 class="mb-3 text-success">
                    <i class="fas fa-list-alt"></i> Listado de Cursos Libres
                </h4>
                <p class="text-muted">Consulta todos los cursos libres registrados en el sistema.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- Mensajes de estado -->
                <c:if test="${param.ok eq 'registrado'}">
                    <div class="alert alert-success text-center">
                        <i class="fas fa-check-circle"></i> Curso registrado correctamente.
                    </div>
                </c:if>
                <c:if test="${param.error eq 'permiso'}">
                    <div class="alert alert-danger text-center">
                        <i class="fas fa-exclamation-triangle"></i> No tienes permisos para acceder a esta funcionalidad.
                    </div>
                </c:if>
                <c:if test="${param.error eq 'dao'}">
                    <div class="alert alert-warning text-center">
                        <i class="fas fa-exclamation-circle"></i> Error al acceder a la base de datos.
                    </div>
                </c:if>
                <c:if test="${param.error eq 'excepcion'}">
                    <div class="alert alert-danger text-center">
                        <i class="fas fa-bug"></i> Ocurrió un error inesperado en el sistema.
                    </div>
                </c:if>

                <!-- Tabla de cursos -->
                <div class="card mt-3">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-table"></i> Cursos registrados
                        </h5>
                    </div>
                    <div class="card-body table-responsive">
                        <% if (cursos.isEmpty()) { %>
                            <div class="alert alert-warning text-center">
                                <i class="fas fa-exclamation-circle"></i> No hay cursos registrados actualmente.
                            </div>
                        <% } else { %>
                            <table class="table table-bordered table-hover table-striped text-center">
                                <thead class="thead-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Valor</th>
                                        <th>Frecuencia</th>
                                        <th>Estado</th>
                                        <th>Profesor</th>
                                        <th>Usuario Registro</th>
                                        <c:if test="${isAdmin or isDirector or isCoord}">
                                            <th>Acciones</th>
                                        </c:if>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (CursoLibre c : cursos) { %>
                                        <tr>
                                            <td><%= c.getId() %></td>
                                            <td><%= c.getNombre() %></td>
                                            <td>$<%= c.getValor() %></td>
                                            <td><%= c.getFrecuencia() %></td>
                                            <td><%= c.getEstado() %></td>
                                            <td><%= c.getIdProfesor() %></td>
                                            <td><%= c.getUsuario_registro() %></td>
                                            <c:if test="${isAdmin or isDirector or isCoord}">
                                                <td>
                                                    <a href="EditarCursoLibreServlet?id=<%= c.getId() %>" class="btn btn-sm btn-outline-primary">
                                                        <i class="fas fa-edit"></i> Editar
                                                    </a>
                                                    <a href="EliminarCursoLibreServlet?id=<%= c.getId() %>" class="btn btn-sm btn-outline-danger" 
                                                       onclick="return confirm('¿Seguro que deseas eliminar este curso?');">
                                                        <i class="fas fa-trash"></i> Eliminar
                                                    </a>
                                                </td>
                                            </c:if>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } %>
                    </div>
                </div>

            </div>
        </section>

        <jsp:include page="componentes/footer.jsp" />
    </div>
</div>

</body>
</html>