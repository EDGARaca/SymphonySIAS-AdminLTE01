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
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import java.io.IOException;
import java.sql.Timestamp;



public class RegistrarProductoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String usuario = (String) session.getAttribute("usuario");
        String rol = (String) session.getAttribute("rol");

        if (usuario == null || !(rol.equals("ADMIN") || rol.equals("DIRECTOR") || rol.equals("COORDINADOR"))) {
            response.sendRedirect("catalogoProductos.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String imagen = request.getParameter("imagen");
        boolean oferta = Boolean.parseBoolean(request.getParameter("oferta"));
        double descuento = Double.parseDouble(request.getParameter("descuento"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        ProductoMusical producto = new ProductoMusical();
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setPrecio(precio);
        producto.setImagen(imagen);
        producto.setOfertaActiva(oferta);
        producto.setDescuento(descuento);
        producto.setCantidadDisponible(cantidad);
        producto.setUsuarioRegistro(usuario);
        producto.setFechaRegistro(new Timestamp(System.currentTimeMillis()));

        ProductoMusicalDAO dao = new ProductoMusicalDAO();
        dao.registrar(producto);

        response.sendRedirect("catalogoProductos.jsp");
    }
}
