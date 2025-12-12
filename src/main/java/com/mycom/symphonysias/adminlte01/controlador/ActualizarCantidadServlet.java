/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */

/*
 * ActualizarCantidadServlet - actualiza la cantidad de un ítem del carrito.
 * Cumple ISO/IEC 25010: validaciones robustas, coherencia con stock, trazabilidad con logs y mensajes.
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

@WebServlet(name = "ActualizarCantidadServlet", urlPatterns = {"/ActualizarCantidadServlet"})
public class ActualizarCantidadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private transient final ProductoMusicalDAO productoDAO = new ProductoMusicalDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        // Lectura segura de parámetros
        String idParam = trimOrNull(request.getParameter("id"));
        String cantidadParam = trimOrNull(request.getParameter("cantidad"));

        if (idParam == null) {
            session.setAttribute("msgCarrito", "Parámetro de producto faltante.");
            response.sendRedirect(request.getContextPath() + "/verCarrito.jsp?error=parametros");
            return;
        }

        int idProducto;
        int cantidad;
        try {
            idProducto = Integer.parseInt(idParam);
            cantidad = (cantidadParam != null) ? Integer.parseInt(cantidadParam) : -1;
        } catch (NumberFormatException nfe) {
            session.setAttribute("msgCarrito", "Parámetros inválidos.");
            response.sendRedirect(request.getContextPath() + "/verCarrito.jsp?error=parametros");
            return;
        }

        List<ItemCarrito> carrito = getOrInitCarrito(session);
        int idx = indexOfProducto(carrito, idProducto);
        if (idx < 0) {
            session.setAttribute("msgCarrito", "El producto no está en el carrito.");
            response.sendRedirect(request.getContextPath() + "/verCarrito.jsp?error=inexistente");
            return;
        }

        // Si cantidad <= 0 → eliminar ítem
        if (cantidad <= 0) {
            carrito.remove(idx);
            session.setAttribute("carrito", carrito);
            session.setAttribute("msgCarrito", "Producto eliminado del carrito.");
            response.sendRedirect(request.getContextPath() + "/verCarrito.jsp?ok=eliminado");
            return;
        }

        // Validar contra stock actual
        ProductoMusical producto = productoDAO.buscarPorId(idProducto);
        if (producto == null) {
            carrito.remove(idx);
            session.setAttribute("carrito", carrito);
            session.setAttribute("msgCarrito", "El producto fue removido del catálogo.");
            response.sendRedirect(request.getContextPath() + "/verCarrito.jsp?error=catálogo");
            return;
        }
        if (producto.getStock() >= 0 && cantidad > producto.getStock()) {
            session.setAttribute("msgCarrito", "Cantidad supera el stock disponible.");
            response.sendRedirect(request.getContextPath() + "/verCarrito.jsp?error=stock");
            return;
        }

        // Actualizar cantidad
        carrito.get(idx).setCantidad(cantidad);
        session.setAttribute("carrito", carrito);
        session.setAttribute("msgCarrito", "Cantidad actualizada.");

        // Redirección
        String returnTo = trimOrNull(request.getParameter("returnTo"));
        response.sendRedirect(returnTo != null ? returnTo : (request.getContextPath() + "/verCarrito.jsp?ok=actualizado"));
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
}