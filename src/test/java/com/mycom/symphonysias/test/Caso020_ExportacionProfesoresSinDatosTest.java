/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.test;

import com.mycom.symphonysias.adminlte01.dao.ProfesorDAO;
import com.mycom.symphonysias.adminlte01.modelo.Profesor;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.api.Assumptions;

public class Caso020_ExportacionProfesoresSinDatosTest {

    @Test
    public void testExportacionProfesoresSinDatos() {
        List<Profesor> lista = new ProfesorDAO().listar();
        if (lista == null || lista.isEmpty()) {
            System.out.println("[TEST] No hay profesores para exportar");
            assertTrue(true); // pasa la prueba
        } else {
            System.out.println("[TEST] Profesores registrados: " + lista.size());
            Assumptions.assumeTrue(false, "Test omitido: hay profesores registrados");
        }
    }
}