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
import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet para filtrar cursos libres según criterios de búsqueda.
 * ISO/IEC 25010:
 * - Mantenibilidad: código claro y comentado.
 * - Confiabilidad: validación de parámetros y manejo de lista vacía.
 * - Trazabilidad: logs y paso de atributos al JSP.
 */
@WebServlet("/FiltrarCursoLibreServlet")
public class FiltrarCursoLibreServlet extends HttpServlet {

    private static final long serialVersionUID = 1L; // Evita warning de serialización

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        // Instanciación del DAO y búsqueda
        CursoLibreDAO dao = new CursoLibreDAO();
        List<CursoLibre> cursos = dao.buscarCursos(nombre, frecuencia, estado);

        // Validación de resultados
        if (cursos == null || cursos.isEmpty()) {
            request.setAttribute("mensaje", "No se encontraron cursos con los criterios ingresados.");
        } else {
            request.setAttribute("cursos", cursos); // Se pasa la lista al JSP
        }

        // Redirección al JSP que muestra resultados
        request.getRequestDispatcher("listarCursoLibre.jsp").forward(request, response);
    }
}