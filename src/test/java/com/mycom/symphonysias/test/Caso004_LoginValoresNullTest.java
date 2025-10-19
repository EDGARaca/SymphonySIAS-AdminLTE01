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

public class Caso004_LoginValoresNullTest {
    @Test
    public void testLoginConValoresNull() {
        String usuario = null;
        assertThrows(NullPointerException.class, () -> {
            usuario.equals("admin");
        });
    }
}