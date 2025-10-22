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

public class Caso017_VisualizacionEstudiantesSinDatosTest {

    @Test
    public void testVisualizacionEstudiantesSinDatos() {
        ArrayList<String> estudiantes = new ArrayList<>();

        boolean hayDatos = !estudiantes.isEmpty();

        assertFalse(hayDatos); // en seguimiento: ¿se muestra mensaje visual?
    }
}
