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
import com.mycom.symphonysias.adminlte01.modelo.*;
import com.mycom.symphonysias.adminlte01.dao.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;


public class FinalizarCompraServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        String usuario = (String) session.getAttribute("usuario");

        if (carrito == null || carrito.isEmpty() || usuario == null) {
            response.sendRedirect("carrito.jsp");
            return;
        }

        double total = 0;
        for (ItemCarrito item : carrito) {
            total += item.getSubtotal();
        }

        Compra compra = new Compra();
        compra.setUsuario(usuario);
        compra.setFecha(new Timestamp(System.currentTimeMillis()));
        compra.setTotal(total);

        CompraDAO compraDAO = new CompraDAO();
        int idCompra = compraDAO.registrarCompra(compra);

        DetalleCompraDAO detalleDAO = new DetalleCompraDAO();
        for (ItemCarrito item : carrito) {
            DetalleCompra detalle = new DetalleCompra();
            detalle.setIdCompra(idCompra);
            detalle.setIdProducto(item.getProducto().getId());
            detalle.setCantidad(item.getCantidad());
            detalle.setPrecioUnitario(item.getProducto().getPrecio());
            detalle.setSubtotal(item.getSubtotal());
            detalleDAO.registrarDetalle(detalle);
        }

        session.removeAttribute("carrito");
        response.sendRedirect("catalogoProductos.jsp");
    }
}