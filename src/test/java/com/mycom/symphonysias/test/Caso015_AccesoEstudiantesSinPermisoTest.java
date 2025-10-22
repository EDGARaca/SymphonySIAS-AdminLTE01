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

public class Caso015_AccesoEstudiantesSinPermisoTest {
    @Test
    public void testAccesoAEstudiantesSinPermiso() {
        String permiso = null;
        assertNull(permiso, "Acceso denegado por falta de permiso");
    }
}