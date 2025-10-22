/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.mycom.symphonysias.adminlte01.dao.EstudianteDAO;
import com.mycom.symphonysias.adminlte01.modelo.Estudiante;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=Estudiantes_SymphonySIAS.pdf");

        try {
            Document pdf = new Document(PageSize.A4.rotate());
            PdfWriter.getInstance(pdf, response.getOutputStream());
            pdf.open();

            // Encabezado institucional
            Font tituloFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLUE);
            Paragraph titulo = new Paragraph("Listado de Estudiantes - SymphonySIAS", tituloFont);
            titulo.setAlignment(Element.ALIGN_CENTER);
            titulo.setSpacingAfter(10);
            pdf.add(titulo);

            // Fecha de generación
            String fecha = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date());
            Paragraph fechaGen = new Paragraph("Generado el: " + fecha, new Font(Font.FontFamily.HELVETICA, 10, Font.ITALIC));
            fechaGen.setAlignment(Element.ALIGN_RIGHT);
            fechaGen.setSpacingAfter(10);
            pdf.add(fechaGen);

            // Tabla
            PdfPTable tabla = new PdfPTable(6);
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{2, 2, 2, 3, 2, 2});

            Font cabeceraFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
            BaseColor azul = new BaseColor(0, 102, 204);

            String[] columnas = {"Nombre", "Apellido", "Documento", "Correo", "Género", "Estado"};
            for (String col : columnas) {
                PdfPCell celda = new PdfPCell(new Phrase(col, cabeceraFont));
                celda.setBackgroundColor(azul);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                celda.setPadding(8);
                tabla.addCell(celda);
            }

            Font filaFont = new Font(Font.FontFamily.HELVETICA, 10);
            for (Estudiante e : lista) {
                tabla.addCell(new Phrase(e.getNombre(), filaFont));
                tabla.addCell(new Phrase(e.getApellido(), filaFont));
                tabla.addCell(new Phrase(e.getDocumento(), filaFont));
                tabla.addCell(new Phrase(e.getCorreo(), filaFont));
                tabla.addCell(new Phrase(e.getGenero(), filaFont));
                tabla.addCell(new Phrase(e.getEstado(), filaFont));
            }

            pdf.add(tabla);

            // Pie de página
            Paragraph pie = new Paragraph("Documento generado automáticamente por SymphonySIAS", new Font(Font.FontFamily.HELVETICA, 9, Font.ITALIC));
            pie.setSpacingBefore(20);
            pie.setAlignment(Element.ALIGN_RIGHT);
            pdf.add(pie);

            pdf.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("listarEstudiantes.jsp?error=exportar");
        }
    }
}