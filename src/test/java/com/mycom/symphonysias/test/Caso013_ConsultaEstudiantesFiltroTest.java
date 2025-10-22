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
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.stream.Collectors;

public class Caso013_ConsultaEstudiantesFiltroTest {
    @Test
    public void testConsultaEstudiantesPorFiltro() {
        List<String> estudiantes = List.of("Laura", "Carlos", "Ana");
        List<String> resultado = estudiantes.stream()
            .filter(e -> e.startsWith("L"))
            .collect(Collectors.toList());
        assertEquals(1, resultado.size());
    }
}
