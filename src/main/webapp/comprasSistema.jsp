<%-- 
    Document   : comprasSistema
    Created on : 10/11/2025, 10:26:31 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.Compra, com.mycom.symphonysias.adminlte01.modelo.DetalleCompra, com.mycom.symphonysias.adminlte01.dao.CompraDAO, com.mycom.symphonysias.adminlte01.dao.DetalleCompraDAO" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<%
    String rol = (String) session.getAttribute("rol");
    if (rol == null || !(rol.equals("ADMIN") || rol.equals("DIRECTOR"))) {
        response.sendRedirect("catalogoProductos.jsp");
        return;
    }

    CompraDAO compraDAO = new CompraDAO();
    DetalleCompraDAO detalleDAO = new DetalleCompraDAO();
    List<Compra> compras = compraDAO.listarTodas();
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Compras del Sistema</h1>
    </section>

    <section class="content">
        <% if (compras.isEmpty()) { %>
            <p>No se han registrado compras en el sistema.</p>
        <% } else { %>
            <% for (Compra compra : compras) {
                List<DetalleCompra> detalles = detalleDAO.listarPorCompra(compra.getId());
            %>
                <div class="card mb-3">
                    <div class="card-header">
                        <strong>Compra #<%= compra.getId() %></strong> — Usuario: <%= compra.getUsuario() %> — <%= compra.getFecha() %> — Total: $<%= compra.getTotal() %>
                    </div>
                    <div class="card-body">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>ID Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unitario</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (DetalleCompra d : detalles) { %>
                                    <tr>
                                        <td><%= d.getIdProducto() %></td>
                                        <td><%= d.getCantidad() %></td>
                                        <td>$<%= d.getPrecioUnitario() %></td>
                                        <td>$<%= d.getSubtotal() %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            <% } %>
        <% } %>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />
