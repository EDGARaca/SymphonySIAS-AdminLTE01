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

public class Caso024_RegistroEstudianteCamposVaciosTest {

    @Test
    public void testRegistroEstudianteCamposVacios() {
        String nombre = "";
        String documento = "";
        String correo = "";

        boolean registroPermitido = !nombre.isEmpty() && !documento.isEmpty() && !correo.isEmpty();

        assertFalse(registroPermitido, "El sistema permitió registro con campos vacíos");
    }
}
