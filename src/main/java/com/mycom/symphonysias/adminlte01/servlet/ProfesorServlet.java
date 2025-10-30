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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ProfesorServlet")
public class ProfesorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));

                Profesor profesor = new Profesor();
                profesor.setId(id);
                profesor.setNombre(request.getParameter("nombre"));
                profesor.setApellido(request.getParameter("apellido"));
                profesor.setDocumento(request.getParameter("documento"));
                profesor.setDireccion(request.getParameter("direccion"));
                profesor.setTelefono(request.getParameter("telefono"));
                profesor.setCorreo(request.getParameter("correo"));
                profesor.setFecha_nacimiento(request.getParameter("fecha_nacimiento"));
                profesor.setEspecialidad(request.getParameter("especialidad"));
                profesor.setGenero(request.getParameter("genero"));
                profesor.setEstado(request.getParameter("estado"));
                

                boolean actualizado = new ProfesorDAO().actualizar_Profesor(profesor);

                if (actualizado) {
                    System.out.println("[PROFESOR-SERVLET] Profesor actualizado correctamente");
                    response.sendRedirect("listarProfesores.jsp?editado=1");
                } else {
                    System.out.println("[PROFESOR-SERVLET] Error al actualizar profesor");
                    response.sendRedirect("editarProfesor.jsp?id=" + id + "&error=edicion");
                }

            } else {
                System.out.println("[PROFESOR-SERVLET] Registro de nuevo profesor");

                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String documento = request.getParameter("documento");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String correo = request.getParameter("correo");
                String fechaStr = request.getParameter("fecha_nacimiento");
                String especialidad = request.getParameter("especialidad");
                String genero = request.getParameter("genero");
                String estado = request.getParameter("estado");

                Date fecha_nacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

                Profesor profesor = new Profesor();
                profesor.setNombre(nombre);
                profesor.setApellido(apellido);
                profesor.setDocumento(documento);
                profesor.setDireccion(direccion);
                profesor.setTelefono(telefono);
                profesor.setCorreo(correo);
                profesor.setFecha_nacimiento(fechaStr); // o usa Date si tu modelo lo requiere
                profesor.setEspecialidad(especialidad);
                profesor.setGenero(genero);
                profesor.setEstado(estado);
                profesor.setUsuario_registro(request.getParameter("usuario_registro")); // si aplica

                boolean exito = new ProfesorDAO().insertarProfesor(profesor);

                if (exito) {
                    System.out.println("[PROFESOR-SERVLET] Profesor registrado correctamente");
                    response.sendRedirect("listarProfesores.jsp?registrado=1");
                } else {
                    System.out.println("[PROFESOR-SERVLET] Error al registrar profesor");
                    response.sendRedirect("registroProfesor.jsp?error=registro");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroProfesor.jsp?error=registro");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = new ProfesorDAO().eliminarProfesor(id);

                if (eliminado) {
                    System.out.println("[PROFESOR-SERVLET] Profesor eliminado correctamente");
                    response.sendRedirect("listarProfesores.jsp?eliminado=1");
                } else {
                    System.out.println("[PROFESOR-SERVLET] Error al eliminar profesor");
                    response.sendRedirect("listarProfesores.jsp?error=eliminacion");
                }

            } catch (Exception e) {
                System.out.println("[ERROR SERVLET] " + e.getMessage());
                response.sendRedirect("listarProfesores.jsp?error=eliminacion");
            }
        } else {
            response.sendRedirect("listarProfesores.jsp");
        }
    }
}