/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/*
 * Servlet de autenticación de SymphonySIAS-AdminLTE.
 * Cumple ISO/IEC 25010:
 * - Confiabilidad: validación robusta, normalización de rol, manejo de errores y redirecciones con contextPath.
 * - Mantenibilidad: comentarios claros, trazabilidad con java.util.logging, codificación UTF-8 consistente.
 * - Trazabilidad: logs en cada decisión de flujo (login ok, inactivo, credenciales inválidas, errores).
 *
 * Integración:
 * - NetBeans 27 + JDK 21 + Tomcat 9.
 * - BD: jdbc:mysql://localhost:3306/login_symphony (DAO valida usuario + SHA-256).
 * - La sesión almacena "usuario" y "rol" (usados por JSP/JSTL y fragmento de roles.jspf).
 */

package com.mycom.symphonysias.adminlte01;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import com.mycom.symphonysias.adminlte01.util.HashUtil;
import java.util.logging.Logger;
import java.util.logging.Level;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        final String contextPath = request.getContextPath();

        String user = request.getParameter("usuario");
        String pass = request.getParameter("clave");

        // Validación de parámetros
        if (user == null || pass == null || user.trim().isEmpty() || pass.trim().isEmpty()) {
            LOGGER.warning("[LOGIN] Intento de login con credenciales vacías");
            request.setAttribute("error", "Debe ingresar usuario y contraseña.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        LOGGER.log(Level.INFO, "[LOGIN] Intento de login para usuario: {0}", user);

        // Hash de la clave ingresada
        String hashedPass = HashUtil.sha256(pass);

        try {
            UsuarioDAO dao = new UsuarioDAO();
            Usuario usuario = dao.validar(user, hashedPass); // compara usuario + hash

            if (usuario != null) {
                LOGGER.log(Level.INFO, "[LOGIN] Usuario encontrado: {0}", usuario.getUsuario());

                if (usuario.isActivo()) {
                    HttpSession session = request.getSession(true);
                    String usuarioNormalizado = usuario.getUsuario().trim().toLowerCase();

                    // Atributos de sesión usados por JSP/JSTL y filtros
                    session.setAttribute("usuarioActivo", usuarioNormalizado);
                    session.setAttribute("nombreActivo", usuario.getNombre());
                    session.setAttribute("usuario", usuarioNormalizado);

                    // Normalización de rol a valores estándar para JSP/roles.jspf
                    String rolOriginal = usuario.getRol() != null ? usuario.getRol().trim().toLowerCase() : "";
                    String rolNormalizado = normalizarRol(rolOriginal);
                    session.setAttribute("rol", rolNormalizado);

                    // Tiempo de sesión (30 minutos)
                    session.setMaxInactiveInterval(1800);

                    LOGGER.log(Level.INFO, "[LOGIN] Login exitoso - Usuario: {0} | Rol: {1}",
                            new Object[]{usuarioNormalizado, rolNormalizado});

                    // Redirección segura usando contextPath
                    response.sendRedirect(contextPath + "/dashboard.jsp");
                    return;

                } else {
                    LOGGER.log(Level.WARNING, "[LOGIN] Usuario inactivo: {0}", user);
                    request.setAttribute("error", "Usuario inactivo. Contacte al administrador.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
            } else {
                LOGGER.log(Level.WARNING, "[LOGIN] Credenciales inválidas para usuario: {0}", user);
                request.setAttribute("error", "Credenciales inválidas. Verifique usuario y contraseña.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[LOGIN] Error en el proceso de autenticación", e);
            request.setAttribute("error", "Error del sistema. Intente nuevamente.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        final String contextPath = request.getContextPath();

        // Manejo de logout explícito por parámetro (?logout=true)
        String logout = request.getParameter("logout");
        if ("true".equalsIgnoreCase(logout)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
                LOGGER.info("[LOGIN] Sesión invalidada por logout.");
            }
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // Por defecto, dirigir al login
        response.sendRedirect(contextPath + "/login.jsp");
    }

    /**
     * Normaliza el rol recibido desde BD a valores estándar para evitar problemas de coincidencia en los JSP.
     * Retorna uno de: admin, director, coordinador, profesor, auxadmin, auxcont, estudiante.
     */
    private String normalizarRol(String rolOriginal) {
        if (rolOriginal == null) return "";

        switch (rolOriginal) {
            case "admin":
            case "administrador":
            case "administrador sias":
                return "admin";

            case "dir":
            case "director":
                return "director";

            case "coord":
            case "coordinador":
            case "coordinador académico":
            case "coordinador academico":
                return "coordinador";

            case "doc":
            case "docente":
            case "profesor":
                return "profesor";

            case "auxadmin":
            case "auxiliar administrativo":
                return "auxadmin";

            case "auxcont":
            case "auxiliar contable":
                return "auxcont";

            case "est":
            case "estudiante":
                return "estudiante";

            default:
                return rolOriginal; // fallback
        }
    }
}