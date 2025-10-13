/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycom.symphonysias.adminlte01;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;



/**
 * Servlet de autenticación para SymphonySIAS-AdminLTE01
 * @author Spiri
 */


public class LoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());
    
    // Metodo para convertir la clave a SHA-256
    private String sha256(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length()== 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            return null;
        }    
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String user = request.getParameter("usuario");
        String pass = request.getParameter("clave");
        
        // Trazabilidad directa
        System.out.println("Usuario recibido: " + user);
        System.out.println("Clave original: " + pass);
        
        //  Convertir la clave ingresada a SHA-256
        String hashedPass = sha256(pass);
        
        // Trazabilidad del hash
        System.out.println("Clave cifrada: " + hashedPass);
        
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validar(user, hashedPass); // método que consulta la BD con el hash
        
               
        if (usuario != null) {
            System.out.println("[LOGIN] Usuario validado: " + usuario.getUsuario() + " - Rol: " + usuario.getRol());
            System.out.println("[LOGIN] Validación ejecutada para usuario: " + user);
            LOGGER.log(Level.INFO, "[LOGIN] Usuario validado: {0} - Rol: {1}", new Object[]{usuario.getUsuario(), usuario.getRol()});
            
            HttpSession session = request.getSession();
            session.setAttribute("usuarioActivo", usuario.getUsuario()); //"usuario"
            session.setAttribute("nombreActivo", usuario.getNombre()); //"nombre"
            
            String rolNormalizado = usuario.getRol().toLowerCase().trim();
            if ("admin".equals(rolNormalizado)) {
                rolNormalizado = "administrador";
            }            
            session.setAttribute("rolActivo", rolNormalizado); //"rol"
            response.sendRedirect("dashboard.jsp"); //por error se cambia el index.jsp 04OCT2025h1123
        } else {
            request.setAttribute("error", "Credenciales inválidas");
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }
    }
}
 