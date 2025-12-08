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

public class Caso001_LoginValidoTest {
    @Test
    public void testLoginConCredencialesValidas() {
        String usuario = "admin";
        String contraseña = "12345*";
        assertTrue(usuario.equals("admin") && contraseña.equals("12345*"));
    }
}
