<%-- 
    Document   : verCarrito
    Created on : 11/11/2025, 2:43:16 p. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="componentes/header.jsp" />
<jsp:include page="componentes/sidebar.jsp" />

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h1 class="text-primary">Resumen de tu carrito de compras</h1>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">

            <!-- Mensaje de compra -->
            <c:if test="${not empty sessionScope.msgCarrito}">
                <div class="alert alert-info alert-dismissible fade show mt-3" role="alert">
                    <p>${sessionScope.msgCarrito}</p>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
                </div>
                <c:remove var="msgCarrito" scope="session"/>
            </c:if>

            <c:choose>
                <c:when test="${empty sessionScope.carrito}">
                    <div class="alert alert-warning">
                        Tu carrito está vacío. <a href="catalogoProductos.jsp">Ir al catálogo</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered table-hover mt-3">
                        <thead class="table-dark">
                            <tr>
                                <th>Producto</th>
                                <th>Descripción</th>
                                <th>Precio Unitario</th>
                                <th>Precio con descuento</th>
                                <th>Descuento</th>
                                <th>Cantidad</th>
                                <th>Subtotal</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0"/>
                            <c:forEach var="item" items="${sessionScope.carrito}">
                                <tr>
                                    <td>${item.producto.nombre}</td>
                                    <td>${item.producto.descripcion}</td>
                                    <td>$ ${item.producto.precio}</td>
                                    <td>$ ${item.subtotalConDescuento}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.producto.ofertaActiva}">
                                                ${item.producto.descuento} %
                                            </c:when>
                                            <c:otherwise>
                                                Sin descuento
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/ActualizarCantidadServlet">
                                            <input type="hidden" name="id" value="${item.producto.idProducto}"/>
                                            <input type="number" name="cantidad" value="${item.cantidad}" min="1" class="form-control" style="width:80px;display:inline-block"/>
                                            <button type="submit" class="btn btn-primary btn-sm">Actualizar</button>
                                        </form>
                                    </td>
                                    <td>$ ${item.subtotalConDescuento}</td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/ActualizarCantidadServlet">
                                            <input type="hidden" name="id" value="${item.producto.idProducto}"/>
                                            <input type="hidden" name="cantidad" value="0"/>
                                            <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                        </form>
                                    </td>
                                </tr>
                                <c:set var="total" value="${total + item.subtotalConDescuento}"/>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="table-secondary">
                                <td colspan="7" class="text-end fw-bold">Total:</td>
                                <td class="fw-bold text-success">$ ${total}</td>
                            </tr>
                        </tfoot>
                    </table>

                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <a href="catalogoProductos.jsp" class="btn btn-outline-primary">
                            <i class="fas fa-shopping-bag"></i> Seguir comprando
                        </a>
                        <a href="misPedidosServlet" class="btn btn-outline-secondary">
                            <i class="fas fa-box"></i> Ver mis pedidos
                        </a>
                        <form action="${pageContext.request.contextPath}/FinalizarCompraServlet" method="post">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-credit-card"></i> Finalizar compra
                            </button>
                        </form>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</div>

<jsp:include page="componentes/footer.jsp" />