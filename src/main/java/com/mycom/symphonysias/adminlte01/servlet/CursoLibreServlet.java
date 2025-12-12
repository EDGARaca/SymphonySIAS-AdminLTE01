/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO;
import com.mycom.symphonysias.adminlte01.dao.EstudianteDAO;
import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;
import com.mycom.symphonysias.adminlte01.modelo.Estudiante;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CursoLibreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        CursoLibreDAO cursoDAO = new CursoLibreDAO();
        EstudianteDAO estudianteDAO = new EstudianteDAO();

        try {
            if ("listarPorProfesor".equals(accion)) {
                int idProfesor = Integer.parseInt(request.getParameter("id"));
                List<CursoLibre> cursos = cursoDAO.listarCursosPorProfesor(idProfesor);

                request.setAttribute("listaCursos", cursos);
                request.getRequestDispatcher("listarCursosPorProfesor.jsp").forward(request, response);

            } else if ("listarEstudiantes".equals(accion)) {
                int idCurso = Integer.parseInt(request.getParameter("id"));
                List<Estudiante> estudiantes = estudianteDAO.listarPorCurso(idCurso);

                request.setAttribute("listaEstudiantes", estudiantes);
                request.getRequestDispatcher("listarEstudiantePorProfesor.jsp").forward(request, response);

            } else {
                // Acción por defecto: listar todos los cursos
                List<CursoLibre> cursos = cursoDAO.listarCursos();
                request.setAttribute("listaCursos", cursos);
                request.getRequestDispatcher("listarCursos.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cursoLibre.jsp?error=accion");
        }
    }
}