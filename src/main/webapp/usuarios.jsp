<%-- 
    Document   : usuario.jsp
    Created on : 4/10/2025, 10:30:17 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.mycom.symphonysias.adminlte01.dao.UsuarioDAO" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.Usuario" %>
<%@ page import="java.util.List" %>


<%
    // Validación de sesion y rol
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;
    
    if (usuario == null || !"ADMIN".equals(rol)) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    // Trazabilidad en consola del servidor
    System.out.println("[USUARIOS] Acceso autorizado por: " + usuario + " (" + rol + ")" );
    
    //Instanciación del DAO y recuperación de usuarios
    UsuarioDAO dao = new UsuarioDAO();
    List<Usuario> usuarios = dao.listarUsuarios();
    System.out.println("[DEBUG] Total usuarios encontrados: + usuarios.size()");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestion de Usuarios - SymphonySIAS</title>
        <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="assets/adminlte/dist/css/adminlte.min.css">
        <%-- DataTables CSS --%>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap4.min.css">      
        
        <%-- jQuery y DataTables JS --%>
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
            
            <%-- Navbar --%>
            <jsp:include page="header.jsp" />
            
            <%-- Sidebar --%>
            <jsp:include page="sidebar.jsp" />
            
            <%-- Content --%>
            <div class="content-wrapper">
                <section class="content-header">
                    <div class="container-fluid">
                        <h1 class="m-0">Gestión de Usuarios</h1>                                      
                    </div>
                </section>
                    
                <section class="content">
                                
                    <div class="container-fluid">
                        <%-- Validación de mensaje de éxito o error tras editar --%>
                        <%
                            String actualizado = request.getParameter("actualizado");
                            String error = request.getParameter("error");

                            if ("true".equals(actualizado)) {
                        %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>¡Usuario actualizado!</strong> Los cambios se guardaron correctamente.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        <%
                            } else if ("actualizacion".equals(error)) {
                        %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error al actualizar.</strong> No se pudo guardar los cambios. Intenta nuevamente.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        <%
                            }
                        %>
                        
                        <div class="card">                        
                            <div class="card-header bg-secondary text-white">
                                <h3 class="card-title"><i class="fas fa-users-cog"></i>Gestion de Usuarios</h3>                           
                            </div>
                            <div class="card-body">
                                <table id= "tablaUsuarios" class="table table-bordered table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Usuario</th>
                                        <th>Rol</th>
                                        <th>Estado</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Usuario u : usuarios){
                                        String claseFila = "";
                                        switch (u.getRol()) {
                                            case "ADMIN": claseFila = "table-danger"; break;
                                            case "DOCENTE": claseFila ="table-warning"; break;
                                            case "EESTUDIANTE":claseFila ="table-seccess"; break;
                                            case "FUNCIONARIO":claseFila ="table-info"; break;
                                            default: claseFila = "";
                                        }
                                    %>                                
                                    <tr class="<%= claseFila %>">
                                        <td><%= u.getId() %></td>
                                        <td><%= u.getNombre() %></td>
                                        <td><%= u.getUsuario() %></td>
                                        <td><%= u.getRol() %></td>
                                        <td><%= u.isActivo() ? "Activo" : "Inactivo" %></td> 
                                        <td>
                                            <button class="btn btn-sm btn-primary" title="Editar"
                                                onclick="abrirModalEditar('<%= u.getId() %>', '<%= u.getNombre() %>', '<%= u.getUsuario() %>', '<%= u.getRol() %>', '<%= u.isActivo() ? "Activo" : "Inactivo" %>')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger" title="Eliminar"><i class="fas fa-trash-alt"></i></button>
                                        </td>
                                    </tr>                                
                                    <% } %>
                                </tbody>
                                </table>
                            </div>
                        </div>    
                    </div>
                </section>                    
            </div>
                    
            <%-- Footer --%>
            <jsp:include page="footer.jsp" />
                            
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
        
        <%-- Modal de edición de usuario --%>
        <div class="modal fade" id="modalEditarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalEditarUsuarioLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form action="EditarUsuarioServlet" method="post">
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
                                <label for="editRol">Rol</label>
                                <select class="form-control" id="editRol" name="rol">
                                    <option>ADMIN</option>
                                    <option>DOCENTE</option>
                                    <option>ESTUDIANTE</option>
                                    <option>FUNCIONARIO</option>
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
            // Función que se llama al hacer clic en el botón "Editar"
            function abrirModalEditar(id, nombre, usuario, rol, estado) {
                // Asignar valores a los campos del modal
                document.getElementById("editId").value = id;
                document.getElementById("editNombre").value = nombre;
                document.getElementById("editUsuario").value = usuario;
                document.getElementById("editRol").value = rol;
                document.getElementById("editEstado").value = estado  === 'Activo' ? 'true' : 'false';

                // Mostrar el modal correctamente (corregido el ID)
                $('#modalEditarUsuario').modal('show');
            }
        </script>
        
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <%-- Script de Bootstrap para que las alertas y modales funcionen --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        
        <%-- Cierra automáticamente las alertas después de 4 segundos --%>
        <script>
            setTimeout(function() {
            $(".alert").alert('close');
            }, 4000);
        </script>

    </body>
</html>
