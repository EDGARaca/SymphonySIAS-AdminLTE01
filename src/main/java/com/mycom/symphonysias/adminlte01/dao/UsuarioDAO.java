/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO para validación de usuarios en SymphonySIAS-AdminLTE01
 * @author Spiri
 */
public class UsuarioDAO {
    
    private static final Logger LOGGER = Logger.getLogger(UsuarioDAO.class.getName());
    
    public Usuario validar(String usuario, String clave) {
        Usuario resultado = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Carga explícita del driver
            
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:33065/login_symphony", "root", "");
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT nombre, usuario, clave, rol FROM usuarios WHERE usuario=? AND clave=?")
            ) {    
                ps.setString(1, usuario);
                ps.setString(2, clave);
            
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        resultado = new Usuario(
                            rs.getString("nombre"),
                            rs.getString("usuario"), 
                            rs.getString("clave"),
                            rs.getString("rol")    
                        );
                        LOGGER.log(Level.INFO, "Usuario validado: {0}", resultado.getUsuario());
                    } else {
                        LOGGER.log(Level.WARNING, "No se encontró coincidencia para usuario: {0}", usuario);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error al validar usuario", e); // Se puede reemplazar por logger si se desea
        }
        return resultado;
    }   
}
