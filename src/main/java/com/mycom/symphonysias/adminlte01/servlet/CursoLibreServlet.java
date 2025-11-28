/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CursoLibreServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        CursoLibreDAO dao = new CursoLibreDAO();

        try {
            if ("listarPorProfesor".equals(accion)) {
                int idProfesor = Integer.parseInt(request.getParameter("id"));
                List<CursoLibre> cursos = dao.listarCursosPorProfesor(idProfesor);

                request.setAttribute("listaCursos", cursos);
                request.getRequestDispatcher("listarCursosPorProfesor.jsp").forward(request, response);

            } else {
                // Acción por defecto: listar todos los cursos
                List<CursoLibre> cursos = dao.listarCursos();   // ✅ corregido
                request.setAttribute("listaCursos", cursos);
                request.getRequestDispatcher("listarCursos.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cursoLibre.jsp?error=accion");
        }
    }
}