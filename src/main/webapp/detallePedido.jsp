<%-- 
    Document   : detallePedido
    Created on : 21/11/2025, 7:22:27 a. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.Pedido, com.mycom.symphonysias.adminlte01.modelo.ItemCarrito, com.mycom.symphonysias.adminlte01.modelo.ProductoMusical" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h1 class="text-primary">
                <i class="fas fa-box-open"></i> 
                Detalle del pedido #<%= request.getParameter("id") %>
            </h1>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <%
                Pedido pedido = (Pedido) request.getAttribute("pedido");
                String usuario = (String) session.getAttribute("usuario");
                Boolean sinDetalles = (Boolean) request.getAttribute("sinDetalles");
                String error = (String) request.getAttribute("error");
            %>

            <!-- Mensaje de error -->
            <% if (error != null) { %>
                <div class="alert alert-danger mt-4"><%= error %></div>
            <% } %>

            <% if (pedido != null) { %>
                <!-- Cabecera del pedido -->
                <div class="card mb-4">
                    <div class="card-body">
                        <p><strong>Usuario:</strong> <%= usuario %></p>
                        <p><strong>Fecha:</strong> <%= pedido.getFecha() %></p>
                        <p><strong>Estado:</strong> 
                            <span class="badge bg-success"><%= pedido.getEstado() %></span>
                        </p>
                        <p><strong>Total:</strong> 
                            <span class="text-success fw-bold">$<%= pedido.getTotal() %></span>
                        </p>
                    </div>
                </div>

                <!-- Mensaje si no hay detalles -->
                <% if (sinDetalles != null && sinDetalles) { %>
                    <div class="alert alert-warning">Este pedido no tiene productos asociados.</div>
                <% } else { %>
                    <!-- Tabla de detalles -->
                    <table class="table table-bordered table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Imagen</th>
                                <th>Producto</th>
                                <th>Descripción</th>
                                <th>Precio Unitario</th>
                                <th>Descuento</th>
                                <th>Precio con Descuento</th>
                                <th>Cantidad</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (ItemCarrito item : pedido.getDetalles()) {
                                    ProductoMusical prod = item.getProducto();
                                    double precioConDescuento = prod.getPrecio() - (prod.getPrecio() * prod.getDescuento() / 100);
                                    double subtotal = precioConDescuento * item.getCantidad();
                            %>
                            <tr>
                                <td>
                                    <img src="<%= prod.getImagenUrl() %>" alt="<%= prod.getNombre() %>" 
                                         class="img-thumbnail" style="width:80px;height:80px;">
                                </td>
                                <td><%= prod.getNombre() %></td>
                                <td><%= prod.getDescripcion() %></td>
                                <td>$<%= prod.getPrecio() %></td>
                                <td><%= prod.getDescuento() %> %</td>
                                <td>$<%= precioConDescuento %></td>
                                <td><%= item.getCantidad() %></td>
                                <td>$<%= subtotal %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>

                <div class="mt-4 d-flex justify-content-end">
                    <a href="misPedidosServlet" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Volver a mis pedidos
                    </a>
                </div>
            <% } else if (error == null) { %>
                <div class="alert alert-danger mt-4">No se encontró el pedido solicitado.</div>
            <% } %>
        </div>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />