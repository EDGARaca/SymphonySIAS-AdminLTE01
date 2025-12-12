/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * CarritoServlet
 * Gestiona operaciones de carrito: agregar, actualizar, eliminar y vaciar.
 *
 * ISO/IEC 25010:
 * - Confiabilidad: validaciones de entrada, coherencia stock/cantidad, manejo de excepciones.
 * - Mantenibilidad: métodos claros por acción, comentarios y trazabilidad en logs.
 * - Trazabilidad: usa sesión de usuario, logs, y nombres de parámetros consistentes.
 *
 * Notas:
 * - Control de permisos por rol se realiza en JSP (roles.jspf + JSTL). Aquí validamos sesión activa.
 * - El carrito se almacena en sesión: atributo "carrito" (List<ItemCarrito>).
 * - ProductoMusicalDAO debe estar alineado a la tabla productos_musicales.
 */
@WebServlet(name = "CarritoServlet", urlPatterns = {"/carrito"})
public class CarritoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    
    private transient final ProductoMusicalDAO productoDAO = new ProductoMusicalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Acciones idempotentes: mostrar carrito o eliminar item
        String accion = getParam(request, "accion");
        if (accion == null || accion.isEmpty() || "ver".equalsIgnoreCase(accion)) {
            // Render del carrito (JSP debe consumir la lista desde la sesión)
            forward(request, response, "/carrito.jsp");
            return;
        }

        if ("eliminar".equalsIgnoreCase(accion)) {
            eliminarItem(request);
            redirectBack(request, response);
            return;
        }

        if ("vaciar".equalsIgnoreCase(accion)) {
            vaciarCarrito(request);
            redirectBack(request, response);
            return;
        }

        // Acción no reconocida → mostrar carrito
        forward(request, response, "/carrito.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Acciones que modifican estado: agregar o actualizar
        String accion = getParam(request, "accion");

        // Confiabilidad: validar sesión activa
        if (!sesionActiva(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            if ("agregar".equalsIgnoreCase(accion)) {
                agregarItem(request);
                redirectBack(request, response);
                return;
            }
            if ("actualizar".equalsIgnoreCase(accion)) {
                actualizarItem(request);
                redirectBack(request, response);
                return;
            }
        } catch (Exception ex) {
            System.err.println("[CarritoServlet] Error en acción POST: " + ex.getMessage());
            // Enviar mensaje de error controlado
            request.setAttribute("errorCarrito", "Ocurrió un error al procesar el carrito.");
            forward(request, response, "/carrito.jsp");
            return;
        }

        // Acción no reconocida → mostrar carrito
        forward(request, response, "/carrito.jsp");
    }

    // =========================
    // Acciones
    // =========================

    /**
     * Agrega un producto al carrito. Si ya existe, suma la cantidad.
     * Validaciones:
     * - Producto existe.
     * - Cantidad > 0 y no supera stock.
     */
    private void agregarItem(HttpServletRequest request) {
        int idProducto = parseInt(getParam(request, "idProducto"), -1);
        int cantidad = parseInt(getParam(request, "cantidad"), 1);

        if (idProducto <= 0 || cantidad <= 0) {
            System.out.println("[CarritoServlet] Parámetros inválidos en agregar.");
            request.getSession().setAttribute("msgCarrito", "Parámetros inválidos.");
            return;
        }

        ProductoMusical producto = productoDAO.buscarPorId(idProducto);
        if (producto == null) {
            System.out.println("[CarritoServlet] Producto no encontrado: id=" + idProducto);
            request.getSession().setAttribute("msgCarrito", "Producto no encontrado.");
            return;
        }

        // Coherencia con stock
        if (producto.getStock() >= 0 && cantidad > producto.getStock()) {
            request.getSession().setAttribute("msgCarrito", "Cantidad supera el stock disponible.");
            return;
        }

        List<ItemCarrito> carrito = getCarrito(request.getSession());
        int idx = indexOfProducto(carrito, idProducto);
        if (idx >= 0) {
            // Ya existe → sumar cantidad, respetando stock
            ItemCarrito item = carrito.get(idx);
            int nuevaCantidad = item.getCantidad() + cantidad;
            if (producto.getStock() >= 0 && nuevaCantidad > producto.getStock()) {
                request.getSession().setAttribute("msgCarrito", "No puedes agregar más de la cantidad disponible.");
                return;
            }
            item.setCantidad(nuevaCantidad);
        } else {
            carrito.add(new ItemCarrito(producto, cantidad));
        }
        request.getSession().setAttribute("msgCarrito", "Producto agregado al carrito.");
    }

    /**
     * Actualiza la cantidad de un ítem en el carrito.
     * Si cantidad <= 0, elimina el ítem.
     */
    private void actualizarItem(HttpServletRequest request) {
        int idProducto = parseInt(getParam(request, "idProducto"), -1);
        int cantidad = parseInt(getParam(request, "cantidad"), -1);

        if (idProducto <= 0) {
            request.getSession().setAttribute("msgCarrito", "Producto inválido.");
            return;
        }

        List<ItemCarrito> carrito = getCarrito(request.getSession());
        int idx = indexOfProducto(carrito, idProducto);
        if (idx < 0) {
            request.getSession().setAttribute("msgCarrito", "El producto no está en el carrito.");
            return;
        }

        if (cantidad <= 0) {
            carrito.remove(idx);
            request.getSession().setAttribute("msgCarrito", "Producto eliminado del carrito.");
            return;
        }

        // Validar contra stock actual (puede haber cambiado)
        ProductoMusical producto = productoDAO.buscarPorId(idProducto);
        if (producto == null) {
            carrito.remove(idx);
            request.getSession().setAttribute("msgCarrito", "El producto fue removido del catálogo.");
            return;
        }
        if (producto.getStock() >= 0 && cantidad > producto.getStock()) {
            request.getSession().setAttribute("msgCarrito", "Cantidad supera stock disponible.");
            return;
        }

        carrito.get(idx).setCantidad(cantidad);
        request.getSession().setAttribute("msgCarrito", "Cantidad actualizada.");
    }

    /**
     * Elimina un ítem específico del carrito.
     */
    private void eliminarItem(HttpServletRequest request) {
        int idProducto = parseInt(getParam(request, "idProducto"), -1);
        if (idProducto <= 0) {
            request.getSession().setAttribute("msgCarrito", "Producto inválido.");
            return;
        }
        List<ItemCarrito> carrito = getCarrito(request.getSession());
        int idx = indexOfProducto(carrito, idProducto);
        if (idx >= 0) {
            carrito.remove(idx);
            request.getSession().setAttribute("msgCarrito", "Producto eliminado del carrito.");
        } else {
            request.getSession().setAttribute("msgCarrito", "El producto no estaba en el carrito.");
        }
    }

    /**
     * Vacía el carrito por completo.
     */
    private void vaciarCarrito(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("carrito", new ArrayList<ItemCarrito>());
        session.setAttribute("msgCarrito", "Carrito vaciado.");
    }

    // =========================
    // Utilidades
    // =========================

    private List<ItemCarrito> getCarrito(HttpSession session) {
        @SuppressWarnings("unchecked")
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        }
        return carrito;
    }

    private int indexOfProducto(List<ItemCarrito> carrito, int idProducto) {
        for (int i = 0; i < carrito.size(); i++) {
            ProductoMusical p = carrito.get(i).getProducto();
            if (p != null && p.getIdProducto() != null && p.getIdProducto() == idProducto) {
                return i;
            }
        }
        return -1;
    }

    private String getParam(HttpServletRequest request, String name) {
        String v = request.getParameter(name);
        return (v != null) ? v.trim() : null;
    }

    private int parseInt(String value, int def) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return def;
        }
    }

    private boolean sesionActiva(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        String usuario = (String) session.getAttribute("usuarioActivo");
        String rol = (String) session.getAttribute("rol");
        return usuario != null && rol != null;
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String jsp) throws ServletException, IOException {
        request.getRequestDispatcher(jsp).forward(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Redirige a la página origen si se envió "returnTo"; si no, carrito.jsp
        String returnTo = getParam(request, "returnTo");
        if (returnTo != null && !returnTo.isEmpty()) {
            response.sendRedirect(returnTo);
        } else {
            response.sendRedirect(request.getContextPath() + "/carrito.jsp");
        }
    }
}