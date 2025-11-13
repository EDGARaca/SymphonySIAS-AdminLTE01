<%-- 
    Document   : formProducto
    Created on : 11/11/2025, 8:12:30 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.ProductoMusical" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<%
    ProductoMusical producto = (ProductoMusical) request.getAttribute("producto");
    boolean esEdicion = (producto != null);
%>

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h1 class="text-primary">
                <%= esEdicion ? "Editar Producto Musical" : "Agregar Nuevo Producto Musical" %>
            </h1>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <form action="GuardarProductoServlet" method="post" enctype="multipart/form-data" class="row g-3">
                <% if (esEdicion) { %>
                    <input type="hidden" name="id" value="<%= producto.getId() %>">
                <% } %>

                <div class="col-md-6">
                    <label for="nombre" class="form-label">Nombre del producto</label>
                    <input type="text" name="nombre" id="nombre" class="form-control" required
                           value="<%= esEdicion ? producto.getNombre() : "" %>">
                </div>

                <div class="col-md-6">
                    <label for="precio" class="form-label">Precio</label>
                    <input type="number" step="0.01" name="precio" id="precio" class="form-control" required
                           value="<%= esEdicion ? producto.getPrecio() : "" %>">
                </div>

                <div class="col-md-6">
                    <label for="descuento" class="form-label">Descuento (%)</label>
                    <input type="number" name="descuento" id="descuento" class="form-control"
                           value="<%= esEdicion ? producto.getDescuento() : "0" %>">
                </div>

                <div class="col-md-12">
                    <label for="descripcion" class="form-label">Descripción</label>
                    <textarea name="descripcion" id="descripcion" class="form-control" rows="3" required><%= esEdicion ? producto.getDescripcion() : "" %></textarea>
                </div>

                <div class="col-md-12">
                    <label for="imagen" class="form-label">Imagen del producto</label>
                    <input type="file" name="imagen" id="imagen" class="form-control">
                    <% if (esEdicion && producto.getRutaImagen() != null) { %>
                        <p class="mt-2">Imagen actual:</p>
                        <img src="<%= producto.getRutaImagen() %>" alt="Imagen actual" style="height: 100px;">
                    <% } %>
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save me-1"></i> Guardar
                    </button>
                    <a href="adminProductos.jsp" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />