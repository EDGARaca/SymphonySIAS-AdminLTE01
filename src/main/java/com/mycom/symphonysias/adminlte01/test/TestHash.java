/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.test;
import com.mycom.symphonysias.adminlte01.util.HashUtil;

/**
 *
 * @author Spiri
 */
public class TestHash {
    public static void main(String[] args) {
        String clave = "Admin_SIAS_2025!";
        String hash = HashUtil.sha256(clave);
        System.out.println("Clave original: " + clave);
        System.out.println("Hash generado:  " + hash);
    }
}
