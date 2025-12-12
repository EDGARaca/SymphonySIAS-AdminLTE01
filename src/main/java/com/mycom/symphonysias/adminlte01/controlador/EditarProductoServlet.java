/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.controlador;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;

public class EditarProductoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductoMusicalDAO dao = new ProductoMusicalDAO();
            ProductoMusical producto = dao.buscarPorId(id);

            request.setAttribute("producto", producto);
            RequestDispatcher dispatcher = request.getRequestDispatcher("formProducto.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}