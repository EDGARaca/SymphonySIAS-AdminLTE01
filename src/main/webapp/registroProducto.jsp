<%-- 
    Document   : registroProducto
    Created on : 10/11/2025, 9:08:46 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="componentes/roles.jspf" %>

<%
    // ISO/IEC 25010 - Confiabilidad: validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String nombre = (session != null) ? (String) session.getAttribute("nombreActivo") : null;
    
    if (usuario == null || nombre == null || rol == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // Trazabilidad
    System.out.println("[PRODUCTOS MUSICALES] Sesión activa: " + usuario + " (" + rol + ")");
%>

<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapper">
    <section class="content-header">
        <h1>Registrar Producto Musical</h1>
        <p class="text-muted">Complete los campos y valide los permisos según su rol.</p>
    </section>

    <section class="content">
        <!-- Mensajes de estado -->
        <c:if test="${param.ok eq 'registrado'}">
            <div class="alert alert-success text-center">
                <i class="fas fa-check-circle"></i> Producto registrado correctamente.
            </div>
        </c:if>
        <c:if test="${param.error eq 'permiso'}">
            <div class="alert alert-danger text-center">
                <i class="fas fa-exclamation-triangle"></i> No tienes permisos para registrar productos.
            </div>
        </c:if>
        <c:if test="${param.error eq 'parametros'}">
            <div class="alert alert-warning text-center">
                <i class="fas fa-exclamation-circle"></i> Parámetros inválidos.
            </div>
        </c:if>
        <c:if test="${param.error eq 'dao'}">
            <div class="alert alert-danger text-center">
                <i class="fas fa-bug"></i> Error al acceder a la base de datos.
            </div>
        </c:if>

        <!-- Control de permisos por roles: solo Admin/Director/Coord pueden registrar -->
        <c:if test="${isAdmin or isDirector or isCoord}">
            <!-- Envío a tu servlet actual; ajusta si corresponde -->
            <form action="registrar-producto" method="post" onsubmit="return validarFormulario();">
                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" class="form-control" required>
                </div>

                <div class="form-group">
                    <label>Descripción:</label>
                    <textarea name="descripcion" class="form-control" rows="3"></textarea>
                </div>

                <div class="form-group">
                    <label>Precio:</label>
                    <input type="number" step="0.01" min="0" name="precio" class="form-control" required>
                </div>

                <!-- Oferta activa -->
                <div class="form-group">
                    <label>¿Está en oferta?</label>
                    <select name="oferta_activa" class="form-control">
                        <option value="true">Sí</option>
                        <option value="false" selected>No</option>
                    </select>
                </div>

                <!-- Descuento (%), solo visible a roles autorizados -->
                <div class="form-group">
                    <label>Descuento (%)</label>
                    <input type="number" step="0.01" min="0" max="100" name="descuento" class="form-control" value="0">
                    <small class="form-text text-muted">Ingrese un valor entre 0 y 100.</small>
                </div>

                <!-- Imagen (opcional). Nota: este campo no existe en la tabla por defecto -->
                <div class="form-group">
                    <label>Imagen (nombre del archivo) [opcional]</label>
                    <input type="text" name="imagen" class="form-control" placeholder="ej: guitarra01.jpg">
                </div>

                <!-- Stock -->
                <div class="form-group">
                    <label>Cantidad disponible (stock):</label>
                    <input type="number" min="0" name="stock" class="form-control" required>
                </div>

                <div class="form-group">
                    <label>Estado:</label>
                    <select name="estado" class="form-control">
                        <option value="activo" selected>Activo</option>
                        <option value="inactivo">Inactivo</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Registrar producto
                </button>
            </form>
        </c:if>

        <!-- Mensaje si el rol no tiene permiso -->
        <c:if test="${not (isAdmin or isDirector or isCoord)}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i> Tu rol no tiene permisos para registrar productos musicales.
            </div>
        </c:if>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />

<script>
function validarFormulario() {
    const nombre = document.querySelector('input[name="nombre"]').value.trim();
    const precio = parseFloat(document.querySelector('input[name="precio"]').value);
    const stock = parseInt(document.querySelector('input[name="stock"]').value, 10);
    const descuentoField = document.querySelector('input[name="descuento"]');
    const ofertaSel = document.querySelector('select[name="oferta_activa"]').value;

    if (!nombre || isNaN(precio) || precio < 0 || isNaN(stock) || stock < 0) {
        alert("Debe completar correctamente Nombre, Precio (>=0) y Stock (>=0).");
        return false;
    }

    if (descuentoField) {
        const descuento = parseFloat(descuentoField.value);
        if (isNaN(descuento) || descuento < 0 || descuento > 100) {
            alert("El descuento debe estar entre 0 y 100.");
            return false;
        }
        // Coherencia: si no hay oferta, normalizar descuento a 0
        if (ofertaSel === "false" && descuento > 0) {
            const ok = confirm("Marcaste oferta=No pero descuento>0. ¿Deseas establecer descuento=0 automáticamente?");
            if (!ok) return false;
            descuentoField.value = 0;
        }
    }
    return true;
}
</script>