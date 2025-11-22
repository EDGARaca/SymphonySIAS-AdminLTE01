<%-- 
    Document   : comprasSistema
    Created on : 10/11/2025, 10:26:31 p. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.dao.CompraDAO, com.mycom.symphonysias.adminlte01.modelo.Compra" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapper">
  <section class="content-header">
    <div class="container-fluid">
      <h1 class="text-primary"><i class="fas fa-receipt"></i> Compras del sistema</h1>
    </div>
  </section>

  <section class="content">
    <div class="container-fluid">
      <%
        String usuario = (String) session.getAttribute("usuario");
        List<Compra> compras = null;

        if (usuario == null) {
            response.sendRedirect("login.jsp");
        } else {
            CompraDAO dao = new CompraDAO();
            compras = dao.listarComprasPorUsuario(usuario);
        }
      %>

      <% if (compras != null && !compras.isEmpty()) { %>
        <table class="table table-bordered table-hover mt-3">
          <thead class="table-dark">
            <tr>
              <th>ID compra</th>
              <th>Usuario</th>
              <th>Fecha</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody>
          <% for (Compra c : compras) { %>
            <tr>
              <td><%= c.getId() %></td>
              <td><%= c.getUsuario() %></td>
              <td><%= c.getFecha() %></td>
              <td>$<%= String.format("%.2f", c.getTotal()) %></td>
            </tr>
          <% } %>
          </tbody>
        </table>
      <% } else if (usuario != null) { %>
        <div class="alert alert-warning mt-4">
          No hay compras registradas para tu usuario.
        </div>
      <% } %>

      <div class="mt-3">
        <a href="misPedidosServlet" class="btn btn-outline-secondary"><i class="fas fa-box"></i> Ver mis pedidos</a>
      </div>
    </div>
  </section>
</div>

<jsp:include page="componentes/footer.jsp" />