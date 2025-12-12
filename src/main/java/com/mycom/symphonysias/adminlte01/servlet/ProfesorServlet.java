/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.ProfesorDAO;
import com.mycom.symphonysias.adminlte01.modelo.Profesor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet para gestión de Profesores en SymphonySIAS-AdminLTE01
 * Cumple con ISO/IEC 25010: mantenibilidad, confiabilidad y seguridad.
 * - Trazabilidad mediante logs
 * - Validaciones defensivas de parámetros y sesión
 * - Control de roles consistente (admin, director, coordinador, profesor)
 * - Sanitización de entradas para evitar errores y mantener integridad de datos
 */
public class ProfesorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Logger LOGGER = Logger.getLogger(ProfesorServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("rol") == null) {
            response.sendRedirect("login.jsp?exp=1");
            return;
        }
        String rol = safeRol(sesion);
        Integer idProfesorSesion = (Integer) sesion.getAttribute("id_profesor");

        try {
            if ("editar".equals(accion)) {
                // Validación defensiva del parámetro id
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Falta parámetro id para edición");
                    response.sendRedirect("listarProfesores.jsp?error=parametros");
                    return;
                }
                int id = Integer.parseInt(idStr.trim());

                // Restricción: si es profesor, solo puede editar su propio perfil
                if (isProfesor(rol)) {
                    if (idProfesorSesion == null || !idProfesorSesion.equals(id)) {
                        LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Profesor intentó editar otro perfil. Sesión: {0}, ID solicitado: {1}",
                                new Object[]{idProfesorSesion, id});
                        response.sendRedirect("listarProfesores.jsp?error=permiso");
                        return;
                    }
                }

                // Construcción del objeto Profesor con sanitización de entradas
                Profesor profesor = new Profesor();
                profesor.setId(id);
                profesor.setNombre(trimOrNull(request.getParameter("nombre")));
                profesor.setApellido(trimOrNull(request.getParameter("apellido")));
                profesor.setDocumento(trimOrNull(request.getParameter("documento")));
                profesor.setDireccion(trimOrNull(request.getParameter("direccion")));
                profesor.setTelefono(trimOrNull(request.getParameter("telefono")));
                profesor.setCorreo(trimOrNull(request.getParameter("correo")));

                String fechaStr = request.getParameter("fecha_nacimiento");
                java.sql.Date fecha_nacimiento = (fechaStr != null && !fechaStr.trim().isEmpty())
                        ? java.sql.Date.valueOf(fechaStr.trim())
                        : null;
                profesor.setFecha_nacimiento(fecha_nacimiento);

                profesor.setEspecialidad(trimOrNull(request.getParameter("especialidad")));
                profesor.setGenero(trimOrNull(request.getParameter("genero")));
                profesor.setEstado(trimOrNull(request.getParameter("estado")));

                // Operación de actualización con trazabilidad
                boolean actualizado = new ProfesorDAO().actualizar_Profesor(profesor);

                if (actualizado) {
                    LOGGER.log(Level.INFO, "[PROFESOR-SERVLET] Profesor actualizado correctamente: {0}", id);
                    response.sendRedirect("listarProfesores.jsp?editado=1");
                } else {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Error al actualizar profesor: {0}", id);
                    response.sendRedirect("editarProfesor.jsp?id=" + id + "&error=edicion");
                }

            } else {
                // Registro de nuevo profesor (no permitido para rol profesor)
                if (isProfesor(rol)) {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Profesor intentó registrar nuevo profesor");
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }

                LOGGER.log(Level.INFO, "[PROFESOR-SERVLET] Registro de nuevo profesor iniciado por rol: {0}", rol);

                // Construcción del objeto Profesor con sanitización
                String fechaStr = request.getParameter("fecha_nacimiento");
                java.sql.Date fecha_nacimiento = (fechaStr != null && !fechaStr.trim().isEmpty())
                        ? java.sql.Date.valueOf(fechaStr.trim())
                        : null;

                Profesor profesor = new Profesor();
                profesor.setNombre(trimOrNull(request.getParameter("nombre")));
                profesor.setApellido(trimOrNull(request.getParameter("apellido")));
                profesor.setDocumento(trimOrNull(request.getParameter("documento")));
                profesor.setDireccion(trimOrNull(request.getParameter("direccion")));
                profesor.setTelefono(trimOrNull(request.getParameter("telefono")));
                profesor.setCorreo(trimOrNull(request.getParameter("correo")));
                profesor.setFecha_nacimiento(fecha_nacimiento);
                profesor.setEspecialidad(trimOrNull(request.getParameter("especialidad")));
                profesor.setGenero(trimOrNull(request.getParameter("genero")));
                profesor.setEstado(trimOrNull(request.getParameter("estado")));
                profesor.setUsuario_registro(trimOrNull(request.getParameter("usuario_registro")));

                boolean exito = new ProfesorDAO().insertarProfesor(profesor);

                if (exito) {
                    LOGGER.log(Level.INFO, "[PROFESOR-SERVLET] Profesor registrado correctamente: {0}", profesor.getDocumento());
                    response.sendRedirect("listarProfesores.jsp?registrado=1");
                } else {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Error al registrar profesor: {0}", profesor.getDocumento());
                    response.sendRedirect("registroProfesor.jsp?error=registro");
                }
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[PROFESOR-SERVLET] Error en doPost", e);
            response.sendRedirect("registroProfesor.jsp?error=registro");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("rol") == null) {
            response.sendRedirect("login.jsp?exp=1");
            return;
        }
        String rol = safeRol(sesion);

        try {
            ProfesorDAO dao = new ProfesorDAO();

            if ("eliminar".equals(accion)) {
                if (isProfesor(rol)) {
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Falta id para eliminar");
                    response.sendRedirect("listarProfesores.jsp?error=parametros");
                    return;
                }
                int id = Integer.parseInt(idStr.trim());

                boolean eliminado = dao.eliminarProfesor(id);
                if (eliminado) {
                    LOGGER.log(Level.INFO, "[PROFESOR-SERVLET] Profesor eliminado definitivamente: {0}", id);
                    response.sendRedirect("listarProfesores.jsp?eliminado=1");
                } else {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Falló eliminación de profesor: {0}", id);
                    response.sendRedirect("listarProfesores.jsp?error=eliminacion");
                }

            } else if ("inactivar".equals(accion)) {
                if (isProfesor(rol)) {
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Falta id para inactivar");
                    response.sendRedirect("listarProfesores.jsp?error=parametros");
                    return;
                }
                int id = Integer.parseInt(idStr.trim());

                boolean inactivado = dao.cambiarEstadoProfesor(id, "inactivo");
                if (inactivado) {
                    LOGGER.log(Level.INFO, "[PROFESOR-SERVLET] Profesor inactivado: {0}", id);
                    response.sendRedirect("listarProfesores.jsp?inactivado=1");
                } else {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Falló inactivación de profesor: {0}", id);
                    response.sendRedirect("listarProfesores.jsp?error=inactivacion");
                }

            } else if ("activar".equals(accion)) {
                if (isProfesor(rol)) {
                    response.sendRedirect("listarProfesores.jsp?error=permiso");
                    return;
                }
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Falta id para activar");
                    response.sendRedirect("listarProfesores.jsp?error=parametros");
                    return;
                }
                int id = Integer.parseInt(idStr.trim());

                boolean activado = dao.cambiarEstadoProfesor(id, "activo");
                if (activado) {
                    LOGGER.log(Level.INFO, "[PROFESOR-SERVLET] Profesor activado: {0}", id);
                    response.sendRedirect("listarProfesores.jsp?activado=1");
                } else {
                    LOGGER.log(Level.WARNING, "[PROFESOR-SERVLET] Falló activación de profesor: {0}", id);
                    response.sendRedirect("listarProfesores.jsp?error=activacion");
                }

            } else if ("vista".equals(accion)) {
                // Preparar permisos para profesores.jsp según rol
                boolean canList     = true;                      // todos pueden listar
                boolean canFilter   = true;                      // todos pueden filtrar
                boolean canRegister = !isProfesor(rol);          // admin/director/coordinador: sí
                boolean canExport   = isAdmin(rol) || isDirector(rol) || isCoordinador(rol);

                // Se envían las banderas a la vista para mostrar pestañas según rol
                request.setAttribute("canList", canList);
                request.setAttribute("canFilter", canFilter);
                request.setAttribute("canRegister", canRegister);
                request.setAttribute("canExport", canExport);
                request.setAttribute("rol", rol);                // trazabilidad en la vista

                RequestDispatcher rd = request.getRequestDispatcher("profesores.jsp");
                rd.forward(request, response);

            } else {
                // Comportamiento anterior por defecto (trazabilidad)
                response.sendRedirect("listarProfesores.jsp");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[PROFESOR-SERVLET] Error en doGet", e);
            response.sendRedirect("listarProfesores.jsp?error=accion");
        }
    }

    // ============================================================
    // Métodos utilitarios para roles y sanitización de entradas
    // ============================================================

    /**
     * Obtiene el rol de la sesión en formato seguro (minúsculas y sin espacios).
     */
    private String safeRol(HttpSession sesion) {
        Object r = sesion.getAttribute("rol");
        return r == null ? "" : String.valueOf(r).trim().toLowerCase();
    }

    /** Verifica si el rol es administrador */
    private boolean isAdmin(String rol) { return "admin".equals(rol); }

    /** Verifica si el rol es director */
    private boolean isDirector(String rol) { return "director".equals(rol); }

    /** Verifica si el rol es coordinador */
    private boolean isCoordinador(String rol) { return "coordinador".equals(rol); }

    /** Verifica si el rol es profesor */
    private boolean isProfesor(String rol) { return "profesor".equals(rol); }

    /**
     * Limpia una cadena y devuelve null si está vacía.
     * Mejora la integridad de datos y evita guardar valores vacíos en BD.
     */
    private String trimOrNull(String v) {
        if (v == null) return null;
        String t = v.trim();
        return t.isEmpty() ? null : t;
    }
}    