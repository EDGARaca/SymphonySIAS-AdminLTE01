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
import com.mycom.symphonysias.adminlte01.dao.ProfesorDAO;
import com.mycom.symphonysias.adminlte01.modelo.Profesor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=Profesores_SymphonySIAS.pdf");

        try {
            Document pdf = new Document(PageSize.A4.rotate());
            PdfWriter.getInstance(pdf, response.getOutputStream());
            pdf.open();

            // Encabezado institucional
            Font tituloFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLUE);
            Paragraph titulo = new Paragraph("Listado de Profesores - SymphonySIAS", tituloFont);
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
            PdfPTable tabla = new PdfPTable(5);
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{2, 2, 2, 3, 2});

            Font cabeceraFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
            BaseColor azul = new BaseColor(0, 102, 204);

            String[] columnas = {"Nombre", "Apellido", "Documento", "Correo", "Estado"};
            for (String col : columnas) {
                PdfPCell celda = new PdfPCell(new Phrase(col, cabeceraFont));
                celda.setBackgroundColor(azul);
                celda.setHorizontalAlignment(Element.ALIGN_CENTER);
                celda.setPadding(8);
                tabla.addCell(celda);
            }

            Font filaFont = new Font(Font.FontFamily.HELVETICA, 10);
            for (Profesor p : lista) {
                tabla.addCell(new Phrase(p.getNombre(), filaFont));
                tabla.addCell(new Phrase(p.getApellido(), filaFont));
                tabla.addCell(new Phrase(p.getDocumento(), filaFont));
                tabla.addCell(new Phrase(p.getCorreo(), filaFont));
                tabla.addCell(new Phrase(p.getEstado(), filaFont));
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
            response.sendRedirect("profesores.jsp?error=exportar");
        }
    }
}