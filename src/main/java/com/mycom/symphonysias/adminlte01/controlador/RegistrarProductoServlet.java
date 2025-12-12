/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */



package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * Servlet para registrar productos musicales.
 * ISO/IEC 25010:
 * - Confiabilidad: validaciones de sesión y parámetros.
 * - Mantenibilidad: código claro y alineado con el modelo ProductoMusical.
 * - Trazabilidad: logs en consola y control de roles.
 */
@WebServlet(name = "RegistrarProductoServlet", urlPatterns = {"/registrar-producto"})
public class RegistrarProductoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String usuario = (String) session.getAttribute("usuarioActivo");
        String rol = (String) session.getAttribute("rol");

        // Validación de sesión y rol
        if (usuario == null || rol == null ||
                !(rol.equalsIgnoreCase("ADMIN") || rol.equalsIgnoreCase("DIRECTOR") || rol.equalsIgnoreCase("COORDINADOR"))) {
            System.out.println("[RegistrarProductoServlet] Usuario sin permisos intentó registrar producto.");
            response.sendRedirect("catalogoProductos.jsp?error=permiso");
            return;
        }

        try {
            // Parámetros del formulario
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String imagenUrl = request.getParameter("imagen");
            boolean oferta = Boolean.parseBoolean(request.getParameter("oferta"));
            double descuento = Double.parseDouble(request.getParameter("descuento"));
            int stock = Integer.parseInt(request.getParameter("cantidad"));

            // Construcción del modelo
            ProductoMusical producto = new ProductoMusical();
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            producto.setImagenUrl(imagenUrl);
            producto.setOfertaActiva(oferta);
            producto.setDescuento(descuento);
            producto.setStock(stock);
            producto.setEstado("activo"); // por defecto activo
            producto.setIdUsuarioRegistro(1); // ⚠️ Ajustar: ID del usuario logueado
            producto.setCreatedAt(LocalDateTime.now());
            producto.setUpdatedAt(LocalDateTime.now());

            // Persistencia
            ProductoMusicalDAO dao = new ProductoMusicalDAO();
            boolean ok = dao.registrar(producto);

            if (ok) {
                System.out.println("[RegistrarProductoServlet] Producto registrado: " + producto.getNombre());
                response.sendRedirect("catalogoProductos.jsp?ok=registrado");
            } else {
                response.sendRedirect("catalogoProductos.jsp?error=dao");
            }

        } catch (NumberFormatException ex) {
            System.err.println("[RegistrarProductoServlet] Error de formato numérico: " + ex.getMessage());
            response.sendRedirect("catalogoProductos.jsp?error=parametros");
        } catch (Exception ex) {
            System.err.println("[RegistrarProductoServlet] Error general: " + ex.getMessage());
            response.sendRedirect("catalogoProductos.jsp?error=dao");
        }
    }
}