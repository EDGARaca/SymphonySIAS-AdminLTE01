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
                profesor.setFechaNacimiento(java.sql.Date.valueOf(request.getParameter("fechaNacimiento")));
                profesor.setEspecialidad(request.getParameter("especialidad"));
                profesor.setGenero(request.getParameter("genero"));
                profesor.setEstado(request.getParameter("estado"));

                boolean actualizado = new ProfesorDAO().actualizarProfesor(profesor);

                if (actualizado) {
                    System.out.println("[SERVLET] Profesor actualizado correctamente");
                    response.sendRedirect("profesores.jsp?editado=1");
                } else {
                    System.out.println("[SERVLET] Error al actualizar profesor");
                    response.sendRedirect("editarProfesor.jsp?id=" + id + "&error=1");
                }

            } else {
                System.out.println("[SERVLET] Registro de nuevo profesor");

                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String documento = request.getParameter("documento");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String correo = request.getParameter("correo");
                String fechaStr = request.getParameter("fechaNacimiento");
                String especialidad = request.getParameter("especialidad");
                String genero = request.getParameter("genero");
                String estado = request.getParameter("estado");

                Date fechaNacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

                Profesor profesor = new Profesor(0, nombre, apellido, documento, direccion,
                        telefono, correo, new java.sql.Date(fechaNacimiento.getTime()),
                        especialidad, genero, estado);

                boolean exito = new ProfesorDAO().insertarProfesor(profesor);

                if (exito) {
                    System.out.println("[SERVLET] Profesor registrado correctamente");
                    response.sendRedirect("profesores.jsp?registrado=1");
                } else {
                    System.out.println("[SERVLET] Error al registrar profesor");
                    response.sendRedirect("registroProfesor.jsp?error=1");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroProfesor.jsp?error=2");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = new ProfesorDAO().eliminarProfesor(id);

                if (eliminado) {
                    System.out.println("[SERVLET] Profesor eliminado correctamente");
                    response.sendRedirect("profesores.jsp?eliminado=1");
                } else {
                    System.out.println("[SERVLET] Error al eliminar profesor");
                    response.sendRedirect("profesores.jsp?error=eliminar");
                }

            } catch (Exception e) {
                System.out.println("[ERROR SERVLET] " + e.getMessage());
                response.sendRedirect("profesores.jsp?error=eliminar");
            }
        } else {
            response.sendRedirect("profesores.jsp");
        }
    }
}
