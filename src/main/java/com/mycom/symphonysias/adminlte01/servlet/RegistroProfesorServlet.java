/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.modelo.Profesor;
import com.mycom.symphonysias.adminlte01.dao.ProfesorDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegistroProfesorServlet")
public class RegistroProfesorServlet extends HttpServlet {
    
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        System.out.println("[SERVLET] Nombre recibido: " + request.getParameter("nombre"));
        System.out.println("[SERVLET] Especialidad recibida: " + request.getParameter("especialidad"));
      
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String documento = request.getParameter("documento");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String fecha_nacimiento = request.getParameter("fecha_nacimiento");
        String especialidad = request.getParameter("especialidad");
        String genero = request.getParameter("genero");
        String estado = request.getParameter("estado");
        String usuario_registro = request.getParameter("usuario_registro");

        Profesor profesor = new Profesor();
        profesor.setNombre(nombre);
        profesor.setApellido(apellido);
        profesor.setDocumento(documento);
        profesor.setDireccion(direccion);
        profesor.setTelefono(telefono);
        profesor.setCorreo(correo);
        profesor.setFecha_nacimiento(fecha_nacimiento);
        profesor.setEspecialidad(especialidad);
        profesor.setGenero(genero);
        profesor.setEstado(estado);
        profesor.setUsuario_registro(usuario_registro);

        ProfesorDAO dao = new ProfesorDAO();
        boolean registrado = dao.insertarProfesor(profesor);

        if (registrado) {
            response.sendRedirect("listarProfesores.jsp?registrado=ok");
        } else {
            response.sendRedirect("registroProfesor.jsp?error=bd");
        }
    }
    
    
    
    
    
    
}