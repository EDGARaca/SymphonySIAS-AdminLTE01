/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

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

        // Paso 1: Configurar codificación UTF-8
        request.setCharacterEncoding("UTF-8");

        // Paso 2: Recuperar datos del formulario
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));

        // Paso 3: Encriptar la clave con SHA-256
        String claveEncriptada = encriptarSHA256(clave);

        // Paso 4: Validar duplicado y normalizar rol
        UsuarioDAO dao = new UsuarioDAO();

        if (dao.existeUsuario(usuario)) {
            response.sendRedirect("UsuarioServlet?error=duplicado");
            return;
        }

        String rolNormalizado;
        switch (rol.trim().toLowerCase()) {
            case "admin":
                rolNormalizado = "administrador";
                break;
            case "coord":
            case "coordinador":
                rolNormalizado = "coordinador académico";
                break;
            case "doc":
            case "docente":
                rolNormalizado = "docente";
                break;
            case "est":
            case "estudiante":
                rolNormalizado = "estudiante";
                break;
            case "auxadmin":
                rolNormalizado = "auxiliar administrativo";
                break;
            case "auxcont":
                rolNormalizado = "auxiliar contable";
                break;
            default:
                rolNormalizado = rol;
                break;
        }

        // Paso 5: Crear objeto Usuario
        Usuario nuevo = new Usuario();
        nuevo.setNombre(nombre);
        nuevo.setUsuario(usuario);
        nuevo.setClave(claveEncriptada);
        nuevo.setCorreo(correo);
        nuevo.setRol(rolNormalizado);
        nuevo.setActivo(estado);

        // Paso 6: Registrar en la base de datos
        boolean creado = dao.crear(nuevo);

        // Paso 7: Redirigir con trazabilidad
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
            System.err.println("[ERROR] Fallo al encriptar clave: " + e.getMessage());
            return null;
        }
    }
}