/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class EliminarCarritoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");

        if (carrito != null) {
            carrito.removeIf(item -> item.getProducto().getId() == idProducto);
            session.setAttribute("carrito", carrito);
        }

        response.sendRedirect("carrito.jsp");
    }
}
