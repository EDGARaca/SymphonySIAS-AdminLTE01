<%-- 
    Document   : listarCursoLibre.jsp
    Created on : 30/10/2025, 10:12:12 p. m.
    Author     : Spiri
--%>


<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO"%>

<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null) {
        response.sendRedirect("login.jsp?logout=true");
        return;
    }

    // Acceso permitido para roles institucionales y estudiante en modo visualización
    boolean accesoPermitido = rol.equalsIgnoreCase("ADMINISTRADOR SIAS") ||
                              rol.equalsIgnoreCase("COORDINADOR ACADÉMICO") ||
                              rol.equalsIgnoreCase("DIRECTOR") ||
                              rol.equalsIgnoreCase("ESTUDIANTE");

    if (!accesoPermitido) {
        response.sendRedirect("login.jsp?logout=true");
        return;
    }

    CursoLibreDAO dao = new CursoLibreDAO();
    List<CursoLibre> lista = dao.listar();
    System.out.println("[JSP] Total cursos libres cargados: " + lista.size());
%>


<%
    System.out.println("🧪 Usuario activo: " + usuario);
    System.out.println("🧪 Rol activo: " + rol);
%>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Cursos Libres</title>
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
                    <% if ("administrador".equals(rol)) { %>
                        <div class="d-flex justify-content-end mb-3">
                            <a href="registroCursoLibre.jsp" class="btn btn-success">
                                <i class="fas fa-plus-circle"></i> Registrar nuevo curso
                            </a>
                        </div>
                    <% } %>
                    <h4 class="mb-3 text-success">
                        <i class="fas fa-book-open"></i> Cursos Libres Registrados
                    </h4>
                </div>
            </div>

            <div class="container-fluid">
                <% String registrado = request.getParameter("registrado");
                   String editado = request.getParameter("editado");
                   String eliminado = request.getParameter("eliminado");
                   String error = request.getParameter("error");
                %>

                <% if (registrado != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>✔ Curso registrado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (editado != null) { %>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <strong>✎ Curso editado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (eliminado != null) { %>
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <strong>? Curso eliminado correctamente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } else if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>⚠ Ocurrió un error al procesar la solicitud.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } %>
                
                <% String eliminadoFisico = request.getParameter("eliminadoFisico"); %>

                <% if (eliminadoFisico != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>🗑 Curso eliminado permanentemente.</strong>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } %>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-list-alt"></i> Cursos registrados
                        </h5>
                        <div class="card-tools">
                            <a href="ExportarCursosLibresServlet" class="btn btn-sm btn-outline-light">
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

                        <table class="table table-bordered table-hover table-striped text-center">
                            <thead class="thead-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Profesor</th>
                                    <th>Valor</th>
                                    <th>Frecuencia</th>
                                    <th>Estado</th>
                                    <th>Usuario que registró</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (CursoLibre c : lista) { %>
                                    <tr>
                                        <td><%= c.getId() %></td>
                                        <td><%= c.getNombre() %></td>
                                        <td><%= (c.getNombreProfesor() != null && !c.getNombreProfesor().trim().isEmpty()) ? c.getNombreProfesor() : "Sin asignar" %></td>
                                        <td>$<%= c.getValor() %></td>
                                        <td><%= c.getFrecuencia() %></td>
                                        <td><%= c.getEstado() %></td>
                                        <td><%= c.getUsuario_registro() %></td>
                                        <td>
                                        <% if ("ESTUDIANTE".equalsIgnoreCase(rol) || "ADMINISTRADOR SIAS".equalsIgnoreCase(rol)) { %>
                                            <form action="InscripcionCursoLibreServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="id_curso" value="<%= c.getId() %>">
                                                <input type="hidden" name="id_estudiante" value="<%= session.getAttribute("idUsuarioActivo") %>">
                                                <button type="submit" class="btn btn-success btn-sm">Inscribirme</button>
                                            </form>
                                        <% } %>  
                                        
                                        <%
                                            System.out.println("[JSP] Curso: " + c.getNombre() + " | Profesor: " + c.getNombreProfesor());
                                            System.out.println("[JSP] Rol activo: " + rol);
                                        %>
                                            <a href="editarCursoLibre.jsp?id=<%= c.getId() %>&usuario=<%= usuario %>" class="btn btn-sm btn-warning" title="Editar curso">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <% if ("activo".equals(c.getEstado())) { %>
                                                <a href="RegistroCursoLibreServlet?accion=desactivar&id=<%= c.getId() %>&usuario=<%= usuario %>" class="btn btn-sm btn-danger" title="Desactivar curso" onclick="return confirm('¿Desactivar este curso?');">
                                                    <i class="fas fa-ban"></i>
                                                </a>
                                            <% } else { %>
                                                <a href="RegistroCursoLibreServlet?accion=activar&id=<%= c.getId() %>&usuario=<%= usuario %>" class="btn btn-sm btn-success" title="Activar curso" onclick="return confirm('¿Activar este curso?');">
                                                    <i class="fas fa-check-circle"></i>
                                                </a>
                                            <% } %>
                                            <a href="RegistroCursoLibreServlet?accion=eliminarFisico&id=<%= c.getId() %>&usuario=<%= usuario %>" 
                                                class="btn btn-sm btn-outline-danger" 
                                                title="Eliminar definitivamente" 
                                                onclick="return confirm('⚠ Esta acción eliminará el curso de forma permanente. ¿Continuar?');">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
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