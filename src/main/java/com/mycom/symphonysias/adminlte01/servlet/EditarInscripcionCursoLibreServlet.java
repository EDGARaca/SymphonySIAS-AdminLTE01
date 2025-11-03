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
 * Edita una inscripción existente.
 */
@WebServlet("/EditarInscripcionCursoLibreServlet")
public class EditarInscripcionCursoLibreServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        InscripcionCursoLibreDAO dao = new InscripcionCursoLibreDAO();
        InscripcionCursoLibre insc = dao.buscarPorId(id);

        if (insc != null) {
            request.setAttribute("inscripcion", insc);
            request.getRequestDispatcher("editarInscripcionCursoLibre.jsp").forward(request, response);
        } else {
            response.sendRedirect("listarInscripcionCursoLibre.jsp?error=no_encontrado");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
            int idCursoLibre = Integer.parseInt(request.getParameter("idCursoLibre"));
            String fechaStr = request.getParameter("fechaInscripcion");
            String estadoPago = request.getParameter("estadoPago");
            String usuarioRegistro = request.getParameter("usuarioRegistro");

            Date fechaInscripcion = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

            InscripcionCursoLibre insc = new InscripcionCursoLibre();
            insc.setId(id);
            insc.setIdEstudiante(idEstudiante);
            insc.setIdCursoLibre(idCursoLibre);
            insc.setFechaInscripcion(fechaInscripcion);
            insc.setEstadoPago(estadoPago);
            insc.setUsuarioRegistro(usuarioRegistro);

            InscripcionCursoLibreDAO dao = new InscripcionCursoLibreDAO();
            boolean actualizado = dao.actualizar(insc);

            if (actualizado) {
                response.sendRedirect("ListarInscripcionCursoLibreServlet");
            } else {
                response.sendRedirect("editarInscripcionCursoLibre.jsp?error=actualizar");
            }

        } catch (Exception e) {
            System.out.println("[ERROR SERVLET] " + e.getMessage());
            response.sendRedirect("editarInscripcionCursoLibre.jsp?error=excepcion");
        }
    }
}