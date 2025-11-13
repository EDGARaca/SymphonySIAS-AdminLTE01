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
import java.io.*;
import java.sql.Timestamp;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import javax.servlet.annotation.MultipartConfig;


@MultipartConfig
public class GuardarProductoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int descuento = Integer.parseInt(request.getParameter("descuento"));

            Part imagenPart = request.getPart("imagen");
            String rutaImagen = null;

            if (imagenPart != null && imagenPart.getSize() > 0) {
                String nombreArchivo = imagenPart.getSubmittedFileName();
                String rutaDestino = getServletContext().getRealPath("/assets/adminlte/img/" + nombreArchivo);
                imagenPart.write(rutaDestino);
                rutaImagen = "assets/adminlte/img/" + nombreArchivo;
            }

            ProductoMusical producto = new ProductoMusical();
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            producto.setDescuento(descuento);
            if (rutaImagen != null) {
                producto.setRutaImagen(rutaImagen);
            }
            
            // Inicialización de campos institucionales
            producto.setUsuarioRegistro("admin"); // Puedes reemplazar por el usuario logueado si lo tienes en sesión
            producto.setFechaRegistro(new Timestamp(System.currentTimeMillis()));
            producto.setOfertaActiva(true); // Por defecto activa
            producto.setCantidadDisponible(10); // Valor inicial si no se gestiona desde el formulario


            ProductoMusicalDAO dao = new ProductoMusicalDAO();

            if (idStr != null && !idStr.isEmpty()) {
                producto.setId(Integer.parseInt(idStr));
                dao.actualizar(producto);
            } else {
                dao.registrar(producto);
            }

            response.sendRedirect("adminProductos.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}