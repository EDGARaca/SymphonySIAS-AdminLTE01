/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class RegistroCursoLibreServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        // 🔄 EDICIÓN DE CURSO
        if ("editar".equals(accion)) {
            String idStr = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String valorStr = request.getParameter("valor");
            String frecuencia = request.getParameter("frecuencia");
            String estado = request.getParameter("estado");
            String usuario_registro = request.getParameter("usuario_registro");

            if (idStr == null || nombre == null || valorStr == null || frecuencia == null || estado == null || usuario_registro == null) {
                response.sendRedirect("listarCursoLibre.jsp?error=datos");
                return;
            }

            int id = Integer.parseInt(idStr);
            int valor = Integer.parseInt(valorStr);

            CursoLibre curso = new CursoLibre();
            curso.setId(id);
            curso.setNombre(nombre);
            curso.setValor(valor);
            curso.setFrecuencia(frecuencia);
            curso.setEstado(estado);
            curso.setUsuario_registro(usuario_registro);

            CursoLibreDAO dao = new CursoLibreDAO();
            boolean exito = dao.actualizar(curso);

            if (exito) {
                System.out.println("[Servlet] Curso editado exitosamente: " + nombre);
                response.sendRedirect("listarCursoLibre.jsp?editado=ok");
            } else {
                System.out.println("[Servlet] Error al editar curso: " + nombre);
                response.sendRedirect("editarCursoLibre.jsp?id=" + id + "&error=actualizar");
            }
            return;
        }

        // 🔴 REGISTRO DE CURSO NUEVO
        String nombre = request.getParameter("nombre");
        String valorStr = request.getParameter("valor");
        String frecuencia = request.getParameter("frecuencia");
        String usuario_registro = request.getParameter("usuario_registro");

        if (nombre == null || valorStr == null || frecuencia == null || usuario_registro == null) {
            System.out.println("[Servlet] Datos incompletos para registrar curso");
            response.sendRedirect("registroCursoLibre.jsp");
            return;
        }

        int valor = Integer.parseInt(valorStr);

        CursoLibre curso = new CursoLibre();
        curso.setNombre(nombre);
        curso.setValor(valor);
        curso.setFrecuencia(frecuencia);
        curso.setEstado("activo");
        curso.setUsuario_registro(usuario_registro);

        CursoLibreDAO dao = new CursoLibreDAO();
        boolean exito = dao.insertar(curso);

        if (exito) {
            System.out.println("[Servlet] Curso registrado exitosamente: " + nombre);
            response.sendRedirect("listarCursoLibre.jsp?registrado=ok");
        } else {
            System.out.println("[Servlet] Error al registrar curso: " + nombre);
            response.sendRedirect("registroCursoLibre.jsp?error=registro");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        // 🗑 ELIMINACIÓN DE CURSO
        if ("activar".equals(accion) || "desactivar".equals(accion)) {
            String idStr = request.getParameter("id");
            String usuarioAccion = request.getParameter("usuario");

            if (idStr != null && usuarioAccion != null) {
                int id = Integer.parseInt(idStr);
                String nuevoEstado = accion.equals("activar") ? "activo" : "inactivo";

                CursoLibreDAO dao = new CursoLibreDAO();
                boolean exito = dao.actualizarEstado(id, nuevoEstado);

                if (exito) {
                    System.out.println("[Servlet] Estado actualizado por: " + usuarioAccion + " | ID: " + id + " → " + nuevoEstado);
                    response.sendRedirect("listarCursoLibre.jsp?estadoActualizado=ok");
                } else {
                    response.sendRedirect("listarCursoLibre.jsp?error=estado");
                }
            } else {
                response.sendRedirect("listarCursoLibre.jsp?error=parametros");
            }
            return;
        }
        
        // 🗑 ELIMINACIÓN FÍSICA DE CURSO

        if ("eliminarFisico".equals(accion)) {
            String idStr = request.getParameter("id");
            String usuarioAccion = request.getParameter("usuario");

            if (idStr != null && usuarioAccion != null) {
                int id = Integer.parseInt(idStr);

                CursoLibreDAO dao = new CursoLibreDAO();
                boolean exito = dao.eliminarFisico(id);

                if (exito) {
                    System.out.println("[Servlet] Curso eliminado físicamente por: " + usuarioAccion + " | ID: " + id);
                    response.sendRedirect("listarCursoLibre.jsp?eliminadoFisico=ok");
                } else {
                    System.out.println("[Servlet] Error al eliminar físicamente curso ID: " + id);
                    response.sendRedirect("listarCursoLibre.jsp?error=eliminacionFisica");
                }
            } else {
                response.sendRedirect("listarCursoLibre.jsp?error=parametros");
            }
            return;
        }    
    }
}