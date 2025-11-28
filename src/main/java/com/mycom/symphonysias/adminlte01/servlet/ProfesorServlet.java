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
import javax.servlet.http.*;
import java.io.IOException;


public class ProfesorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        
        HttpSession sesion = request.getSession();
        String rol = (String) sesion.getAttribute("rol");
        Integer idProfesorSesion = (Integer) sesion.getAttribute("id_profesor");

        try {
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                
                // 🔒 Restricción: si es profesor, solo puede editar su propio perfil
                if ("profesor".equals(rol)) {
                    if (idProfesorSesion == null || !idProfesorSesion.equals(id)) {
                        response.sendRedirect("listarProfesores.jsp?error=permiso");
                        return;
                    }
                }

                Profesor profesor = new Profesor();
                profesor.setId(id);
                profesor.setNombre(request.getParameter("nombre"));
                profesor.setApellido(request.getParameter("apellido"));
                profesor.setDocumento(request.getParameter("documento"));
                profesor.setDireccion(request.getParameter("direccion"));
                profesor.setTelefono(request.getParameter("telefono"));
                profesor.setCorreo(request.getParameter("correo"));
                String fechaStr = request.getParameter("fecha_nacimiento");
                java.sql.Date fecha_nacimiento = java.sql.Date.valueOf(fechaStr);
                profesor.setFecha_nacimiento(fecha_nacimiento);
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

            } else { // Registro de nuevo profesor
                
                // 🔒 Restricción: solo administrador puede registrar
                if ("profesor".equals(rol)) {
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }

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

                java.sql.Date fecha_nacimiento = java.sql.Date.valueOf(fechaStr);

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
                profesor.setUsuario_registro(request.getParameter("usuario_registro"));

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
        
        HttpSession sesion = request.getSession();
        String rol = (String) sesion.getAttribute("rol");

        try {
            ProfesorDAO dao = new ProfesorDAO();

            if ("eliminar".equals(accion)) { // Eliminación definitiva
                if ("profesor".equals(rol)) {
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }

                int id = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = dao.eliminarProfesor(id); //

                if (eliminado) {
                    System.out.println("[PROFESOR-SERVLET] Profesor eliminado definitivamente");
                    response.sendRedirect("listarProfesores.jsp?eliminado=1");
                } else {
                    System.out.println("[PROFESOR-SERVLET] Error al eliminar profesor");
                    response.sendRedirect("listarProfesores.jsp?error=eliminacion");
                }

            } else if ("inactivar".equals(accion)) { // Cambio de estado a inactivo
                if ("profesor".equals(rol)) {
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }

                int id = Integer.parseInt(request.getParameter("id"));
                boolean inactivado = dao.cambiarEstadoProfesor(id, "inactivo");

                if (inactivado) {
                    System.out.println("[PROFESOR-SERVLET] Profesor marcado como inactivo");
                    response.sendRedirect("listarProfesores.jsp?inactivado=1");
                } else {
                    response.sendRedirect("listarProfesores.jsp?error=inactivacion");
                }

            } else if ("activar".equals(accion)) { // Cambio de estado a activo
                if ("profesor".equals(rol)) {
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }

                int id = Integer.parseInt(request.getParameter("id"));
                boolean activado = dao.cambiarEstadoProfesor(id, "activo");

                if (activado) {
                    System.out.println("[PROFESOR-SERVLET] Profesor reactivado");
                    response.sendRedirect("listarProfesores.jsp?activado=1");
                } else {
                    response.sendRedirect("listarProfesores.jsp?error=activacion");
                }



            } else {
                response.sendRedirect("listarProfesores.jsp");
            }

        } catch (Exception e) {
            System.out.println("[ERROR SERVLET] " + e.getMessage());
            response.sendRedirect("listarProfesores.jsp?error=accion");
        }
    }
}