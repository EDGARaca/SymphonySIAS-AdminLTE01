/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import com.mycom.symphonysias.adminlte01.util.HashUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/CambiarClaveServlet")
public class CambiarClaveServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CambiarClaveServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String usuarioActivo = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;

        if (usuarioActivo == null) {
            LOGGER.warning("[SERVLET] Sesión inválida, redirigiendo a login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String claveActual = request.getParameter("claveActual");
            String claveNueva = request.getParameter("claveNueva");
            String claveConfirmacion = request.getParameter("claveConfirmacion");

            // Validaciones básicas
            if (claveActual == null || claveNueva == null || claveConfirmacion == null ||
                claveNueva.trim().isEmpty() || !claveNueva.equals(claveConfirmacion)) {
                request.setAttribute("error", "Las claves no coinciden o son inválidas.");
                LOGGER.warning("[SERVLET] Validación fallida: claves no coinciden o son inválidas");
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
                return;
            }

            UsuarioDAO dao = new UsuarioDAO();

            // Validar clave actual contra la BD
            String hashActual = HashUtil.sha256(claveActual);
            Usuario usuario = dao.validar(usuarioActivo, hashActual);

            if (usuario == null) {
                request.setAttribute("error", "La clave actual es incorrecta.");
                LOGGER.warning("[SERVLET] Clave actual incorrecta para usuario: " + usuarioActivo);
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
                return;
            }

            // Generar hash de la nueva clave y actualizar
            String nuevoHash = HashUtil.sha256(claveNueva);
            boolean actualizado = dao.actualizarClave(usuario.getId(), nuevoHash);

            if (actualizado) {
                request.setAttribute("mensaje", "Clave actualizada correctamente.");
                LOGGER.info("[SERVLET] Clave actualizada correctamente para usuario: " + usuarioActivo);
            } else {
                request.setAttribute("error", "Error al actualizar la clave.");
                LOGGER.severe("[SERVLET] Error al actualizar clave para usuario: " + usuarioActivo);
            }

            // Redirigir al JSP con mensaje
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[SERVLET] Excepción al cambiar clave", e);
            request.setAttribute("error", "Ocurrió un error inesperado al cambiar la clave.");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        }
    }
}