/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.ProfesorDAO;
import com.mycom.symphonysias.adminlte01.modelo.Profesor;

import javax.servlet.ServletException;

import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class ExportarProfesoresServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Profesor> lista = new ProfesorDAO().listar();

        if (lista == null || lista.isEmpty()) {
            System.out.println("[SERVLET] No hay profesores para exportar");
            response.sendRedirect("profesores.jsp?sinDatos=1");
            return;
        }

        // Aquí iría la lógica para generar el PDF con la lista
        // Por ahora, solo simulamos la exportación exitosa
        System.out.println("[SERVLET] Exportación simulada de profesores (" + lista.size() + " registros)");
        response.sendRedirect("profesores.jsp?exportado=1");
    }
}
