/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.ProfesorDAO;
import com.mycom.symphonysias.adminlte01.modelo.Profesor;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class EditarProfesorServlet extends HttpServlet {
    
    public EditarProfesorServlet() {
        System.out.println("[SERVLET] EditarProfesorServlet cargado correctamente.");
    }

    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            request.setCharacterEncoding("UTF-8");
            
            System.out.println("[SERVLET] Nombre recibido: " + request.getParameter("nombre"));
            System.out.println("[SERVLET] Especialidad recibida: " + request.getParameter("especialidad"));

        try {
            int id = Integer.parseInt(request.getParameter("id"));
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

            ProfesorDAO dao = new ProfesorDAO();
            Profesor profesorExistente = dao.buscarPorId(id);

            if (profesorExistente == null) {
                response.sendRedirect("listarProfesores.jsp?error=noencontrado");
                return;
            }

            // Actualizar campos editables
            profesorExistente.setNombre(nombre);
            profesorExistente.setApellido(apellido);
            profesorExistente.setDocumento(documento);
            profesorExistente.setDireccion(direccion);
            profesorExistente.setTelefono(telefono);
            profesorExistente.setCorreo(correo);
            profesorExistente.setFecha_nacimiento(fecha_nacimiento);
            profesorExistente.setEspecialidad(especialidad);
            profesorExistente.setGenero(genero);
            profesorExistente.setEstado(estado);
            profesorExistente.setUsuario_registro(usuario_registro); // ✅ CORREGIDO

            boolean actualizado = dao.actualizar_Profesor(profesorExistente);

            if (actualizado) {
                response.sendRedirect("listarProfesores.jsp?editado=ok");
            } else {
                response.sendRedirect("listarProfesores.jsp?error=bd");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("listarProfesores.jsp?error=excepcion");
        }
    }
}