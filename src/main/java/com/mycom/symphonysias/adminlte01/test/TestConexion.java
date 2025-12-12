/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.test;

import com.mycom.symphonysias.adminlte01.util.Conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestConexion {
    public static void main(String[] args) {
        try (Connection conn = Conexion.getConexion();
             Statement stmt = conn.createStatement()) {

            // Verificar base de datos activa
            ResultSet rs = stmt.executeQuery("SELECT DATABASE()");
            if (rs.next()) {
                System.out.println("[TEST] Base de datos activa: " + rs.getString(1));
            }

            // Verificar tabla usuarios
            rs = stmt.executeQuery("SELECT COUNT(*) FROM usuarios");
            if (rs.next()) {
                System.out.println("[TEST] Usuarios registrados: " + rs.getInt(1));
            }

            // Verificar tabla estudiantes
            rs = stmt.executeQuery("SELECT COUNT(*) FROM estudiantes");
            if (rs.next()) {
                System.out.println("[TEST] Estudiantes registrados: " + rs.getInt(1));
            }

            // Verificar tabla profesores
            rs = stmt.executeQuery("SELECT COUNT(*) FROM profesores");
            if (rs.next()) {
                System.out.println("[TEST] Profesores registrados: " + rs.getInt(1));
            }

        } catch (Exception e) {
            System.err.println("[ERROR TEST] Falló la conexión o consulta: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cerrar hilos de limpieza MySQL
            Conexion.cerrarHilosMySQL();
        }
    }
}