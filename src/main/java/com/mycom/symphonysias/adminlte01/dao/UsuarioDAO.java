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
import java.util.List;
import java.util.ArrayList;

/**
 * DAO para validación de usuarios en SymphonySIAS-AdminLTE01
 * @author Spiri
 */
public class UsuarioDAO {    
    private static final Logger LOGGER = Logger.getLogger(UsuarioDAO.class.getName());
    private Connection conn;
    
    public UsuarioDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:33065/login_symphony", "root", "");
            LOGGER.log(Level.INFO, "[DAO] Conexión establecida correctamente");
        } catch (ClassNotFoundException | SQLException e){
            LOGGER.log(Level.SEVERE, "Error al conectar en constructor UsuarioDAO", e);
        }
    }
    
    public Usuario validar(String usuario, String clave) {
        Usuario resultado = null;
        
        try (PreparedStatement ps = conn.prepareStatement(
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
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al validar usuario", e); // Se puede reemplazar por logger si se desea
        }
        return resultado;
    }
    
    public List<Usuario> listarUsuarios() {
        List<Usuario>lista = new ArrayList<>();
        
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT id, nombre, usuario, rol, activo FROM usuarios");
            ResultSet rs = ps.executeQuery()
        ) {
           while (rs.next()) {
               Usuario u = new Usuario();
               u.setId(rs.getInt("id"));
               u.setNombre(rs.getString("nombre"));
               u.setUsuario(rs.getString("usuario"));
               u.setRol(rs.getString("rol"));
               u.setActivo(rs.getBoolean("activo"));
               lista.add(u);
           }
        } catch (SQLException e){
            LOGGER.log(Level.SEVERE, "Error al listar usuarios", e);
        }
    
        LOGGER.log(Level.INFO, "{DAO} Usuarios recuperados: {0}", lista.size());
        
        return lista;
    }
}    
