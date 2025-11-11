<%-- 
    Document   : carrito
    Created on : 10/11/2025, 8:24:36 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.ItemCarrito, com.mycom.symphonysias.adminlte01.modelo.ProductoMusical" %>
<jsp:include page="header.jsp" />
<jsp:include page="sidebar.jsp" />

<%
    List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
    double total = 0;
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Carrito de Compras</h1>
    </section>

    <section class="content">
        <% if (carrito == null || carrito.isEmpty()) { %>
            <p>No hay productos en el carrito.</p>
        <% } else { %>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio Unitario</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (ItemCarrito item : carrito) {
                        ProductoMusical p = item.getProducto();
                        double precioFinal = p.isOfertaActiva()
                            ? p.getPrecio() * (1 - p.getDescuento())
                            : p.getPrecio();
                        double subtotal = precioFinal * item.getCantidad();
                        total += subtotal;
                    %>
                        <tr>
                            <td><%= p.getNombre() %></td>
                            <td>$<%= precioFinal %></td>
                            <td><%= item.getCantidad() %></td>
                            <td>$<%= subtotal %></td>
                            <td>
                                <form action="eliminar-carrito" method="post">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash"></i> Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <h4>Total: $<%= total %></h4>
            <a href="confirmacionCompra.jsp" class="btn btn-success">Finalizar compra</a>
        <% } %>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />