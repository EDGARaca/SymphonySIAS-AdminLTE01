/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.InscripcionCursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.InscripcionCursoLibre;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Registra una nueva inscripción de estudiante a curso libre.
 */
@WebServlet("/RegistrarInscripcionCursoLibreServlet")
public class RegistrarInscripcionCursoLibreServlet extends HttpServlet {

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

            Date fechaInscripcion = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

            InscripcionCursoLibre insc = new InscripcionCursoLibre();
            insc.setIdEstudiante(idEstudiante);
            insc.setIdCursoLibre(idCursoLibre);
            insc.setFechaInscripcion(fechaInscripcion);
            insc.setEstadoPago(estadoPago);
            insc.setUsuarioRegistro(usuarioRegistro);

            InscripcionCursoLibreDAO dao = new InscripcionCursoLibreDAO();
            boolean registrado = dao.registrar(insc);

            if (registrado) {
                System.out.println("[SERVLET] Inscripción registrada correctamente.");
                response.sendRedirect("ListarInscripcionCursoLibreServlet");
            } else {
                System.out.println("[SERVLET] Error al registrar inscripción.");
                response.sendRedirect("listarInscripcionCursoLibre.jsp?error=registro");
            }

        } catch (Exception e) {
            System.out.println("[ERROR SERVLET] " + e.getMessage());
            response.sendRedirect("listarInscripcionCursoLibre.jsp?error=excepcion");
        }
    }
}