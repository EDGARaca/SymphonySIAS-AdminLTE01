<%-- 
    Document   : detalleCompra
    Created on : 10/11/2025, 10:13:41 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.Compra, com.mycom.symphonysias.adminlte01.modelo.DetalleCompra, com.mycom.symphonysias.adminlte01.dao.CompraDAO, com.mycom.symphonysias.adminlte01.dao.DetalleCompraDAO" %>
<jsp:include page="header.jsp" />
<jsp:include page="sidebar.jsp" />

<%
    String usuario = (String) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CompraDAO compraDAO = new CompraDAO();
    DetalleCompraDAO detalleDAO = new DetalleCompraDAO();
    List<Compra> compras = compraDAO.listarPorUsuario(usuario);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Historial de Compras</h1>
    </section>

    <section class="content">
        <% if (compras.isEmpty()) { %>
            <p>No se han registrado compras.</p>
        <% } else { %>
            <% for (Compra compra : compras) {
                List<DetalleCompra> detalles = detalleDAO.listarPorCompra(compra.getId());
            %>
                <div class="card mb-3">
                    <div class="card-header">
                        <strong>Compra #<%= compra.getId() %></strong> — <%= compra.getFecha() %> — Total: $<%= compra.getTotal() %>
                    </div>
                    <div class="card-body">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unitario</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (DetalleCompra d : detalles) { %>
                                    <tr>
                                        <td>ID <%= d.getIdProducto() %></td>
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
