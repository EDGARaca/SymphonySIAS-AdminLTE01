<%-- 
    Document   : listarProfesores
    Created on : 22/10/2025, 12:10:50 a. m.
    Author     : Spiri
--%>


<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Profesor"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.ProfesorDAO"%>

<%
   String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null || 
        !(rol.equalsIgnoreCase("ADMINISTRADOR SIAS") || rol.equalsIgnoreCase("COORDINADOR ACADÉMICO") || rol.equalsIgnoreCase("DIRECTOR"))) {
        response.sendRedirect("login.jsp?logout=true");
        return;
    }

    ProfesorDAO dao = new ProfesorDAO();
    List<Profesor> lista = dao.listar();
%>

<%
    System.out.println("[JSP] Profesores recuperados: " + lista.size());
%>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Profesores</title>
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
            <div class="content-header">
                <div class="container-fluid">
                    <% if ("administrador".equals(rol) || "profesor".equals(rol)  ){ %>
                        <div class="d-flex justify-content-end mb-3">
                            <a href="registroProfesor.jsp" class="btn btn-success">
                                <i class="fas fa-plus-circle"></i> Registrar nuevo profesor
                            </a>
                        </div>
                    <% } %>
                    <h4 class="mb-3 text-primary">
                        <i class="fas fa-chalkboard-teacher"></i> Listado de Profesores
                    </h4>
                </div>
            </div>

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
                                    <th>Acciones</th>
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
                                        <td class="text-center">
                                            <!-- Botón Cursos asignados -->
                                            <a href="CursoLibreServlet?accion=listarPorProfesor&id=<%= p.getId() %>" 
                                               class="btn btn-sm btn-info" 
                                               title="Ver cursos asignados">
                                                <i class="fas fa-book"></i>
                                            </a>

                                            <!-- Botón Estudiantes inscritos -->
                                            <a href="EstudianteServlet?accion=listarPorProfesor&id=<%= p.getId() %>" 
                                               class="btn btn-sm btn-primary" 
                                               title="Ver estudiantes inscritos">
                                                <i class="fas fa-users"></i>
                                            </a>

                                            <!-- Botón Editar -->
                                            <a href="editarProfesor.jsp?id=<%= p.getId() %>" 
                                               class="btn btn-sm btn-warning" 
                                               title="Editar profesor">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <%
                                                // Normalizar el estado para evitar errores por espacios o mayúsculas
                                                String estado = p.getEstado() != null ? p.getEstado().trim().toLowerCase() : "";
                                            %>

                                            <% if ("inactivo".equals(estado)) { %>
                                                <!-- Botón Activar -->
                                                <a href="ProfesorServlet?accion=activar&id=<%= p.getId() %>" 
                                                   class="btn btn-sm btn-success" 
                                                   title="Activar profesor"
                                                   onclick="return confirm('¿Activar este profesor?');">
                                                    <i class="fas fa-check-circle"></i>
                                                </a>

                                                <!-- Botón Eliminar definitivo (solo si está inactivo) -->
                                                <a href="ProfesorServlet?accion=eliminar&id=<%= p.getId() %>" 
                                                   class="btn btn-sm btn-danger" 
                                                   title="Eliminar definitivamente"
                                                   onclick="return confirm('⚠ ¿Está seguro de eliminar definitivamente este profesor?');">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            <% } else { %>
                                                <!-- Botón Inactivar -->
                                                <a href="ProfesorServlet?accion=inactivar&id=<%= p.getId() %>" 
                                                   class="btn btn-sm btn-secondary" 
                                                   title="Inactivar profesor"
                                                   onclick="return confirm('¿Marcar este profesor como inactivo?');">
                                                    <i class="fas fa-ban"></i>
                                                </a>
                                            <% } %>
                                        </td>

                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div> 
            </div>
        </section>
        <jsp:include page="componentes/footer.jsp" />                    
    </div>

    
</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>

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