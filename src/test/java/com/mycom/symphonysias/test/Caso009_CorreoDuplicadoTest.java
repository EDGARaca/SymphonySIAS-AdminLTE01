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

import java.util.HashSet;

public class Caso009_CorreoDuplicadoTest {
    @Test
    public void testValidacionDeCorreoDuplicado() {
        HashSet<String> correos = new HashSet<>();
        correos.add("admin@example.com");
        boolean duplicado = !correos.add("admin@example.com");
        assertTrue(duplicado, "Correo duplicado detectado");
    }
}
