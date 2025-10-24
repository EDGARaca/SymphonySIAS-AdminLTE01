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

public class Caso018_LoginConSQLInjectionTest {

    @Test
    public void testLoginConSQLInjection() {
        String usuario = "' OR '1'='1";
        String contrasena = "1234";

        boolean accesoPermitido = usuario.equals("admin") && contrasena.equals("1234");

        assertFalse(accesoPermitido); // rechazado: el sistema no bloquea inyección
    }
}
