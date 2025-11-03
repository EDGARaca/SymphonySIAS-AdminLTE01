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
import java.util.logging.Logger;
import java.util.logging.Level;
import com.mycom.symphonysias.adminlte01.util.HashUtil;

/**
 * Servlet de autenticación para SymphonySIAS-AdminLTE01
 * @author Spiri
 */
public class LoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String user = request.getParameter("usuario");
        String pass = request.getParameter("clave");
        
        // Validación de parámetros
        if (user == null || pass == null || user.trim().isEmpty() || pass.trim().isEmpty()) {
            LOGGER.warning("[LOGIN] Intento de login con credenciales vacías");
            request.setAttribute("error", "Debe ingresar usuario y contraseña.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Trazabilidad
        LOGGER.info("[LOGIN] Intento de login para usuario: " + user);
        System.out.println("[LOGIN] Usuario recibido: " + user);
        System.out.println("[LOGIN] Clave original recibida (longitud): " + pass.length());
        
        // Convertir la clave ingresada a SHA-256 (UNA SOLA VEZ)
        String hashedPass = HashUtil.sha256(pass);
        System.out.println("[LOGIN] Hash SHA-256 generado: " + hashedPass);
        
        try {
            UsuarioDAO dao = new UsuarioDAO();
            Usuario usuario = dao.validar(user, hashedPass);
            
            if (usuario != null) {
                System.out.println("[LOGIN] Usuario encontrado: " + usuario.getUsuario());
                System.out.println("[LOGIN] Estado activo: " + usuario.isActivo());
                System.out.println("[LOGIN] Rol desde BD: " + usuario.getRol());
                
                if (usuario.isActivo()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("usuarioActivo", usuario.getUsuario());
                    session.setAttribute("nombreActivo", usuario.getNombre());
                    
                    // Normalización de rol para mantener consistencia
                    String rolOriginal = usuario.getRol().trim().toUpperCase();
                    String rolNormalizado;
                    
                    switch (rolOriginal) {
                        case "ADMIN":
                        case "ADMINISTRADOR":
                        case "ADMINISTRADOR SIAS":
                            rolNormalizado = "ADMINISTRADOR SIAS";
                            break;
                        case "DOC":
                        case "DOCENTE":
                            rolNormalizado = "DOCENTE";
                            break;
                        case "COORD":
                        case "COORDINADOR":
                        case "COORDINADOR ACADÉMICO":
                        case "COORDINADOR ACADEMICO":
                            rolNormalizado = "COORDINADOR ACADÉMICO";
                            break;
                        case "DIR":
                        case "DIRECTOR":
                            rolNormalizado = "DIRECTOR";
                            break;
                        case "AUXADMIN":
                        case "AUXILIAR ADMINISTRATIVO":
                            rolNormalizado = "AUXILIAR ADMINISTRATIVO";
                            break;
                        case "AUXCONT":
                        case "AUXILIAR CONTABLE":
                            rolNormalizado = "AUXILIAR CONTABLE";
                            break;
                        case "EST":
                        case "ESTUDIANTE":
                            rolNormalizado = "ESTUDIANTE";
                            break;
                        default:
                            rolNormalizado = rolOriginal;
                            break;
                    }
                    
                    session.setAttribute("rolActivo", rolNormalizado);
                    session.setMaxInactiveInterval(1800); // 30 minutos
                    
                    LOGGER.info("[LOGIN] Login exitoso - Usuario: " + user + " | Rol: " + rolNormalizado);
                    System.out.println("[LOGIN] Sesión creada exitosamente");
                    System.out.println("[LOGIN] Rol normalizado guardado: " + rolNormalizado);
                    
                    // Redirección al dashboard
                    response.sendRedirect("dashboard.jsp");
                    
                } else {
                    LOGGER.warning("[LOGIN] Usuario inactivo: " + user);
                    request.setAttribute("error", "Usuario inactivo. Contacte al administrador.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                LOGGER.warning("[LOGIN] Credenciales inválidas para usuario: " + user);
                System.out.println("[LOGIN] Usuario no encontrado o contraseña incorrecta");
                request.setAttribute("error", "Credenciales inválidas. Verifique usuario y contraseña.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[LOGIN] Error en el proceso de autenticación", e);
            System.err.println("[LOGIN ERROR] " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error del sistema. Intente nuevamente.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}