<%-- 
    Document   : adminProductos
    Created on : 11/11/2025, 8:11:01 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %> 
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.ProductoMusical" %>
<%@ page import="com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO" %>

<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapperd-flex flex-column" style="min-height: calc(100vh - 56px);">

    <section class="content-header">
        <div class="container-fluid">
            <h1 class="text-primary">Administrar Productos Musicales</h1>
            <a href="formProducto.jsp" class="btn btn-success mt-2">
                <i class="fas fa-plus-circle me-1"></i> Agregar nuevo producto
            </a>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <table class="table table-bordered table-hover mt-3">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Descuento</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ProductoMusicalDAO dao = new ProductoMusicalDAO();
                        List<ProductoMusical> productos = dao.listar();
                        for (ProductoMusical p : productos) {
                            String imagenFinal = (p.getRutaImagen() != null && !p.getRutaImagen().isEmpty()) 
                                ? p.getRutaImagen() 
                                : p.getImagen();
                    %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getNombre() %></td>
                        <td><%= p.getDescripcion() %></td>
                        <td>$<%= p.getPrecio() %></td>
                        <td><%= p.getDescuento() %>%</td>
                        <td>
                            <% if (imagenFinal != null && !imagenFinal.isEmpty()) { %>
                                <img src="<%= imagenFinal %>" alt="Imagen" style="height: 60px;">
                            <% } else { %>
                                <span class="text-muted">Sin imagen</span>
                            <% } %>
                        </td>
                        <td>
                            <a href="EditarProductoServlet?id=<%= p.getId() %>" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="EliminarProductoServlet?id=<%= p.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar este producto?');">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />

