/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utilitario de hashing SHA-256
 * Cumple con robustez y mantenibilidad (ISO/IEC 25010)
 */
public final class HashUtil {

    private HashUtil() {
        // Evita instanciación
    }

    /**
     * Genera hash SHA-256 en hex minúscula. 
     * @param input cadena a hashear (puede ser null)
     * @return hash hex (64 chars) o cadena vacía si input es null
     */
    public static String sha256(String input) {
        if (input == null) return "";
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder(64);
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            // Propaga como RuntimeException para trazabilidad en capas superiores
            throw new RuntimeException("Error al generar hash SHA-256", e);
        }
    }
}
