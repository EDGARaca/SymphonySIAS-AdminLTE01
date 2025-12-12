/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */



/*
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;

public class Conexion {

    private static String URL;
    private static String USER;
    private static String PASS;

    // Bloque estático: se ejecuta al cargar la clase
    static {
        try (InputStream input = Conexion.class.getClassLoader().getResourceAsStream("db.properties")) {
            Properties props = new Properties();
            if (input == null) {
                throw new RuntimeException("[ERROR CONEXIÓN] No se encontró el archivo db.properties en resources.");
            }
            props.load(input);

            URL = props.getProperty("db.url");
            USER = props.getProperty("db.user");
            PASS = props.getProperty("db.pass");

            System.out.println("[CONEXIÓN] Parámetros cargados desde db.properties.");
        } catch (Exception e) {
            System.err.println("[ERROR CONEXIÓN] No se pudieron cargar las propiedades: " + e.getMessage());
        }
    }

    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("[CONEXIÓN] Conexión establecida correctamente.");
            return conn;
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC no encontrado", e);
        }
    }

    public static void cerrarHilosMySQL() {
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("[CONEXIÓN] Hilo de limpieza MySQL cerrado correctamente.");
        } catch (Exception e) {
            System.err.println("[ERROR CONEXIÓN] No se pudo cerrar el hilo de limpieza MySQL: " + e.getMessage());
        }
    }
}