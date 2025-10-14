/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mycom.symphonysias.adminlte01.util.Conexion;

@WebServlet("/CambiarClaveServlet")
public class CambiarClaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        String usuario = (String) session.getAttribute("usuarioActivo");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String claveActual = request.getParameter("claveActual");
        String claveNueva = request.getParameter("claveNueva");
        String claveConfirmacion = request.getParameter("claveConfirmacion");

        if (!claveNueva.equals(claveConfirmacion)) {
            request.setAttribute("error", "La nueva clave y su confirmación no coinciden.");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            return;
        }

        try (Connection con = Conexion.getConexion()) {
            PreparedStatement ps = con.prepareStatement("SELECT clave FROM usuarios WHERE usuario = ?");
            ps.setString(1, usuario);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String claveEncriptadaActual = encriptarSHA256(claveActual);
                String claveBD = rs.getString("clave");

                if (!claveBD.equals(claveEncriptadaActual)) {
                    request.setAttribute("error", "La clave actual es incorrecta.");
                    request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
                    return;
                }

                String nuevaClaveEncriptada = encriptarSHA256(claveNueva);
                PreparedStatement psUpdate = con.prepareStatement("UPDATE usuarios SET clave = ? WHERE usuario = ?");
                psUpdate.setString(1, nuevaClaveEncriptada);
                psUpdate.setString(2, usuario);
                psUpdate.executeUpdate();

                System.out.println("[CLAVE] Clave actualizada para usuario: " + usuario);
                request.setAttribute("mensaje", "Clave actualizada correctamente.");
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.err.println("[ERROR] Error al actualizar la clave: " + e.getMessage());
            request.setAttribute("error", "Error al actualizar la clave.");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        }
    }

    private String encriptarSHA256(String clave) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(clave.getBytes("UTF-8"));
        StringBuilder hex = new StringBuilder();
        for (byte b : hash) {
            hex.append(String.format("%02x", b));
        }
        return hex.toString();
    }
}