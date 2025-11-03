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
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Elimina una inscripción de curso libre por ID.
 */
@WebServlet("/EliminarInscripcionCursoLibreServlet")
public class EliminarInscripcionCursoLibreServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            System.out.println("[ERROR] ID de inscripción no recibido.");
            response.sendRedirect("listarInscripcionCursoLibre.jsp?error=id");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            InscripcionCursoLibreDAO dao = new InscripcionCursoLibreDAO();
            boolean eliminado = dao.eliminar(id);

            if (eliminado) {
                System.out.println("[SERVLET] Inscripción eliminada correctamente. ID: " + id);
                response.sendRedirect("ListarInscripcionCursoLibreServlet");
            } else {
                System.out.println("[SERVLET] No se pudo eliminar la inscripción. ID: " + id);
                response.sendRedirect("listarInscripcionCursoLibre.jsp?error=eliminar");
            }

        } catch (NumberFormatException e) {
            System.out.println("[ERROR] ID inválido: " + idStr);
            response.sendRedirect("listarInscripcionCursoLibre.jsp?error=formato");
        }
    }
}
