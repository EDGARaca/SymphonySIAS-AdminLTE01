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
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class Caso023_ExportacionProfesoresConDatosTest {

   @Test
    public void testExportacionConDatos() {
        List<Profesor> lista = new ProfesorDAO().listar();
        assertNotNull(lista, "La lista de profesores no debe ser nula");
        assertFalse(lista.isEmpty(), "Se esperaba al menos un profesor registrado para exportar");
        System.out.println("[TEST] Profesores disponibles para exportación: " + lista.size());
    }
    
    
}
