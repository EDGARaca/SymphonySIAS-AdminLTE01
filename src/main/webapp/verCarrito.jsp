<%-- 
    Document   : verCarrito
    Created on : 11/11/2025, 2:43:16 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.ItemCarrito" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h1 class="text-primary">Resumen de tu carrito</h1>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <%
                List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
                double total = 0;
                if (carrito != null && !carrito.isEmpty()) {
            %>            
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Producto</th>
                        <th>Descripción</th>
                        <th>Precio Unitario</th>
                        <th>Descuento</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (ItemCarrito item : carrito) {
                            double subtotal = item.getSubtotalConDescuento();
                            total += subtotal;
                    %>
                    <tr>
                        <td><%= item.getProducto().getNombre() %></td>
                        <td><%= item.getProducto().getDescripcion() %></td>
                        <td>$<%= item.getProducto().getPrecio() %></td>
                        <td>
                            <%= item.getProducto().isOfertaActiva() ? item.getProducto().getDescuento() + "%" : "—" %>
                        </td>
                        <td><%= item.getCantidad() %></td>
                        <td>$<%= subtotal %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
                <tfoot>
                    <tr class="table-secondary">
                        <td colspan="5" class="text-end fw-bold">Total:</td>
                        <td class="fw-bold text-success">$<%= total %></td>
                    </tr>
                </tfoot>
            </table>
                    
            <div class="mt-4 d-flex justify-content-between">
                <a href="catalogoProductos.jsp" class="btn btn-outline-primary">
                    ← Seguir comprando
                </a>
                <a href="FinalizarCompraServlet" class="btn btn-success">
                    Finalizar compra
                </a>
            </div>

            <%
                } else {
            %>
            <div class="alert alert-warning">
                Tu carrito está vacío. <a href="catalogoProductos.jsp">Ir al catálogo</a>
            </div>
            <%
                }
            %>
        </div>
    </section>
</div>


<jsp:include page="componentes/footer.jsp" />