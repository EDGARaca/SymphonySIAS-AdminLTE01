<%-- 
    Document   : misPedidos
    Created on : 21/11/2025, 7:20:11 a. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.Pedido" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h1 class="text-primary"><i class="fas fa-box"></i> Mis pedidos</h1>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <%
                List<Pedido> pedidos = (List<Pedido>) request.getAttribute("pedidos");
                if (pedidos != null && !pedidos.isEmpty()) {
            %>
            <table class="table table-bordered table-hover mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Fecha</th>
                        <th>Total</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Pedido p : pedidos) {
                    %>
                    <tr>
                        <td><%= p.getIdPedido() %></td>
                        <td><%= p.getFecha() %></td>
                        <td>$<%= String.format("%.2f", p.getTotal()) %></td>
                        <td>
                            <span class="badge 
                                <%= "CONFIRMADO".equalsIgnoreCase(p.getEstado()) ? "bg-success" : "bg-secondary" %>">
                                <%= p.getEstado() %>
                            </span>
                        </td>
                        <td>
                            <a href="DetallePedidoServlet?id=<%= p.getIdPedido() %>" 
                               class="btn btn-sm btn-outline-info">
                                <i class="fas fa-eye"></i> Ver detalles
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <% 
                } else { 
            %>
            <div class="alert alert-warning mt-4">
                No tienes pedidos registrados. 
                <a href="catalogoProductos.jsp" class="alert-link">Explora productos</a>
            </div>
            <% 
                } 
            %>
        </div>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />