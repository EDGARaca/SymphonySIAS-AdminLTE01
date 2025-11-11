<%-- 
    Document   : catalogoProductos
    Created on : 10/11/2025, 6:47:04 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.ProductoMusical, com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<!-- CONTENIDO PRINCIPAL -->
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h1 class="text-primary">Catálogo de Productos Musicales</h1>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <%-- Aquí comienza el catálogo --%>
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <%-- Producto 1 --%>
                                <div class="col-md-4 mb-4">
                                    <div class="card h-100">
                                        <img src="assets/img/banda5.jpg" class="card-img-top" alt="Guitarra Clásica">
                                        <div class="card-body">
                                            <h5 class="card-title">Guitarra Clásica</h5>
                                            <p class="card-text">Guitarra de seis cuerdas con cuerpo de madera</p>
                                            <p class="text-success fw-bold">$250.00 <span class="text-danger">10% OFF</span></p>
                                            <form action="AgregarCarritoServlet" method="post">
                                                <input type="hidden" name="productoId" value="1">
                                                <button type="submit" class="btn btn-primary btn-block">Agregar al carrito</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <%-- Repite este bloque para cada producto --%>
                                <%-- ... --%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />