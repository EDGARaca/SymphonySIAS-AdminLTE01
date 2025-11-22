/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.controlador;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;

@WebServlet("/AgregarCarritoServlet")
public class AgregarCarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ID del producto (obligatorio)
            int idProducto = Integer.parseInt(request.getParameter("id"));

            // Cantidad (opcional, por defecto 1)
            String cantidadParam = request.getParameter("cantidad");
            int cantidad = 1;
            if (cantidadParam != null && !cantidadParam.trim().isEmpty()) {
                cantidad = Integer.parseInt(cantidadParam);
            }

            System.out.println("[CARRITO] ID recibido=" + idProducto + " cantidad=" + cantidad);

            HttpSession session = request.getSession();
            List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
            if (carrito == null) {
                carrito = new ArrayList<>();
            }

            // Cargar producto desde DAO
            ProductoMusicalDAO dao = new ProductoMusicalDAO();
            ProductoMusical producto = dao.buscarPorId(idProducto);
            if (producto == null) {
                System.err.println("[CARRITO] Producto no encontrado id=" + idProducto);
                response.sendRedirect(request.getContextPath() + "/catalogoProductos.jsp");
                return;
            }

            // Asegurar bandera de oferta activa en base al descuento
            // (si tu DAO ya lo setea, esto no afecta; si no, garantiza consistencia)
            producto.setOfertaActiva(producto.getDescuento() > 0);

            System.out.println("[CARRITO] Producto=" + producto.getNombre()
                    + " precio=" + producto.getPrecio()
                    + " desc=" + producto.getDescuento()
                    + " ofertaActiva=" + producto.isOfertaActiva());

            // Si ya existe en el carrito, sumar cantidad
            boolean encontrado = false;
            for (ItemCarrito item : carrito) {
                int idExistente = item.getProducto().getIdProducto() > 0
                        ? item.getProducto().getIdProducto()
                        : item.getProducto().getId();

                if (idExistente == idProducto) {
                    item.setCantidad(item.getCantidad() + cantidad);
                    // Mantener subtotal base sincronizado (precio sin descuento)
                    item.calcularSubtotal();
                    encontrado = true;
                    System.out.println("[CARRITO] Cantidad actualizada: "
                            + item.getProducto().getNombre() + " x" + item.getCantidad());
                    break;
                }
            }

            // Si no existe, agregar nuevo ítem
            if (!encontrado) {
                ItemCarrito nuevo = new ItemCarrito(producto, cantidad);
                carrito.add(nuevo);
                System.out.println("[CARRITO] Agregado: " + producto.getNombre() + " x" + cantidad);
            }

            // Persistir carrito en sesión y redirigir
            session.setAttribute("carrito", carrito);
            response.sendRedirect(request.getContextPath() + "/verCarrito.jsp");

        } catch (NumberFormatException e) {
            System.err.println("[CARRITO] Parámetros inválidos: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/catalogoProductos.jsp");
        } catch (Exception e) {
            System.err.println("[CARRITO] Error inesperado: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}