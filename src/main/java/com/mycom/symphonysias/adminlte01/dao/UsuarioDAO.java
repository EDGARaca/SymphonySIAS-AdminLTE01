/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.util.Conexion;
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import java.sql.Connection;
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
            conn = Conexion.getConexion();
            LOGGER.log(Level.INFO, "[DAO] Conexión establecida correctamente");
        } catch (SQLException e){
            LOGGER.log(Level.SEVERE, "Error al conectar desde UsuarioDAO", e);
        }
    }


    public Usuario validar(String usuario, String clave) {
        Usuario resultado = null;

        String sql = "SELECT * FROM usuarios WHERE usuario = ? AND clave = ? AND activo = 1";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario);
            ps.setString(2, clave); // ya viene en SHA-256 desde el servlet

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setClave(rs.getString("clave"));
                    u.setCorreo(rs.getString("correo"));
                    u.setRol(rs.getString("rol"));
                    u.setActivo(rs.getBoolean("activo"));
                    resultado = u;

                    LOGGER.log(Level.INFO, "Usuario validado: {0}", resultado.getUsuario());
                } else {
                    LOGGER.log(Level.WARNING, "No se encontró coincidencia para usuario: {0}", usuario);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al validar usuario", e);
        }

        return resultado;
    }

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT id, nombre, usuario, clave, correo, rol, activo FROM usuarios");

             ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setUsuario(rs.getString("usuario"));
                u.setClave(rs.getString("clave"));
                u.setCorreo(rs.getString("correo"));
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
    
    public boolean actualizar(Usuario u) {
    boolean resultado = false;
    PreparedStatement ps = null;

    String sql = "UPDATE usuarios SET nombre = ?, usuario = ?, rol = ?, activo = ? WHERE id = ?";

    try {
        ps = conn.prepareStatement(sql);
        ps.setString(1, u.getNombre());
        ps.setString(2, u.getUsuario());
        ps.setString(3, u.getRol());
        ps.setBoolean(4, u.isActivo());
        ps.setInt(5, u.getId());

        int filas = ps.executeUpdate();
        resultado = filas > 0;

        LOGGER.log(Level.INFO, "[DAO] Usuario actualizado. Filas afectadas: {0}", filas);

    } catch (SQLException e) {
        LOGGER.log(Level.SEVERE, "Error al actualizar usuario", e);
    } finally {
        try {
            if (ps != null) ps.close();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al cerrar PreparedStatement", e);
        }
    }

        return resultado;
    }
    
    public boolean crear(Usuario u) {
    boolean resultado = false;
    PreparedStatement ps = null;

    String sql = "INSERT INTO usuarios (nombre, usuario, clave, correo, rol, activo) VALUES (?, ?, ?, ?, ?, ?)";

    try {
        ps = conn.prepareStatement(sql);
        ps.setString(1, u.getNombre());
        ps.setString(2, u.getUsuario());
        ps.setString(3, u.getClave());
        ps.setString(4, u.getCorreo());
        ps.setString(5, u.getRol());
        ps.setBoolean(6, u.isActivo());

        int filas = ps.executeUpdate();
        resultado = filas > 0;

        LOGGER.log(Level.INFO, "[DAO] Usuario creado. Filas afectadas: {0}", filas);

    } catch (SQLException e) {
        LOGGER.log(Level.SEVERE, "Error al crear usuario", e);
        e.printStackTrace(); 
    }
       
        
    finally {
        try {
            if (ps != null) ps.close();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al cerrar PreparedStatement", e);
        }
    }

    return resultado;
    }
    
    public boolean eliminarUsuario(String id) {
    boolean eliminado = false;

    String sql = "DELETE FROM usuarios WHERE id = ?";

    try (Connection conn = Conexion.getConexion();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, id);
        int filas = stmt.executeUpdate();
        eliminado = filas > 0;

    } catch (SQLException ex) {
        LOGGER.log(Level.SEVERE, "[ERROR] Fallo al eliminar usuario", ex);
    }

    return eliminado;
    }

}