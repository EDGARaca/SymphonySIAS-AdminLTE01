/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.test;

import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import static org.junit.jupiter.api.Assertions.*;

public class Caso019_ExportacionEstudiantesSinDatosTest {

    @Test
    public void testExportacionEstudiantesSinDatos() {
        ArrayList<String> estudiantes = new ArrayList<>();

        try {
            String pdf = generarPDF(estudiantes);
            assertTrue(pdf.endsWith(".pdf"));
        } catch (Exception e) {
            fail("Error al exportar sin datos"); // rechazado: falla por lista vacía
        }
    }

    private String generarPDF(ArrayList<String> datos) throws Exception {
        if (datos.isEmpty()) {
            throw new Exception("No hay datos para exportar");
        }
        return "estudiantes.pdf";
    }
}
