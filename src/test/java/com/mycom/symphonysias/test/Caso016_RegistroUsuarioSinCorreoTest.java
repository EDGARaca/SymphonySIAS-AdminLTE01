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

public class Caso016_RegistroUsuarioSinCorreoTest {

    @Test
    public void testRegistroUsuarioSinCorreo() {
        String nombre = "Carlos";
        String correo = ""; // campo vacío

        boolean nombreValido = !nombre.isEmpty();
        boolean correoValido = !correo.isEmpty(); // debería fallar

        assertTrue(nombreValido);
        assertFalse(correoValido); // en seguimiento: ¿debería bloquear?
    }
}
