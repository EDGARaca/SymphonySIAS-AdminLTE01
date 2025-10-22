/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.test;

import com.mycom.symphonysias.adminlte01.dao.EstudianteDAO;
import com.mycom.symphonysias.adminlte01.modelo.Estudiante;
import org.junit.jupiter.api.Test;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class Caso021_ExportacionEstudiantesConDatosTest {

    @Test
    public void testExportacionConDatos() {
        List<Estudiante> lista = new EstudianteDAO().listarEstudiantes();
        assertNotNull(lista, "La lista de estudiantes no debe ser nula");
        assertFalse(lista.isEmpty(), "Se esperaba al menos un estudiante registrado para exportar");
        System.out.println("[TEST] Estudiantes disponibles para exportación: " + lista.size());
    }
}
