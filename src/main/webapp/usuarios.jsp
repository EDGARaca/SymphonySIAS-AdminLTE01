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
                                            <button class="btn btn-sm btn-primary" title="Editar"><i class="fas fa-edit"></i></button>
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
    </body>
</html>
