/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */



/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:33065/login_symphony?useUnicode=true&characterEncoding=UTF-8&serverTimezone=America/Bogota";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("[CONEXIÓN] Conexión establecida correctamente.");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("[ERROR CONEXIÓN] Driver JDBC no encontrado.");
            throw new SQLException("Driver JDBC no encontrado", e);
        } catch (SQLException e) {
            System.err.println("[ERROR CONEXIÓN] Fallo al conectar con la base de datos: " + e.getMessage());
            throw e;
        }
    }
}