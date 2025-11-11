<%-- 
    Document   : confirmacionCompra
    Created on : 10/11/2025, 8:40:20 p. m.
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
        <h1>Confirmación de Compra</h1>
    </section>

    <section class="content">
        <% if (carrito == null || carrito.isEmpty()) { %>
            <p>No hay productos en el carrito.</p>
        <% } else { %>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (ItemCarrito item : carrito) {
                        double subtotal = item.getSubtotal();
                        total += subtotal;
                    %>
                        <tr>
                            <td><%= item.getProducto().getNombre() %></td>
                            <td><%= item.getCantidad() %></td>
                            <td>$<%= subtotal %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <h4>Total a pagar: $<%= total %></h4>
            <form action="finalizar-compra" method="post">
                <button type="submit" class="btn btn-success">Registrar compra</button>
            </form>
        <% } %>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />
