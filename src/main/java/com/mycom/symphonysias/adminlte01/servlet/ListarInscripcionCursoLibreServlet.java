/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/*
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.InscripcionCursoLibreDAO;
import com.mycom.symphonysias.adminlte01.dao.EstudianteDAO;
import com.mycom.symphonysias.adminlte01.modelo.InscripcionCursoLibre;
import com.mycom.symphonysias.adminlte01.modelo.Estudiante;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Carga inscripciones y estudiantes para la vista listarInscripcionCursoLibre.jsp
 */
@WebServlet("/ListarInscripcionCursoLibreServlet")
public class ListarInscripcionCursoLibreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[SERVLET] Iniciando carga de inscripciones y estudiantes...");

        // 🔄 Cargar inscripciones
        InscripcionCursoLibreDAO inscDAO = new InscripcionCursoLibreDAO();
        List<InscripcionCursoLibre> listaInscripciones = inscDAO.listar();

        // 🔄 Cargar estudiantes
        EstudianteDAO estudianteDAO = new EstudianteDAO();
        List<Estudiante> listaEstudiantes = estudianteDAO.listarEstudiantes();
        request.setAttribute("listaEstudiantes", listaEstudiantes);


        // 📤 Enviar a vista
        request.setAttribute("listaInscripciones", listaInscripciones);
        request.setAttribute("listaEstudiantes", listaEstudiantes);

        System.out.println("[SERVLET] Inscripciones: " + listaInscripciones.size() + " | Estudiantes: " + listaEstudiantes.size());

        request.getRequestDispatcher("listarInscripcionCursoLibre.jsp").forward(request, response);
    }
}