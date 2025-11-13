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
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import javax.servlet.annotation.WebServlet;



@WebServlet("/AgregarCarritoServlet")

public class AgregarCarritoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            
            System.out.println("[Servlet] ID recibido: " + idProducto);
            System.out.println("[Servlet] Cantidad recibida: " + cantidad);


            HttpSession session = request.getSession();
            List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
            if (carrito == null) {
                carrito = new ArrayList<>();
            }

            ProductoMusicalDAO dao = new ProductoMusicalDAO();
            ProductoMusical producto = dao.buscarPorId(idProducto);

            boolean encontrado = false;
            for (ItemCarrito item : carrito) {
                if (item.getProducto().getIdProducto() == idProducto) {
                    item.setCantidad(item.getCantidad() + cantidad);
                    encontrado = true;
                    break;
                }
            }

            if (!encontrado) {
                carrito.add(new ItemCarrito(producto, cantidad));
            }
            
            System.out.println("[Servlet] Producto agregado: " + producto.getNombre());
            System.out.println("[Servlet] Carrito actual:");
            for (ItemCarrito item : carrito) {
                System.out.println(" - " + item.getProducto().getNombre() + " x" + item.getCantidad());
            }

            
            session.setAttribute("carrito", carrito);
            response.sendRedirect("verCarrito.jsp");

        } catch (NumberFormatException | NullPointerException e) {
            response.sendRedirect("error.jsp"); // O muestra un mensaje de error
        }
    }
}