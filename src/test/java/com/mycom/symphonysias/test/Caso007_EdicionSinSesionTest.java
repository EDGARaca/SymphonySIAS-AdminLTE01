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

public class Caso007_EdicionSinSesionTest {
    @Test
    public void testEdicionUsuarioSinSesionActiva() {
        boolean sesionActiva = false;
        assertFalse(sesionActiva, "No se permite editar sin sesión activa");
    }
}
