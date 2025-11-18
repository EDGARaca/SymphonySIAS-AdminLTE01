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
                String mensaje = (String) session.getAttribute("mensajeCompra");
                if (mensaje != null) {
            %>
                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                    <h4 class="alert-heading"><i class="fas fa-check-circle"></i> ¡Gracias por tu compra!</h4>
                    <p><%= mensaje %></p>
                    <hr>
                    <p class="mb-0">Puedes revisar tus pedidos o seguir explorando nuevos productos.</p>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
                </div>
            <%
                    session.removeAttribute("mensajeCompra");
                }
            %>
      
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
                    
            <div class="d-flex justify-content-center gap-3 mt-4">
                <a href="catalogoProductos.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-shopping-bag"></i> Seguir comprando
                </a>
                <a href="misPedidos.jsp" class="btn btn-outline-secondary">
                    <i class="fas fa-box"></i> Ver mis pedidos
                </a>
                <form action="<%= request.getContextPath() %>/FinalizarCompraServlet" method="post">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-credit-card"></i> Finalizar compra
                    </button>
                </form>
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