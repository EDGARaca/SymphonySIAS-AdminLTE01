<%-- 
    Document   : usuario.jsp
    Created on : 4/10/2025, 10:30:17 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.Usuario" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>



<%
    String actualizadoParam = request.getParameter("actualizado");
    String actualizadoAttr = (String) request.getAttribute("actualizado");
    
    String errorParam = request.getParameter("error");
    String errorAttr = (String) request.getAttribute("error");
%>

<%
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestion de Usuarios - SymphonySIAS</title>
        <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
        <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
        
        
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap4.min.css">      
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
                
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap4.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
        
    </head>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">
            
            
            <jsp:include page="header.jsp" />
           
            <jsp:include page="sidebar.jsp" />
            
            <jsp:include page="footer.jsp" />
            
            
            <div class="content-wrapper">
                <section class="content-header">
                    <div class="container-fluid">
                        <h1 class="m-0 mb-3">Gestión de Usuarios</h1>
                                               
                        <!-- Validación de mensaje tras creación de usuario -->        
                        <!-- Sección de alertas -->
                        <!-- Validación de mensaje de éxito o error tras editar -->
                        <!-- Esto asegura que el mensaje se muestre correctamente tras una edición por POST -->
                        
                        <% if ("true".equals(request.getParameter("actualizado")) || "true".equals(request.getAttribute("actualizado"))) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>¡Usuario actualizado!</strong> Los cambios se guardaron correctamente48.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        <% } else if ("actualizacion".equals(request.getParameter("error")) || "actualizacion".equals(request.getAttribute("error"))) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error al actualizar.</strong> No se pudo guardar los cambios. Intenta nuevamente.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        <% } else if ("true".equals(request.getParameter("creado")) || "true".equals(request.getAttribute("creado"))) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>¡Usuario creado!</strong> El nuevo usuario fue registrado correctamente36.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        <% } else if ("creacion".equals(request.getParameter("error")) || "creacion".equals(request.getAttribute("error"))) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error al crear usuario.</strong> No se pudo completar el registro.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            
                        <% } else if ("true".equals(request.getParameter("eliminado")) || "true".equals(request.getAttribute("eliminado"))) { %>
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <strong>¡Usuario eliminado!</strong> El registro fue borrado correctamente.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            
                        <% } %>
                         
                    </div>
                </section>
                    
                <section class="content">
                                
                    <div class="container-fluid">

                        <div class="card">                        
                            <div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
                                <h3 class="card-title mb-0"><i class="fas fa-users-cog"></i> Gestión de Usuarios</h3>

                                <!-- Botón para abrir el modal de nuevo usuario -->
                                <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#modalNuevoUsuario">
                                    <i class="fas fa-user-plus"></i> Nuevo Usuario
                                </button>
                                
                                <a href="ExportarUsuariosServlet" class="btn btn-sm btn-outline-success">
                                    <i class="fas fa-file-pdf"></i> Exportar PDF
                                </a>
                                <% if (request.getParameter("sinDatos") != null) { %>
                                <div class="alert alert-warning text-center">
                                    <i class="fas fa-exclamation-triangle"></i> No hay usuarios registrados para exportar.
                                </div>
                                <% } %>

                                <% if (request.getParameter("exportado") != null) { %>
                                    <div class="alert alert-success text-center">
                                        <i class="fas fa-file-export"></i> Exportación completada correctamente.
                                    </div>
                                <% } %>
                            </div>
                            <div class="card-body">
                                <table id= "tablaUsuarios" class="table table-bordered table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Usuario</th>
                                        <th>Correo</th>
                                        <th>Rol</th>
                                        <th>Estado</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <%
                                        List<Usuario> usuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
                                        if (usuarios != null && !usuarios.isEmpty()) {
                                            for (Usuario u : usuarios) {
                                                String claseFila = "";
                                                switch (u.getRol()) {
                                                    case "ADMINISTRADOR SIAS": claseFila = "table-danger"; break;
                                                    case "DIRECTOR": claseFila = "table-primary"; break;
                                                    case "COORDINADOR ACADÉMICO": claseFila = "table-warning"; break;
                                                    case "AUXILIAR ADMINISTRATIVO": claseFila = "table-info"; break;
                                                    case "AUXILIAR CONTABLE": claseFila = "table-secondary"; break;
                                                    case "DOCENTE": claseFila = "table-success"; break;
                                                    case "ESTUDIANTE": claseFila = "table-light"; break;
                                                    default: claseFila = "";
                                                }
                                    %>
                                        <tr class="<%= claseFila %>">
                                            <td><%= u.getId() %></td>
                                            <td><%= u.getNombre() %></td>
                                            <td><%= u.getUsuario() %></td>
                                            <td><%= u.getCorreo() %></td>
                                            <td><%= u.getRol() %></td>
                                            <td><%= u.isActivo() ? "Activo" : "Inactivo" %></td>
                                            <td>
                                                <%
                                                    String rolActivo = (String) session.getAttribute("rolActivo");
                                                    if ("administrador".equalsIgnoreCase(rolActivo) ||
                                                        "director".equalsIgnoreCase(rolActivo) ||
                                                        "coordinador académico".equalsIgnoreCase(rolActivo)) {
                                                %>
                                                    <button class="btn btn-sm btn-primary" title="Editar"
                                                        onclick="abrirModalEditar(
                                                            '<%= u.getId() %>',
                                                            '<%= u.getNombre() %>',
                                                            '<%= u.getUsuario() %>',
                                                            '<%= u.getCorreo() %>',
                                                            '<%= u.getRol() %>',
                                                            '<%= u.isActivo() ? "Activo" : "Inactivo" %>',
                                                            ''
                                                        )">
                                                        <i class="fas fa-edit"></i> Editar
                                                    </button>
                                                    <button class="btn btn-sm btn-danger" title="Eliminar"
                                                            onclick="confirmarEliminacion('<%= u.getId() %>')">
                                                        <i class="fas fa-trash-alt"></i> Eliminar
                                                    </button>
                                                <%
                                                    }
                                                %>
                                            </td>
                                        </tr>
                                    <%
                                            } // cierre del for
                                        } else {
                                    %>
                                        <tr>
                                            <td colspan="7" class="text-center text-warning">No hay usuarios registrados.</td>
                                        </tr>
                                    <%
                                        } // cierre del if
                                    %>
                                </tbody>
                                </table>
                            </div>
                        </div>    
                    </div>
                </section>                    
            </div>                                               
        </div>       
    
        <script>
        $(document).ready(function() {
            $('#tablaUsuarios').DataTable({
                responsive: true,
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
                },
                dom: 'Bfrtip',
                buttons: [
                    {
                     extend: 'copy',
                     text: '<i class="fas fa-copy"></i> Copiar',
                     className: 'btn btn-secondary btn-sm'
                    },
                    {
                     extend: 'excel',
                     text: '<i class="fas fa-file-excel"></i> Excel',
                     className: 'btn btn-success btn-sm'
                    },
                    {
                     extend: 'pdf',
                     text: '<i class="fas fa-file-pdf"></i> PDF',
                     className: 'btn btn-danger btn-sm'
                    },
                    {
                     extend: 'print',
                     text: '<i class="fas fa-print"></i> Imprimir',
                     className: 'btn btn-info btn-sm'
                    }
                ]
            });
        });   
        </script>
        
       
        <div class="modal fade" id="modalEditarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalEditarUsuarioLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form action="EditarUsuarioServlet" method="post" accept-charset="UTF-8">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="modalEditarUsuarioLabel"><i class="fas fa-edit"></i> Editar Usuario</h5>
                            <button type="button" class="close text-white" data-dismiss="modal" aria-label="Cerrar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="editId" name="id">
                            <div class="form-group">
                                <label for="editNombre">Nombre</label>
                                <input type="text" class="form-control" id="editNombre" name="nombre" required>
                            </div>
                            <div class="form-group">
                                <label for="editUsuario">Usuario</label>
                                <input type="text" class="form-control" id="editUsuario" name="usuario" required>
                            </div>
                            <div class="form-group">
                                <label for="editClave">Clave</label>
                                <input type="password" class="form-control" id="editClave" name="clave" placeholder="(solo si desea cambiar)">
                            </div>
                            <div class="form-group">
                                <label for="editCorreo">Correo</label>
                                <input type="email" class="form-control" id="editCorreo" name="correo" required>
                            </div>
                            <div class="form-group">
                                <label for="editRol">Rol</label>
                                <select class="form-control" id="editRol" name="rol">
                                    <option>ADMIN SIAS</option>
                                    <option>Director</option>
                                    <option>Coord. Acad</option>
                                    <option>Aux. Admin</option>
                                    <option>Aux. Contable</option>
                                    <option>Docente</option>
                                    <option>Estudiante</option>
                                    <option>PRUEBA</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editEstado">Estado</label>
                                <select class="form-control" id="editEstado" name="estado">
                                    <option value="true">Activo</option>
                                    <option value="false">Inactivo</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success"><i class="fas fa-save"></i>Guardar cambios</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <script>
           
            function abrirModalEditar(id, nombre, usuario, rol, estado) {
                // Asignar valores a los campos del modal
                document.getElementById("editId").value = id;
                document.getElementById("editNombre").value = nombre;
                document.getElementById("editUsuario").value = usuario;
                document.getElementById("editRol").value = rol;
                document.getElementById("editEstado").value = estado  === 'Activo' ? 'true' : 'false';

               
                $('#modalEditarUsuario').modal('show');
            }
        </script>
        
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Script de Bootstrap para que las alertas y modales funcionen -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        
       
        <script>
            setTimeout(function() {
            $(".alert").alert('close');
            }, 7000);
        </script>
        
       
        <div class="modal fade" id="modalNuevoUsuario" tabindex="-1" role="dialog" aria-labelledby="modalNuevoUsuarioLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form action="CrearUsuarioServlet" method="post" accept-charset="UTF-8">
                    <div class="modal-content">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title" id="modalNuevoUsuarioLabel"><i class="fas fa-user-plus"></i> Nuevo Usuario</h5>
                            <button type="button" class="close text-white" data-dismiss="modal" aria-label="Cerrar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="nuevoNombre">Nombre</label>
                                <input type="text" class="form-control" id="nuevoNombre" name="nombre" required>
                            </div>
                        <div class="form-group">
                            <label for="nuevoUsuario">Usuario</label>
                            <input type="text" class="form-control" id="nuevoUsuario" name="usuario" required>
                        </div>
                        <div class="form-group">
                            <label for="nuevoCorreo">Correo</label>
                            <input type="email" class="form-control" id="nuevoCorreo" name="correo" required>
                        </div>                           
                        <div class="form-group">
                          <label for="nuevoClave">Clave</label>
                          <input type="password" class="form-control" id="nuevoClave" name="clave" required>
                        </div>
                        <div class="form-group">
                          <label for="nuevoRol">Rol</label>
                          <select class="form-control" id="nuevoRol" name="rol">
                            <option>ADMIN</option>
                                    <option>Director</option>
                                    <option>Coord. Acad</option>
                                    <option>Aux. Admin</option>
                                    <option>Aux. Contable</option>
                                    <option>Docente</option>
                                    <option>Estudiante</option>
                                    <option>PRUEBA</option>
                          </select>
                        </div>
                        <div class="form-group">
                          <label for="nuevoEstado">Estado</label>
                          <select class="form-control" id="nuevoEstado" name="estado">
                            <option value="true">Activo</option>
                            <option value="false">Inactivo</option>
                          </select>
                        </div>
                        </div>
                        <div class="modal-footer">
                          <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Registrar</button>
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                  </form>
                </div>
              </div>
        
        <script>
        function abrirModalEditar(id, nombre, usuario, correo, rol, estado, clave) {
            document.getElementById("editId").value = id;
            document.getElementById("editNombre").value = nombre;
            document.getElementById("editUsuario").value = usuario;
            document.getElementById("editCorreo").value = correo;
            document.getElementById("editRol").value = rol;
            document.getElementById("editEstado").value = (estado === "Activo") ? "true" : "false";
            document.getElementById("editClave").value = clave;

            $('#modalEditarUsuario').modal('show');
        }
        </script>
        
        <script>
        function confirmarEliminacion(idUsuario) {
            if (confirm("¿Estás seguro de que deseas eliminar este usuario?")) {
                window.location.href = "EliminarUsuarioServlet?id=" + idUsuario;
            }
        }
        </script>
        
        <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
        <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/adminlte/js/adminlte.min.js"></script> 
    
    </body>
</html>
