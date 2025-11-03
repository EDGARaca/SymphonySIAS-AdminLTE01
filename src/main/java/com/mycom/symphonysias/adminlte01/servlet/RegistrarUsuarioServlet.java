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


public class RegistrarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        String estado = request.getParameter("estado");
        
        if (nombre == null || usuario == null || correo == null || rol == null || estado == null ||
            nombre.isEmpty() || usuario.isEmpty() || correo.isEmpty()) {
            response.sendRedirect("listarUsuario.jsp?error=camposIncompletos");
            return;
        }

        System.out.println("[REGISTRO USUARIO] Nombre: " + nombre);
        System.out.println("[REGISTRO USUARIO] Usuario: " + usuario);
        System.out.println("[REGISTRO USUARIO] Correo: " + correo);
        System.out.println("[REGISTRO USUARIO] Rol: " + rol);
        System.out.println("[REGISTRO USUARIO] Estado: " + estado);

        UsuarioDAO dao = new UsuarioDAO();

        // Validación de duplicado
        if (dao.existeUsuario(usuario)) {
            System.out.println("[REGISTRO USUARIO] Usuario duplicado detectado.");
            response.sendRedirect("listarUsuario.jsp?error=usuarioDuplicado");
            return;
        }

        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setUsuario(usuario);
        nuevoUsuario.setCorreo(correo);
        nuevoUsuario.setRol(rol);
        nuevoUsuario.setActivo("true".equals(estado));
        nuevoUsuario.setClave("123456"); // clave temporal institucional

        boolean registrado = dao.crear(nuevoUsuario);

        if (registrado) {
            response.sendRedirect("listarUsuario.jsp?creado=true");
        } else {
            response.sendRedirect("listarUsuario.jsp?error=creacion");
        }
    }
}
