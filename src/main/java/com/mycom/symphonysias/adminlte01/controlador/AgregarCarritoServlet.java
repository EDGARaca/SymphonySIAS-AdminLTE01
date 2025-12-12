/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */
/*
 * AgregarCarritoServlet - agrega productos al carrito en sesión.
 * Cumple ISO/IEC 25010: validaciones de entrada, coherencia de negocio (stock/oferta),
 * mantenibilidad (estructura clara), y trazabilidad (logs y mensajes de estado).
 */
package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AgregarCarritoServlet", urlPatterns = {"/AgregarCarritoServlet"})
public class AgregarCarritoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private transient final ProductoMusicalDAO productoDAO = new ProductoMusicalDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lectura segura de parámetros
            String idParam = trimOrNull(request.getParameter("id"));
            String cantidadParam = trimOrNull(request.getParameter("cantidad"));

            if (idParam == null) {
                System.err.println("[AgregarCarritoServlet] Falta parámetro id de producto.");
                response.sendRedirect(request.getContextPath() + "/catalogoProductos.jsp?error=parametros");
                return;
            }

            int idProducto = Integer.parseInt(idParam);
            int cantidad = (cantidadParam != null) ? parseIntSafe(cantidadParam, 1) : 1;
            if (cantidad < 1) cantidad = 1; // normaliza mínimo 1

            System.out.println("[AgregarCarritoServlet] Solicitud agregar: id=" + idProducto + " cantidad=" + cantidad);

            // Obtener/crear carrito en sesión
            HttpSession session = request.getSession(true);
            List<ItemCarrito> carrito = getOrInitCarrito(session);

            // Cargar producto y validar existencia
            ProductoMusical producto = productoDAO.buscarPorId(idProducto);
            if (producto == null) {
                System.err.println("[AgregarCarritoServlet] Producto no encontrado id=" + idProducto);
                response.sendRedirect(request.getContextPath() + "/catalogoProductos.jsp?error=producto");
                return;
            }

            // Coherencia oferta: si descuento > 0 → oferta activa
            if (producto.getDescuento() > 0 && !producto.isOfertaActiva()) {
                producto.setOfertaActiva(true);
            }

            // Validación contra stock
            if (producto.getStock() >= 0 && cantidad > producto.getStock()) {
                session.setAttribute("msgCarrito", "La cantidad solicitada supera el stock disponible.");
                response.sendRedirect(request.getContextPath() + "/catalogoProductos.jsp?error=stock");
                return;
            }

            // Si ya existe en carrito, actualizar cantidad; si no, agregar nuevo
            int idx = indexOfProducto(carrito, idProducto);
            if (idx >= 0) {
                ItemCarrito item = carrito.get(idx);
                int nuevaCantidad = item.getCantidad() + cantidad;
                if (producto.getStock() >= 0 && nuevaCantidad > producto.getStock()) {
                    session.setAttribute("msgCarrito", "No puedes agregar más de la cantidad disponible.");
                    response.sendRedirect(request.getContextPath() + "/catalogoProductos.jsp?error=stock");
                    return;
                }
                item.setCantidad(nuevaCantidad);
                System.out.println("[AgregarCarritoServlet] Actualizado: " + producto.getNombre() + " x" + nuevaCantidad);
            } else {
                carrito.add(new ItemCarrito(producto, cantidad));
                System.out.println("[AgregarCarritoServlet] Agregado: " + producto.getNombre() + " x" + cantidad);
            }

            // Persistir carrito y mensaje en sesión
            session.setAttribute("carrito", carrito);
            session.setAttribute("msgCarrito", "Producto agregado al carrito.");

            // Redirección
            String returnTo = trimOrNull(request.getParameter("returnTo"));
            response.sendRedirect(returnTo != null ? returnTo : (request.getContextPath() + "/verCarrito.jsp?ok=agregado"));

        } catch (NumberFormatException e) {
            System.err.println("[AgregarCarritoServlet] Parámetros inválidos: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/catalogoProductos.jsp?error=parametros");
        } catch (Exception e) {
            System.err.println("[AgregarCarritoServlet] Error inesperado: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    // =========================
    // Utilidades privadas
    // =========================

    private List<ItemCarrito> getOrInitCarrito(HttpSession session) {
        @SuppressWarnings("unchecked")
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        } else {
            // Sanitiza contenido si el atributo fue inicializado con otro tipo
            List<ItemCarrito> limpio = new ArrayList<>();
            for (Object o : carrito) {
                if (o instanceof ItemCarrito) limpio.add((ItemCarrito) o);
            }
            carrito = limpio;
            session.setAttribute("carrito", carrito);
        }
        return carrito;
    }

    private int indexOfProducto(List<ItemCarrito> carrito, int idProducto) {
        for (int i = 0; i < carrito.size(); i++) {
            var p = carrito.get(i).getProducto();
            if (p != null && p.getIdProducto() != null && p.getIdProducto() == idProducto) {
                return i;
            }
        }
        return -1;
    }

    private String trimOrNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private int parseIntSafe(String s, int def) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            return def;
        }
    }
}