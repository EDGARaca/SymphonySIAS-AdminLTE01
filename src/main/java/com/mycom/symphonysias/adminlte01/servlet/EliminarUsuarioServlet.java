/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.servlet;

/**
 *
 * @author Spiri
 */

import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;



public class EliminarUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        System.out.println("[ELIMINAR USUARIO] ID recibido: " + id);

        UsuarioDAO dao = new UsuarioDAO();
        boolean eliminado = dao.eliminarUsuario(id);

        if (eliminado) {
            response.sendRedirect("listarUsuario.jsp?eliminado=true");
        } else {
            response.sendRedirect("listarUsuario.jsp?error=eliminacion");
        }
    }
}

