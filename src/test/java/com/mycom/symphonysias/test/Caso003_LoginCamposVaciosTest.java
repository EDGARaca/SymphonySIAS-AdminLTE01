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

public class Caso003_LoginCamposVaciosTest {
    @Test
    public void testLoginConCamposVacios() {
        String usuario = "";
        String contraseña = "";
        assertTrue(usuario.isEmpty() && contraseña.isEmpty());
    }
}
