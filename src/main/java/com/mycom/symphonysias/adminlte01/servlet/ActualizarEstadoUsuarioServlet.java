/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class ActualizarEstadoUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        String estadoParam = request.getParameter("estado");

        System.out.println("[ACTUALIZAR ESTADO] ID recibido: " + idParam);
        System.out.println("[ACTUALIZAR ESTADO] Estado recibido: " + estadoParam);

        try {
            int id = Integer.parseInt(idParam);
            boolean estado = Boolean.parseBoolean(estadoParam);

            UsuarioDAO dao = new UsuarioDAO();
            boolean actualizado = dao.actualizarEstado(id, estado);

            if (actualizado) {
                response.sendRedirect("listarUsuario.jsp?estadoActualizado=true");
            } else {
                response.sendRedirect("listarUsuario.jsp?estado=error");
            }

        } catch (Exception e) {
            System.err.println("[ERROR SERVLET] Fallo al actualizar estado: " + e.getMessage());
            response.sendRedirect("listarUsuario.jsp?estado=error");
        }
    }
}