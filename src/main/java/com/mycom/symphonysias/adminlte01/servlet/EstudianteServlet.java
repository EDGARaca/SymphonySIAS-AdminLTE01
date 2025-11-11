/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.EstudianteDAO;
import com.mycom.symphonysias.adminlte01.modelo.Estudiante;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class EstudianteServlet extends HttpServlet {

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");

    String accion = request.getParameter("accion");

    try {
        if ("editar".equals(accion)) {
            // Edición de estudiante
            int id = Integer.parseInt(request.getParameter("id"));
            Estudiante estudiante = new Estudiante();

            estudiante.setId(id);
            estudiante.setNombre(request.getParameter("nombre"));
            estudiante.setApellido(request.getParameter("apellido"));
            estudiante.setDocumento(request.getParameter("documento"));
            estudiante.setDireccion(request.getParameter("direccion"));
            estudiante.setTelefono(request.getParameter("telefono"));
            estudiante.setCorreo(request.getParameter("correo"));
            estudiante.setFechaNacimiento(java.sql.Date.valueOf(request.getParameter("fechaNacimiento")));
            estudiante.setGenero(request.getParameter("genero"));
            estudiante.setEstado(request.getParameter("estado"));
            estudiante.setUsuarioRegistro(request.getParameter("usuario_registro"));

            boolean actualizado = new EstudianteDAO().actualizarEstudiante(estudiante);

            if (actualizado) {
                System.out.println("[SERVLET] Estudiante actualizado correctamente");
                response.sendRedirect("listarEstudiantes.jsp?editado=1");
            } else {
                System.out.println("[SERVLET] Error al actualizar estudiante");
                response.sendRedirect("editarEstudiante.jsp?id=" + id + "&error=1");
            }

        } else {
            // Registro de nuevo estudiante
            System.out.println("[SERVLET] Registro de nuevo estudiante");

            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String documento = request.getParameter("documento");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String correo = request.getParameter("correo");
            String fechaStr = request.getParameter("fechaNacimiento");
            String genero = request.getParameter("genero");
            String estado = request.getParameter("estado");
            String usuarioRegistro = request.getParameter("usuario_registro");

            Date fechaNacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

            Estudiante estudiante = new Estudiante(nombre, apellido, documento, direccion,
                    telefono, correo, fechaNacimiento, genero, estado, usuarioRegistro);

            boolean exito = new EstudianteDAO().insertarEstudiante(estudiante);

            if (exito) {
                System.out.println("[SERVLET] Estudiante registrado correctamente");
                response.sendRedirect("listarEstudiantes.jsp?registrado=1");
            } else {
                System.out.println("[SERVLET] Error al registrar estudiante");
                response.sendRedirect("registroEstudiante.jsp?error=1");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("registroEstudiante.jsp?error=2");
    }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = new EstudianteDAO().eliminarEstudiante(id);

                if (eliminado) {
                    System.out.println("[SERVLET] Estudiante eliminado correctamente");
                    response.sendRedirect("listarEstudiantes.jsp?eliminado=1");
                } else {
                    System.out.println("[SERVLET] Error al eliminar estudiante");
                    response.sendRedirect("listarEstudiantes.jsp?error=eliminar");
                }

            } catch (Exception e) {
                System.out.println("[ERROR SERVLET] " + e.getMessage());
                response.sendRedirect("listarEstudiantes.jsp?error=eliminar");
            }
        } else {
            response.sendRedirect("listarEstudiantes.jsp");
        }
    }


}
