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
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;


@WebServlet("/CrearUsuarioServlet")
public class CrearUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        // Paso para configurar codificación UTF-8
        request.setCharacterEncoding("UTF-8");


        // 1. Recuperar datos del formulario
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));

        // 2. Encriptar la clave con SHA-256
        String claveEncriptada = encriptarSHA256(clave);

        // 3. Crear objeto Usuario
        Usuario nuevo = new Usuario();
        nuevo.setNombre(nombre);
        nuevo.setUsuario(usuario);
        nuevo.setClave(claveEncriptada);
        nuevo.setCorreo(correo);
        nuevo.setRol(rol);
        nuevo.setActivo(estado);

        // 4. Registrar en la base de datos
        UsuarioDAO dao = new UsuarioDAO();
        boolean creado = dao.crear(nuevo);

        // 5. Redirigir con trazabilidad
        if (creado) {
            response.sendRedirect("UsuarioServlet?creado=true");
        } else {
            response.sendRedirect("UsuarioServlet?error=creacion");
        }
    }

    // Método para encriptar clave en SHA-256
    private String encriptarSHA256(String clave) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(clave.getBytes("UTF-8"));
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
            return null;
        }

    }
}