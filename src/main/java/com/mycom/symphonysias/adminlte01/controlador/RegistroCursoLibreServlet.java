/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet para registrar un Curso Libre.
 * ISO/IEC 25010:
 * - Confiabilidad: validación de parámetros, control de permisos, manejo de errores.
 * - Mantenibilidad: código claro, comentarios y estructura simple.
 * - Trazabilidad: usa usuario de sesión y redirecciones con códigos de estado.
 */
@WebServlet("/RegistroCursoLibreServlet")
public class RegistroCursoLibreServlet extends HttpServlet {

    private static final long serialVersionUID = 1L; // Evita warning de serialización

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Codificación de caracteres (evita problemas con acentos y UTF-8)
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1) Verificación de sesión
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp?error=sesion");
            return;
        }

        // 2) Control de permisos por rol (coherente con roles.jspf)
        String rol = getLower(session.getAttribute("rol"));
        boolean autorizado = "admin".equals(rol) ||
                             "administrador".equals(rol) ||
                             "administrador sias".equals(rol) ||
                             "director".equals(rol) ||
                             "coordinador".equals(rol) ||
                             "coordinador académico".equals(rol);

        if (!autorizado) {
            response.sendRedirect("listarCursoLibre.jsp?error=permiso");
            return;
        }

        // 3) Lectura segura de parámetros
        String nombre        = trimOrNull(request.getParameter("nombre"));
        String frecuencia    = trimOrNull(request.getParameter("frecuencia"));
        String valorStr      = trimOrNull(request.getParameter("valor"));       // DECIMAL → Double en modelo
        String idProfesorStr = trimOrNull(request.getParameter("id_profesor")); // FK profesor

        // usuario_registro desde sesión (trazabilidad de auditoría)
        String usuarioRegistroStr = trimOrNull(toStringOrNull(session.getAttribute("usuarioActivo")));

        // 4) Validaciones mínimas (confiabilidad)
        if (isBlank(nombre) || isBlank(frecuencia) || isBlank(valorStr) || isBlank(idProfesorStr)) {
            response.sendRedirect("registroCursoLibre.jsp?error=parametros");
            return;
        }

        // 5) Parseo controlado de tipos (evita NumberFormatException)
        Double valor = parseDouble(valorStr);
        Integer idProfesor = parseInteger(idProfesorStr);
        Integer usuarioRegistro = parseInteger(usuarioRegistroStr); // puede ser null si no hay id de usuario en sesión

        if (valor == null || valor < 0 || idProfesor == null) {
            response.sendRedirect("registroCursoLibre.jsp?error=valores");
            return;
        }

        // 6) Construcción del modelo (mantener lo que ya funciona; modelo con camelCase y alias snake_case)
        CursoLibre curso = new CursoLibre();
        curso.setNombre(nombre);
        curso.setValor(valor);                 // Double (coherente con el modelo)
        curso.setFrecuencia(frecuencia);
        curso.setEstado("activo");             // estado por defecto

        // Profesor asignado (puedes usar camelCase o alias snake_case; ambos existen en el modelo)
        curso.setIdProfesor(idProfesor);
        // curso.setId_profesor(idProfesor);   // alias disponible si lo prefieres

        // usuario_registro: preferible usar camelCase; alias snake_case también está disponible
        if (usuarioRegistro != null) {
            curso.setIdUsuarioRegistro(usuarioRegistro);
            // curso.setUsuario_registro(usuarioRegistro); // alias
        } else {
            // Trazabilidad básica si falta id de usuario en sesión (ajusta según tu política)
            curso.setIdUsuarioRegistro(0);
        }

        // 7) Persistencia vía DAO con manejo de resultado y errores
        try {
            CursoLibreDAO dao = new CursoLibreDAO();
            boolean ok = dao.registrar(curso);

            if (ok) {
                // Éxito → redirigir al listado con mensaje OK
                response.sendRedirect("listarCursoLibre.jsp?ok=registrado");
            } else {
                // Fallo controlado en DAO → redirigir con estado
                response.sendRedirect("registroCursoLibre.jsp?error=dao");
            }
        } catch (Exception e) {
            // Confiabilidad: log en consola para diagnóstico
            e.printStackTrace();
            response.sendRedirect("registroCursoLibre.jsp?error=excepcion");
        }
    }

    // =============================
    // Utilidades de validación y conversión (mantenibilidad)
    // =============================

    private String trimOrNull(String s) {
        return s == null ? null : s.trim();
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private Integer parseInteger(String s) {
        try {
            if (isBlank(s)) return null;
            return Integer.valueOf(s.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private Double parseDouble(String s) {
        try {
            if (isBlank(s)) return null;
            return Double.valueOf(s.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private String getLower(Object o) {
        return o == null ? "" : o.toString().trim().toLowerCase();
    }

    private String toStringOrNull(Object o) {
        return o == null ? null : o.toString();
    }
}