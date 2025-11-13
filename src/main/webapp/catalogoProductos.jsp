<%-- 
    Document   : catalogoProductos
    Created on : 10/11/2025, 6:47:04 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.ProductoMusical, com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.ItemCarrito" %>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Productos Musicales - SymphonySIAS</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

<%-- Contenido principal --%>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

    <!-- CONTENIDO PRINCIPAL -->
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <h1 class="text-primary">Catálogo de Productos Musicales</h1>
            </div>
        </section>
        
        <%-- 🔁 Resumen parcial del carrito --%>
        <%
            List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
            int totalItems = 0;
            if (carrito != null) {
                for (ItemCarrito item : carrito) {
                    totalItems += item.getCantidad();
                }
            }
        %>
        <div class="alert alert-info ms-3 me-3">
            Productos en tu carrito: <%= totalItems %>
            <a href="verCarrito.jsp" class="btn btn-sm btn-primary ms-2">Ver carrito</a>
        </div>



        <section class="content">
            <div class="container-fluid">
        <div class="row">
            <%
                ProductoMusicalDAO dao = new ProductoMusicalDAO();
                List<ProductoMusical> productos = dao.listar();
                for (ProductoMusical producto : productos) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <img src="<%= request.getContextPath() %>/assets/adminlte/img/<%= producto.getImagen() %>" class="card-img-top img-fluid" alt="<%= producto.getNombre() %>" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title"><%= producto.getNombre() %></h5>
                        <p class="card-text"><%= producto.getDescripcion() %></p>

                        <!-- 🔎 ID y % de descuento -->
                        <p class="text-muted mb-1">ID: <%= producto.getId() %></p>
                        <p class="text-warning mb-2">
                            <%= producto.isOfertaActiva() ? "Descuento: " + producto.getDescuento() + "%" : "Sin descuento" %>
                        </p>

                        <p class="card-text text-success fw-bold">$<%= producto.getPrecio() %></p>

                        <form action="AgregarCarritoServlet" method="post">
                            <input type="hidden" name="id" value="<%= producto.getId() %>">
                            <div class="input-group mb-2">
                                <input type="number" name="cantidad" value="1" min="1" class="form-control">
                                <button type="submit" class="btn btn-primary">Agregar al carrito</button>
                            </div>
                        </form>
                    </div>
                </div>
        </div>
        <%
            }
        %>
    </div>
</div>                    
        </section>
        <jsp:include page="componentes/footer.jsp" />        
    </div>
    
</div>

<script>
    document.querySelectorAll('.cantidad-input').forEach(input => {
        input.addEventListener('input', function () {
            const cantidad = parseInt(this.value) || 1;
            const cardBody = this.closest('.card-body');

            const precioSpan = cardBody.querySelector('.precio-unitario');
            const descuentoSpan = cardBody.querySelector('.text-danger');
            const totalSpan = cardBody.querySelector('.total-precio');

            if (precioSpan && descuentoSpan && totalSpan) {
                const precioUnitario = parseFloat(precioSpan.textContent);
                const descuentoTexto = descuentoSpan.textContent;
                const descuento = parseInt(descuentoTexto.replace(/\D/g, "")) || 0;

                const precioConDescuento = precioUnitario * (1 - descuento / 100);
                const total = (cantidad * precioConDescuento).toFixed(2);

                totalSpan.textContent = `$${total}`;
            }
        });
    });
</script>


<%-- Scripts AdminLTE --%>
<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>
