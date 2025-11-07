/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mycom.symphonysias.adminlte01.dao.InscripcionCursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.InscripcionCursoLibre;
import java.util.logging.Logger;
import java.util.logging.Level;


public class InscripcionCursoLibreServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(InscripcionCursoLibreServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idEstudianteStr = request.getParameter("id_estudiante");
        String idCursoStr = request.getParameter("id_curso");

        if (idEstudianteStr == null || idCursoStr == null || idEstudianteStr.trim().isEmpty() || idCursoStr.trim().isEmpty()) {
            LOGGER.warning("[INSCRIPCIÓN] Parámetros vacíos");
            response.sendRedirect("inscripcionCursoLibre.jsp?error=true");
            return;
        }

        try {
            int idEstudiante = Integer.parseInt(idEstudianteStr);
            int idCurso = Integer.parseInt(idCursoStr);
            

            InscripcionCursoLibre insc = new InscripcionCursoLibre();
            insc.setIdEstudiante(idEstudiante);
            insc.setIdCursoLibre(idCurso);
            insc.setFechaInscripcion(new java.util.Date()); // fecha actual
            insc.setEstadoPago("PENDIENTE"); // puedes ajustar según tu lógica
            insc.setUsuarioRegistro((String) request.getSession().getAttribute("usuarioActivo")); // trazabilidad

            InscripcionCursoLibreDAO dao = new InscripcionCursoLibreDAO();
            boolean exito = dao.registrar(insc);

            if (exito) {
                LOGGER.log(Level.INFO, "[INSCRIPCIÓN] Inscripción exitosa - Estudiante: {0} | Curso: {1}", new Object[]{idEstudiante, idCurso});
                response.sendRedirect("inscripcionCursoLibre.jsp?exito=true");
            } else {
                LOGGER.log(Level.WARNING, "[INSCRIPCIÓN] Falló la inscripción - Estudiante: {0} | Curso: {1}", new Object[]{idEstudiante, idCurso});
                response.sendRedirect("inscripcionCursoLibre.jsp?error=true");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[INSCRIPCIÓN] Error en el proceso de inscripción", e);
            response.sendRedirect("inscripcionCursoLibre.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("inscripcionCursoLibre.jsp");
    }
}