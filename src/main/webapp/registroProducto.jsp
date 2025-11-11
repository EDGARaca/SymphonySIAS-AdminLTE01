<%-- 
    Document   : registroProducto
    Created on : 10/11/2025, 9:08:46 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="compenentes/header.jsp" />
<jsp:include page="compenentes/sidebar.jsp" />

<div class="content-wrapper">
    <section class="content-header">
        <h1>Registrar Producto Musical</h1>
    </section>

    <section class="content">
        <form action="registrar-producto" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Nombre:</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Descripción:</label>
                <textarea name="descripcion" class="form-control" required></textarea>
            </div>
            <div class="form-group">
                <label>Precio:</label>
                <input type="number" step="0.01" name="precio" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Imagen (nombre del archivo):</label>
                <input type="text" name="imagen" class="form-control" required>
            </div>
            <div class="form-group">
                <label>¿Está en oferta?</label>
                <select name="oferta" class="form-control">
                    <option value="true">Sí</option>
                    <option value="false">No</option>
                </select>
            </div>
            <div class="form-group">
                <label>Descuento (%):</label>
                <input type="number" step="0.01" name="descuento" class="form-control" value="0">
            </div>
            <div class="form-group">
                <label>Cantidad disponible:</label>
                <input type="number" name="cantidad" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Registrar producto</button>
        </form>
    </section>
</div>

<jsp:include page="compenentes/footer.jsp" />
