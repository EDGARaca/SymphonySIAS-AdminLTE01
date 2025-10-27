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
import java.util.logging.Logger;
import com.mycom.symphonysias.adminlte01.util.HashUtil;




/**
 * Servlet de autenticación para SymphonySIAS-AdminLTE01
 * @author Spiri
 */


public class LoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());
    
    // Metodo para convertir la clave a SHA-256
    public static String sha256(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al generar hash SHA-256", e);
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
        String hashedPass = HashUtil.sha256(pass);
        System.out.println("[DEBUG] Hash generado: " + hashedPass);
        
        // Trazabilidad del hash
        System.out.println("Clave cifrada: " + hashedPass);
        
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validar(user, hashedPass); // método que consulta la BD con el hash
        
               
        if (usuario != null && usuario.isActivo()) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioActivo", usuario.getUsuario());
            session.setAttribute("nombreActivo", usuario.getNombre());

            String rolOriginal = usuario.getRol().trim().toLowerCase();
            String rolNormalizado;

            switch (rolOriginal) {
                case "admin":
                    rolNormalizado = "administrador";
                    break;
                case "doc":
                case "docente":
                    rolNormalizado = "docente";
                    break;
                case "coord":
                case "coordinador":
                    rolNormalizado = "coordinador académico";
                    break;
                case "dir":
                case "director":
                    rolNormalizado = "director";
                    break;
                case "auxadmin":
                    rolNormalizado = "auxiliar administrativo";
                    break;
                case "auxcont":
                    rolNormalizado = "auxiliar contable";
                    break;
                case "est":
                case "estudiante":
                    rolNormalizado = "estudiante";
                    break;
                default:
                    rolNormalizado = rolOriginal;
                    break;
            }

            session.setAttribute("rolActivo", rolNormalizado);

            // Redirección por rol
            switch (rolNormalizado) {
                case "administrador":
                    response.sendRedirect("admin/dashboard.jsp");
                    break;
                case "coordinador académico":
                    response.sendRedirect("coordinador/dashboard.jsp");
                    break;
                case "docente":
                    response.sendRedirect("docente/dashboard.jsp");
                    break;
                case "estudiante":
                    response.sendRedirect("estudiante/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect("dashboard.jsp");
                    break;
            }

        } else {
            request.setAttribute("error", "Credenciales inválidas o usuario inactivo.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
 