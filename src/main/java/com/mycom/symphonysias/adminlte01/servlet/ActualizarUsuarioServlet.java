/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class ActualizarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        String estado = request.getParameter("estado");

        System.out.println("[ACTUALIZAR USUARIO] ID: " + id);
        System.out.println("[ACTUALIZAR USUARIO] Usuario: " + usuario);

        Usuario u = new Usuario();
        u.setId(Integer.parseInt(id));
        u.setNombre(nombre);
        u.setUsuario(usuario);
        u.setCorreo(correo);
        u.setRol(rol);
        u.setActivo("true".equals(estado));

        UsuarioDAO dao = new UsuarioDAO();
        boolean actualizado = dao.actualizar(u);

        if (actualizado) {
            response.sendRedirect("listarUsuario.jsp?actualizado=true");
        } else {
            response.sendRedirect("listarUsuario.jsp?error=actualizacion");
        }
    }
}