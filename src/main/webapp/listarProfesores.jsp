<%-- 
    Document   : listarProfesores
    Created on : 22/10/2025, 12:10:50 a. m.
    Author     : Spiri
--%>


<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Profesor"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.ProfesorDAO"%>
<%@ include file="/componentes/roles.jspf" %>


<%
    // Recuperación de lista de profesores con trazabilidad
    ProfesorDAO dao = new ProfesorDAO();
    List<Profesor> lista = dao.listar();
    System.out.println("[JSP] Profesores recuperados: " + lista.size());
    
    // ContextPath para rutas seguras en Tomcat
    String contextPath = request.getContextPath();
%>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Profesores</title>
    <link rel="stylesheet" href="${base}/assets/adminlte/css/bootstrap.min.css">
    <link rel="stylesheet" href="${base}/assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="${base}/assets/adminlte/css/adminlte.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/assets/custom.css"><!-- estilos institucionales -->

</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
    
    <!-- Componentes comunes -->
    <jsp:include page="componentes/header.jsp" />
    <jsp:include page="componentes/sidebar.jsp" />

    <div class="content-wrapper">
        <!-- Encabezado -->
        <section class="content-header">
            <div class="content-header">
                <div class="container-fluid">
                    <!-- Permiso para registrar: Admin o Profesor -->
                    <c:if test="${isAdmin or isProfesor}">
                        <div class="d-flex justify-content-end mb-3">
                            <a href="registroProfesor.jsp" class="btn btn-success">
                                <i class="fas fa-plus-circle"></i> Registrar nuevo profesor
                            </a>
                        </div>
                    </c:if>
                    <h4 class="mb-3 text-primary">
                        <i class="fas fa-chalkboard-teacher"></i> Listado de Profesores
                    </h4>
                </div>
            </div>

            <!-- Mensajes de feedback -->
            <div class="container-fluid">
                <% 
                   String registrado = request.getParameter("registrado");
                   String editado = request.getParameter("editado");
                   String eliminado = request.getParameter("eliminado");
                   String error = request.getParameter("error");
                %>

                <% if (registrado != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>✔ Profesor registrado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (editado != null) { %>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <strong>✎ Profesor editado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (eliminado != null) { %>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>🗑 Profesor eliminado definitivamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if ("activo".equals(error)) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>⚠ No se puede eliminar un profesor activo. Primero debe inactivarse.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if ("eliminacion".equals(error)) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>⚠ Ocurrió un error al eliminar el profesor. Revise dependencias o integridad referencial.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if ("permiso".equals(error)) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>⚠ No tiene permisos para realizar esta acción.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } %>
                </div>
        </section>

        <!-- Contenido principal -->
        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-users"></i> Profesores registrados
                        </h5>
                        <div class="card-tools">
                            <a href="ExportarProfesoresServlet" class="btn btn-sm btn-outline-success">
                                <i class="fas fa-file-pdf"></i> Exportar PDF
                            </a>
                        </div>
                    </div>
                    <div class="card-body table-responsive">
                        <% if (request.getParameter("sinDatos") != null) { %>
                            <div class="alert alert-warning text-center">
                                <i class="fas fa-exclamation-triangle"></i> No hay registros disponibles para exportar.
                            </div>
                        <% } %>

                        <% if (request.getParameter("exportado") != null) { %>
                            <div class="alert alert-success text-center">
                                <i class="fas fa-file-export"></i> Exportación completada correctamente.
                            </div>
                        <% } %>

                        <table class="table table-bordered table-hover table-striped">
                            <thead class="thead-dark text-center">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Documento</th>
                                    <th>Direccion</th>
                                    <th>Telefono</th>
                                    <th>Correo</th>
                                    <th>Fecha_nacimiento</th>
                                    <th>Especialidad</th>
                                    <th>Genero</th>
                                    <th>Estado</th>
                                    <th>Usuario_registro</th>
                                    <!-- Acciones visibles solo para roles con permisos -->
                                    <c:if test="${isAdmin or isDirector or isCoordinador}">
                                        <th>Acciones</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Profesor p : lista) { %>
                                    <tr>
                                        <td><%= p.getId() %></td>
                                        <td><%= p.getNombre() %></td>
                                        <td><%= p.getApellido() %></td>
                                        <td><%= p.getDocumento() %></td>
                                        <td><%= p.getDireccion() %></td>
                                        <td><%= p.getTelefono() %></td>
                                        <td><%= p.getCorreo() %></td>
                                        <td><%= p.getFecha_nacimiento() %></td>
                                        <td><%= p.getEspecialidad() %></td>
                                        <td><%= p.getGenero() %></td>
                                        <td><%= p.getEstado() %></td>
                                        <td><%= p.getUsuario_registro() %></td>
                                        
                                        <c:if test="${isAdmin or isDirector or isCoordinador}">
                                            <td class="text-center">
                                                <%
                                                    // Se pasa el profesor actual al componente de acciones
                                                    request.setAttribute("profesor", p);
                                                %>
                                                <jsp:include page="componentes/accionesProfesores.jsp" />
                                            </td>
                                        </c:if>

                                        </tr>
                                <% } %>                                
                            </tbody>
                        </table>
                    </div>
                </div> 
            </div>
        </section>
        <!-- Footer institucional -->                    
        <jsp:include page="componentes/footer.jsp" />                    
    </div>    
</div>
<!-- Scripts de AdminLTE -->
<script src="${base}/assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="${base}/assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${base}/assets/adminlte/js/adminlte.min.js"></script>

<script>
    // Ocultar alertas después de 8 segundos
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            alert.classList.remove('show');
            alert.classList.add('fade');
        });
    }, 8000);
</script>
</body>
</html>