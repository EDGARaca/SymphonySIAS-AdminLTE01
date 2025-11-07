<%--
    Document    : listarUsuarios.jsp
    Created on : 01/11/2025, 10:03 a.m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Usuario" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioActivo") == null) {
        response.sendRedirect("login.jsp?logout=true");
        return;
    }
%>

<!-- Alertas visuales -->
<% if ("camposIncompletos".equals(request.getParameter("error"))) { %>
    <div class="alert alert-warning">Debes completar todos los campos antes de registrar.</div>
<% } %>

<!-- Filtros -->
<form action="BuscarUsuariosServlet" method="get" class="mb-4">
    <div class="row">
        <div class="col-md-3">
            <input type="text" name="nombre" class="form-control" placeholder="Buscar por nombre"
                   value="<%= request.getParameter("nombre") != null ? request.getParameter("nombre") : "" %>">
        </div>
        <div class="col-md-3">
            <select name="rol" class="form-control">
                <option value="">-- Rol --</option>
                <option value="ADMINISTRADOR SIAS">ADMINISTRADOR SIAS</option>
                <option value="DIRECTOR">DIRECTOR</option>
                <option value="COORDINADOR ACADÉMICO">COORDINADOR ACADÉMICO</option>
                <option value="AUXILIAR ADMINISTRATIVO">AUXILIAR ADMINISTRATIVO</option>
                <option value="AUXILIAR CONTABLE">AUXILIAR CONTABLE</option>
                <option value="DOCENTE">DOCENTE</option>
                <option value="ESTUDIANTE">ESTUDIANTE</option>
            </select>
        </div>
        <div class="col-md-3">
            <select name="estado" class="form-control">
                <option value="">-- Estado --</option>
                <option value="true">Activo</option>
                <option value="false">Inactivo</option>
            </select>
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-info btn-block">
                <i class="fas fa-search"></i> Filtrar
            </button>
        </div>
    </div>
</form>

<!-- Botones -->
<div class="row mb-3">
    <div class="col-md-6">
        <button class="btn btn-success" data-toggle="modal" data-target="#modalNuevoUsuario">
            <i class="fas fa-user-plus"></i> Registrar Usuario
        </button>
    </div>
    <div class="col-md-4 text-center">
        <a href="ListarUsuariosServlet" class="btn btn-outline-primary">
            <i class="fas fa-sync-alt"></i> Actualizar vista
        </a>
    </div>
    <div class="col-md-6 text-right">
        <a href="ExportarUsuariosPDFServlet" class="btn btn-danger">
            <i class="fas fa-file-pdf"></i> Exportar PDF
        </a>
    </div>
</div>

<!-- Tabla de usuarios -->
<table id="tablaUsuarios" class="table table-bordered table-hover">
    <thead class="thead-light">
        <tr>
            <th>Nombre</th>
            <th>Usuario</th>
            <th>Correo</th>
            <th>Rol</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
            if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                for (Usuario u : listaUsuarios) {
        %>
        <tr>
            <td><%= u.getNombre() %></td>
            <td><%= u.getUsuario() %></td>
            <td><%= u.getCorreo() %></td>
            <td><%= u.getRol() %></td>
            <td><%= u.isActivo() ? "Activo" : "Inactivo" %></td>
            <td>
                <button class="btn btn-sm btn-primary" onclick="abrirModalEditar('<%= u.getId() %>', '<%= u.getNombre() %>', '<%= u.getUsuario() %>', '<%= u.getCorreo() %>', '<%= u.getRol() %>', '<%= u.isActivo() %>')">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="btn btn-sm btn-danger" onclick="confirmarEliminacion('<%= u.getId() %>')">
                    <i class="fas fa-trash-alt"></i>
                </button>
                <a href="ActualizarEstadoUsuarioServlet?id=<%= u.getId() %>&estado=<%= !u.isActivo() %>" class="btn btn-sm <%= u.isActivo() ? "btn-warning" : "btn-success" %>">
                    <i class="fas <%= u.isActivo() ? "fa-toggle-off" : "fa-toggle-on" %>"></i>
                </a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="6" class="text-center text-muted">No se encontraron usuarios registrados.</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<!-- Modal: Nuevo Usuario -->

    <!-- Modal: Nuevo Usuario -->
    <div class="modal fade" id="modalNuevoUsuario" tabindex="-1">
        <div class="modal-dialog">
            <form action="RegistrarUsuarioServlet" method="post">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title"><i class="fas fa-user-plus"></i> Registrar Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <input type="text" name="nombre" class="form-control mb-2" placeholder="Nombre completo" required>
                        <input type="text" name="usuario" class="form-control mb-2" placeholder="Usuario" required>
                        <input type="email" name="correo" class="form-control mb-2" placeholder="Correo electrónico" required>
                        <select name="rol" class="form-control mb-2" required>
                            <option value="">-- Rol --</option>
                            <option value="ADMINISTRADOR SIAS">ADMINISTRADOR SIAS</option>
                            <option value="DIRECTOR">DIRECTOR</option>
                            <option value="COORDINADOR ACADÉMICO">COORDINADOR ACADÉMICO</option>
                            <option value="AUXILIAR ADMINISTRATIVO">AUXILIAR ADMINISTRATIVO</option>
                            <option value="AUXILIAR CONTABLE">AUXILIAR CONTABLE</option>
                            <option value="DOCENTE">DOCENTE</option>
                            <option value="ESTUDIANTE">ESTUDIANTE</option>
                        </select>
                        <select name="estado" class="form-control" required>
                            <option value="true">Activo</option>
                            <option value="false">Inactivo</option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Registrar</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal: Editar Usuario -->
    <div class="modal fade" id="modalEditarUsuario" tabindex="-1">
        <div class="modal-dialog">
            <form action="ActualizarUsuarioServlet" method="post">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Editar Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editId">
                        <input type="text" name="nombre" id="editNombre" class="form-control mb-2" required>
                        <input type="text" name="usuario" id="editUsuario" class="form-control mb-2" required>
                        <input type="email" name="correo" id="editCorreo" class="form-control mb-2" required>
                        <select name="rol" id="editRol" class="form-control mb-2" required>
                            <option value="">-- Rol --</option>
                            <option value="ADMINISTRADOR SIAS">ADMINISTRADOR SIAS</option>
                            <option value="DIRECTOR">DIRECTOR</option>
                            <option value="COORDINADOR ACADÉMICO">COORDINADOR ACADÉMICO</option>
                            <option value="AUXILIAR ADMINISTRATIVO">AUXILIAR ADMINISTRATIVO</option>
                            <option value="AUXILIAR CONTABLE">AUXILIAR CONTABLE</option>
                            <option value="DOCENTE">DOCENTE</option>
                            <option value="ESTUDIANTE">ESTUDIANTE</option>
                        </select>
                        <select name="estado" id="editEstado" class="form-control" required>
                            <option value="true">Activo</option>
                            <option value="false">Inactivo</option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Actualizar</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts JS -->
   
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>

    <script>
        $(document).ready(function () {
            $('#tablaUsuarios').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
                },
                dom: 'Bfrtip',
                buttons: ['copy', 'excel', 'pdf', 'print']
            });
        });

        function abrirModalEditar(id, nombre, usuario, correo, rol, estado) {
            $('#editId').val(id);
            $('#editNombre').val(nombre);
            $('#editUsuario').val(usuario);
            $('#editCorreo').val(correo);
            $('#editRol').val(rol);
            $('#editEstado').val(estado === 'true' ? 'true' : 'false');
            $('#modalEditarUsuario').modal('show');
        }

        function confirmarEliminacion(id) {
            if (confirm("¿Está seguro de que desea eliminar este usuario?")) {
                window.location.href = "EliminarUsuarioServlet?id=" + id;
            }
        }
    </script>