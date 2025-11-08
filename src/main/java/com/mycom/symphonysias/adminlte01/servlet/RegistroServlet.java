/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Spiri
 */

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

    private String encriptarSHA256(String texto) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(texto.getBytes());
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        String confirmar = request.getParameter("confirmar");

        if (nombre == null || usuario == null || correo == null || clave == null || confirmar == null ||
            nombre.isEmpty() || usuario.isEmpty() || correo.isEmpty() || clave.isEmpty() || confirmar.isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        if (!clave.equals(confirmar)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        String claveEncriptada = encriptarSHA256(clave);
        if (claveEncriptada == null) {
            request.setAttribute("error", "Error al encriptar la contraseña.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        Usuario nuevo = new Usuario();
        nuevo.setNombre(nombre);
        nuevo.setUsuario(usuario);
        nuevo.setCorreo(correo);
        nuevo.setClave(claveEncriptada);
        String rol = request.getParameter("rol");
        nuevo.setRol(rol != null ? rol : "estudiante");
        nuevo.setActivo(true);
        
        System.out.println("[DEBUG] Datos recibidos:");
        System.out.println("Nombre: " + nombre);
        System.out.println("Usuario: " + usuario);
        System.out.println("Correo: " + correo);
        System.out.println("Clave (SHA-256): " + claveEncriptada);

        UsuarioDAO dao = new UsuarioDAO();
        if (dao == null) {
            System.out.println("[ERROR] UsuarioDAO no se pudo instanciar.");
        }
        
        System.out.println("[DEBUG] Intentando crear usuario en BD...");
        
        boolean creado = dao.crear(nuevo);
        

        if (creado) {
        System.out.println("[DEBUG] Usuario creado correctamente.");
        response.sendRedirect("login.jsp?registro=exitoso");
        return;
        }

        System.out.println("[ERROR] Fallo al crear usuario.");
        request.setAttribute("error", "No se pudo registrar el usuario. Intenta nuevamente.");
        request.getRequestDispatcher("registro.jsp").forward(request, response);
            
    }
}