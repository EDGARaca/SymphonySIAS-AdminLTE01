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



@WebServlet("/EliminarUsuarioServlet")
public class EliminarUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("UsuarioServlet?error=eliminacion");
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        boolean eliminado = dao.eliminarUsuario(id);

        if (eliminado) {
            response.sendRedirect("UsuarioServlet?eliminado=true");
        } else {
            response.sendRedirect("UsuarioServlet?error=eliminacion");
        }
    }
}

