/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 * Servlet para listar productos musicales.
 * ISO/IEC 25010:
 * - Confiabilidad: manejo robusto de excepciones.
 * - Mantenibilidad: separación de responsabilidades (DAO vs JSP).
 * - Trazabilidad: logs claros de flujo.
 */
package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "CatalogoProductosServlet", urlPatterns = {"/CatalogoProductosServlet"})
public class CatalogoProductosServlet extends HttpServlet {
     private static final long serialVersionUID = 1L;

    private static final Logger LOGGER = Logger.getLogger(CatalogoProductosServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Recuperar productos desde DAO
            ProductoMusicalDAO dao = new ProductoMusicalDAO();
            List<ProductoMusical> productos = dao.listar();

            // Trazabilidad
            LOGGER.log(Level.INFO, "[CATÁLOGO] Productos recuperados: {0}", productos.size());

            // Enviar resultados al JSP
            request.setAttribute("productos", productos);
            request.getRequestDispatcher("catalogoProductos.jsp").forward(request, response);

        } catch (Exception e) {
            // Manejo de error confiable
            LOGGER.log(Level.SEVERE, "[CATÁLOGO] Error al listar productos", e);
            request.setAttribute("error", "Error al cargar catálogo de productos musicales.");
            request.getRequestDispatcher("catalogoProductos.jsp").forward(request, response);
        }
    }
}