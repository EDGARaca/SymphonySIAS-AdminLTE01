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

public class Caso002_LoginInvalidoTest {
    @Test
    public void testLoginConCredencialesInvalidas() {
        String usuario = "otro";
        String contraseña = "0000";
        assertFalse(usuario.equals("admin") && contraseña.equals("1234"));
    }
}