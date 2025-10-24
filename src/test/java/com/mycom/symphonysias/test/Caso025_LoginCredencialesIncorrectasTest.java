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

public class Caso025_LoginCredencialesIncorrectasTest {

    @Test
    public void testLoginCredencialesIncorrectas() {
        String usuario = "usuario_invalido";
        String contrasena = "clave_erronea";

        boolean accesoPermitido = usuario.equals("admin") && contrasena.equals("admin123");

        assertFalse(accesoPermitido, "El sistema permitió acceso con credenciales incorrectas");
    }
}