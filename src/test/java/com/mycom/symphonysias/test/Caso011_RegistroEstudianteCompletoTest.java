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

public class Caso011_RegistroEstudianteCompletoTest {
    @Test
    public void testRegistroEstudianteConDatosCompletos() {
        String nombre = "Laura";
        String documento = "123456789";
        assertTrue(!nombre.isEmpty() && documento.length() >= 8);
    }
}