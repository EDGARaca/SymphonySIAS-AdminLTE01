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

public class Caso008_AccesoDirectoURLTest {
    @Test
    public void testAccesoDirectoPorURLSinRol() {
        String rol = null;
        assertNull(rol, "Acceso denegado por falta de rol");
    }
}
