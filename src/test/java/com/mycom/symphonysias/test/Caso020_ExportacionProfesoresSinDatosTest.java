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
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

public class Caso020_ExportacionProfesoresSinDatosTest {

    @Test
    public void testExportacionProfesoresSinDatos() {
        List<?> lista = new ProfesorDAO().listar();

        if (lista == null || lista.isEmpty()) {
            System.out.println("[TEST] No hay profesores para exportar");
            assertTrue(true); // La prueba pasa porque no hay datos
        } else {
            fail("Error: se esperaba lista vacía para exportar profesores sin datos");
        }
    }
}