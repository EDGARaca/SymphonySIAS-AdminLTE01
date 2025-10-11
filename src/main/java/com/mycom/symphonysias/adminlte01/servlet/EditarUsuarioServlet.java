/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditarUsuarioServlet") // Esto activa el servlet sin necesidad de web.xml si usas anotaciones
public class EditarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // 1. Recuperar datos del formulario
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String rol = request.getParameter("rol");
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));

        // 2. Crear objeto Usuario con los datos actualizados
        Usuario u = new Usuario();
        u.setId(id);
        u.setNombre(nombre);
        u.setUsuario(usuario);
        u.setRol(rol);
        u.setActivo(estado);

        // 3. Actualizar en la base de datos
        UsuarioDAO dao = new UsuarioDAO();
        boolean actualizado = dao.actualizar(u);

        // 4. Redirigir con trazabilidad
        if (actualizado) {
            response.sendRedirect("usuarios.jsp?actualizado=true");
        } else {
            response.sendRedirect("usuarios.jsp?error=actualizacion");
        }
    }
}
