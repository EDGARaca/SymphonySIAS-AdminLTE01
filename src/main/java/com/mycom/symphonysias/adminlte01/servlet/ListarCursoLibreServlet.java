/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 * Servlet para listar cursos libres.
 * Cumple ISO/IEC 25010:
 * - Confiabilidad: manejo robusto de excepciones y cierre de recursos.
 * - Mantenibilidad: comentarios claros y estructura estándar.
 * - Trazabilidad: logs en cada paso del flujo.
 *
 * Integración:
 * - NetBeans 27 + JDK 21 + Tomcat 9.0.112
 * - BD: jdbc:mysql://localhost:3306/login_symphony
 * - Envía la lista de cursos como atributo "resultados" al JSP cursoLibre.jsp
 */

package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "ListarCursoLibreServlet", urlPatterns = {"/ListarCursoLibreServlet"})
public class ListarCursoLibreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Logger LOGGER = Logger.getLogger(ListarCursoLibreServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Recuperar lista de cursos desde DAO
            CursoLibreDAO dao = new CursoLibreDAO();
            List<CursoLibre> resultados = dao.listar();

            // Trazabilidad
            LOGGER.log(Level.INFO, "[CURSOS LIBRES] Se recuperaron {0} cursos.", resultados.size());

            // Enviar resultados al JSP
            request.setAttribute("resultados", resultados);
            request.getRequestDispatcher("cursoLibre.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[CURSOS LIBRES] Error al listar cursos", e);
            request.setAttribute("error", "Error al listar cursos libres.");
            request.getRequestDispatcher("cursoLibre.jsp").forward(request, response);
        }
    }
}