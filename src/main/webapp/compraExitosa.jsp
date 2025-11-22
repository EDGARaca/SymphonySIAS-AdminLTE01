<%-- 
    Document   : compraExitosa
    Created on : 11/11/2025, 2:52:10 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapper">
  <section class="content-header">
    <div class="container-fluid">
      <h1 class="text-success"><i class="fas fa-check-circle"></i> Compra exitosa</h1>
    </div>
  </section>

  <section class="content">
    <div class="container-fluid">
      <%
        String mensaje = (String) session.getAttribute("mensajeCompra");
        if (mensaje == null) mensaje = "Tu compra fue registrada correctamente.";
      %>
      <div class="alert alert-success"><%= mensaje %></div>

      <div class="mt-3 d-flex gap-2">
        <a class="btn btn-primary" href="misPedidosServlet"><i class="fas fa-box"></i> Ver mis pedidos</a>
        <a class="btn btn-outline-info" href="compraSistema.jsp"><i class="fas fa-list"></i> Ver compras (auditoría)</a>
        <a class="btn btn-secondary" href="catalogoProductos.jsp"><i class="fas fa-store"></i> Volver al catálogo</a>
      </div>
    </div>
  </section>
</div>

<jsp:include page="componentes/footer.jsp" />