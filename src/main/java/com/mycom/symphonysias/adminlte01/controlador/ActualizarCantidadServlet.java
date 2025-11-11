/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.controlador;

import javax.servlet.*;
import javax.servlet.http.*;
import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;

import java.io.IOException;
import java.util.List;


public class ActualizarCantidadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));

        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");

        if (carrito != null) {
            for (ItemCarrito item : carrito) {
                if (item.getProducto().getId() == idProducto) {
                    item.setCantidad(nuevaCantidad);
                    break;
                }
            }
            session.setAttribute("carrito", carrito);
        }

        response.sendRedirect("carrito.jsp");
    }
}

