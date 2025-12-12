/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/*
 * Servlet para registrar una nueva inscripción de estudiante a curso libre.
 * Cumple ISO/IEC 25010:
 * - Confiabilidad: manejo robusto de excepciones y validaciones.
 * - Mantenibilidad: comentarios claros y uso de anotaciones modernas.
 * - Trazabilidad: logs consistentes con SLF4J.
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.InscripcionCursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.InscripcionCursoLibre;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet(name = "RegistrarInscripcionCursoLibreServlet", urlPatterns = {"/RegistrarInscripcionCursoLibreServlet"})
public class RegistrarInscripcionCursoLibreServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = LoggerFactory.getLogger(RegistrarInscripcionCursoLibreServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setCharacterEncoding("UTF-8");

            int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
            int idCursoLibre = Integer.parseInt(request.getParameter("idCursoLibre"));
            String fechaStr = request.getParameter("fechaInscripcion");
            String estadoPago = request.getParameter("estadoPago");
            String usuarioRegistro = request.getParameter("usuarioRegistro");

            Date fechaInscripcion;
            try {
                fechaInscripcion = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);
            } catch (ParseException pe) {
                logger.error("[SERVLET] Error al parsear fecha: {}", fechaStr, pe);
                response.sendRedirect("listarInscripcionCursoLibre.jsp?error=formatoFecha");
                return;
            }

            InscripcionCursoLibre insc = new InscripcionCursoLibre();
            insc.setIdEstudiante(idEstudiante);
            insc.setIdCursoLibre(idCursoLibre);
            insc.setFechaInscripcion(fechaInscripcion);
            insc.setEstadoPago(estadoPago);
            insc.setUsuarioRegistro(usuarioRegistro);

            InscripcionCursoLibreDAO dao = new InscripcionCursoLibreDAO();
            boolean registrado = dao.registrar(insc);

            if (registrado) {
                logger.info("[SERVLET] Inscripción registrada correctamente para estudiante {}", idEstudiante);
                response.sendRedirect("ListarInscripcionCursoLibreServlet");
            } else {
                logger.warn("[SERVLET] Error al registrar inscripción para estudiante {}", idEstudiante);
                response.sendRedirect("listarInscripcionCursoLibre.jsp?error=registro");
            }

        } catch (NumberFormatException nfe) {
            logger.error("[SERVLET] Error en parámetros numéricos: {}", nfe.getMessage(), nfe);
            response.sendRedirect("listarInscripcionCursoLibre.jsp?error=parametros");
        } catch (Exception e) {
            logger.error("[SERVLET] Excepción general: {}", e.getMessage(), e);
            response.sendRedirect("listarInscripcionCursoLibre.jsp?error=excepcion");
        }
    }
}