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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/FiltrarCursoLibreServlet")
public class FiltrarCursoLibreServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String frecuencia = request.getParameter("frecuencia");
        String estado = request.getParameter("estado");

        // Validación de filtros vacíos
        if ((nombre == null || nombre.trim().isEmpty()) &&
            (frecuencia == null || frecuencia.trim().isEmpty()) &&
            (estado == null || estado.trim().isEmpty())) {
            request.setAttribute("error", "Debe ingresar al menos un criterio de búsqueda.");
            request.getRequestDispatcher("cursoLibre.jsp").forward(request, response);
            return;
        }

        List<CursoLibre> resultados = CursoLibreDAO.buscarCursos(nombre, frecuencia, estado);
        request.setAttribute("resultados", resultados);
        request.getRequestDispatcher("listarCursoLibre.jsp").forward(request, response);
    }
}

