/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycom.symphonysias.adminlte01;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import java.util.List;


/**
 * Servlet de autenticación para SymphonySIAS-AdminLTE01
 * @author Spiri
 */
@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> lista = dao.listarUsuarios();
        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lógica para editar o eliminar usuarios, si se usa por POST
        // Trazabilidad de recepción
        System.out.println("[DEBUG] EditarUsuarioServlet recibió datos POST");
        
        // Obtener datos del formulario del modal
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));

        // Trazabilidad de datos recibidos
        System.out.println("[DEBUG] ID: " + id);
        System.out.println("[DEBUG] Nombre: " + nombre);
        System.out.println("[DEBUG] Usuario: " + usuario);
        System.out.println("[DEBUG] Rol: " + rol);
        System.out.println("[DEBUG] Estado: " + estado);

        /* Crear objeto Usuario con los datos actualizados*/
        
        Usuario u = new Usuario();
        u.setId(id);
        u.setNombre(nombre);
        u.setUsuario(usuario);
        u.setCorreo(correo);
        u.setRol(rol);
        u.setActivo(estado);

        // Actualizar en BD
        UsuarioDAO dao = new UsuarioDAO();
        boolean actualizado = dao.actualizar(u);

        // Trazabilidad del resultado
        if (actualizado) {
            System.out.println("[DEBUG] Usuario actualizado correctamente");
        } else {
            System.out.println("[ERROR] Falló la actualización del usuario");
        }

        // Reemplazo de redirección por recarga con datos actualizados
        List<Usuario> lista = dao.listarUsuarios();
        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);


    }
}
