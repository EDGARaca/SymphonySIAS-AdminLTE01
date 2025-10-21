/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.EstudianteDAO;
import com.mycom.symphonysias.adminlte01.modelo.Estudiante;

import javax.servlet.ServletException;

import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class ExportarEstudiantesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Estudiante> lista = new EstudianteDAO().listarEstudiantes();

        if (lista == null || lista.isEmpty()) {
            System.out.println("[SERVLET] No hay estudiantes para exportar");
            response.sendRedirect("listarEstudiantes.jsp?sinDatos=1");
            return;
        }

        // Aquí iría la lógica para generar el PDF con la lista
        // Por ahora, solo simulamos la exportación exitosa
        System.out.println("[SERVLET] Exportación simulada de estudiantes (" + lista.size() + " registros)");
        response.sendRedirect("listarEstudiantes.jsp?exportado=1");
    }
}