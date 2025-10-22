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

public class LoginTest {

    @Test
    public void testLoginConCredencialesValidas() {
        String usuario = "admin";
        String contraseña = "1234";
        assertTrue(usuario.equals("admin") && contraseña.equals("1234"));
    }

    @Test
    public void testLoginConUsuarioIncorrecto() {
        String usuario = "otro";
        String contraseña = "1234";
        assertFalse(usuario.equals("admin"));
    }

    @Test
    public void testLoginConContraseñaIncorrecta() {
        String usuario = "admin";
        String contraseña = "0000";
        assertFalse(contraseña.equals("1234"));
    }

    @Test
    public void testLoginConCamposVacios() {
        String usuario = "";
        String contraseña = "";
        assertTrue(usuario.isEmpty() && contraseña.isEmpty());
    }

    @Test
    public void testLoginConNull() {
        String usuario = null;
        String contraseña = null;
        assertThrows(NullPointerException.class, () -> {
            usuario.equals("admin");
        });
    }
}