/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 * DAO para gestión de profesores en SymphonySIAS
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.Profesor;
import com.mycom.symphonysias.adminlte01.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProfesorDAO {
    private static final Logger LOGGER = Logger.getLogger(ProfesorDAO.class.getName());
    private Connection conn;

    public ProfesorDAO() {
        try {
            conn = Conexion.getConexion();
            LOGGER.log(Level.INFO, "[DAO] Conexión establecida correctamente");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al conectar desde ProfesorDAO", e);
        }
    }

    public boolean insertarProfesor(Profesor p) {
        boolean resultado = false;
        PreparedStatement ps = null;

        String sql = "INSERT INTO profesores (nombre, apellido, documento, direccion, telefono, correo, fecha_nacimiento, especialidad, genero, estado, usuario_registro) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getApellido());
            ps.setString(3, p.getDocumento());
            ps.setString(4, p.getDireccion());
            ps.setString(5, p.getTelefono());
            ps.setString(6, p.getCorreo());
            ps.setString(7, p.getFecha_nacimiento());
            ps.setString(8, p.getEspecialidad());
            ps.setString(9, p.getGenero());
            ps.setString(10, p.getEstado());
            ps.setString(11, p.getUsuario_registro());

            int filas = ps.executeUpdate();
            resultado = filas > 0;

            LOGGER.log(Level.INFO, "[DAO] Profesor creado. Filas afectadas: {0}", filas);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al crear profesor", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error al cerrar PreparedStatement", e);
            }
        }

        return resultado;
    }

    public boolean actualizar_Profesor(Profesor p) {
        boolean resultado = false;
        PreparedStatement ps = null;

        String sql = "UPDATE profesores SET nombre = ?, apellido = ?, documento = ?, direccion = ?, telefono = ?, correo = ?, fecha_nacimiento = ?, especialidad = ?, genero = ?, estado = ? WHERE id = ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getApellido());
            ps.setString(3, p.getDocumento());
            ps.setString(4, p.getDireccion());
            ps.setString(5, p.getTelefono());
            ps.setString(6, p.getCorreo());
            ps.setString(7, p.getFecha_nacimiento());
            ps.setString(8, p.getEspecialidad());
            ps.setString(9, p.getGenero());
            ps.setString(10, p.getEstado());
            ps.setInt(11, p.getId());

            int filas = ps.executeUpdate();
            resultado = filas > 0;

            LOGGER.log(Level.INFO, "[DAO] Profesor actualizado. Filas afectadas: {0}", filas);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al actualizar profesor", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error al cerrar PreparedStatement", e);
            }
        }

        return resultado;
    }

    public List<Profesor> listar() {
        List<Profesor> lista = new ArrayList<>();

        String sql = "SELECT id, nombre, apellido, documento, direccion, telefono, correo, fecha_nacimiento, especialidad, genero, estado, usuario_registro FROM profesores";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Profesor p = new Profesor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setDocumento(rs.getString("documento"));
                p.setDireccion(rs.getString("direccion"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                p.setEspecialidad(rs.getString("especialidad"));
                p.setGenero(rs.getString("genero"));
                p.setEstado(rs.getString("estado"));
                p.setUsuario_registro(rs.getString("usuario_registro"));

                lista.add(p);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al listar profesores", e);
        }

        LOGGER.log(Level.INFO, "[DAO] Profesores recuperados: {0}", lista.size());
        return lista;
    }

    public Profesor buscarPorId(int id) {
        Profesor p = null;
        String sql = "SELECT * FROM profesores WHERE id = ?";
        
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p= new Profesor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setDocumento(rs.getString("documento"));
                p.setDireccion(rs.getString("direccion"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                p.setEspecialidad(rs.getString("especialidad"));
                p.setGenero(rs.getString("genero"));
                p.setEstado(rs.getString("estado"));
                p.setUsuario_registro(rs.getString("usuario_registro"));
                
                System.out.println("[DAO] Usuario que registró: " + p.getUsuario_registro());
            }
            
            

        } catch (SQLException e) {
            System.err.println("[ERROR DAO] buscarPorId: " + e.getMessage());
        }
        return p;
    }
    
    public List<Profesor> buscarPorApellido(String apellido) {
        List<Profesor> lista = new ArrayList<>();
        String sql = "SELECT * FROM profesores WHERE apellido LIKE ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + apellido + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Profesor p = new Profesor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setDocumento(rs.getString("documento"));
                p.setDireccion(rs.getString("direccion"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                p.setEspecialidad(rs.getString("especialidad"));
                p.setGenero(rs.getString("genero"));
                p.setEstado(rs.getString("estado"));
                p.setUsuario_registro(rs.getString("usuario_registro"));
                lista.add(p);
            }

            System.out.println("[BUSCAR] Filtro por apellido: " + apellido + " → " + lista.size() + " resultados.");

        } catch (SQLException e) {
            System.err.println("[ERROR BUSCAR] Error al buscar por apellido: " + e.getMessage());
        }
        return lista;
    }
    
    public List<Profesor> buscarPorNombre(String nombre) {
        List<Profesor> lista = new ArrayList<>();
        String sql = "SELECT * FROM profesores WHERE nombre LIKE ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + nombre + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Profesor p = new Profesor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setDocumento(rs.getString("documento"));
                p.setDireccion(rs.getString("direccion"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                p.setEspecialidad(rs.getString("especialidad"));
                p.setGenero(rs.getString("genero"));
                p.setEstado(rs.getString("estado"));
                p.setUsuario_registro(rs.getString("usuario_registro"));
                lista.add(p);
            }

            System.out.println("[BUSCAR] Filtro por nombre: " + nombre + " → " + lista.size() + " resultados.");

        } catch (SQLException e) {
            System.err.println("[ERROR BUSCAR] Error al buscar por nombre: " + e.getMessage());
        }
        return lista;
    }
    
    public List<Profesor> buscarPorDocumento(String documento) {
        List<Profesor> lista = new ArrayList<>();
        String sql = "SELECT * FROM profesores WHERE documento LIKE ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + documento + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Profesor p = new Profesor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setDocumento(rs.getString("documento"));
                p.setDireccion(rs.getString("direccion"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                p.setEspecialidad(rs.getString("especialidad"));
                p.setGenero(rs.getString("genero"));
                p.setEstado(rs.getString("estado"));
                p.setUsuario_registro(rs.getString("usuario_registro"));
                lista.add(p);
            }

            System.out.println("[BUSCAR] Filtro por documento: " + documento + " → " + lista.size() + " resultados.");

        } catch (SQLException e) {
            System.err.println("[ERROR BUSCAR] Error al buscar por documento: " + e.getMessage());
        }
        return lista;
    }
    

    public boolean eliminarProfesor(int id) {
        String sql = "DELETE FROM profesores WHERE id=?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            System.out.println("[DAO] Eliminando profesor ID: " + id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo eliminar profesor: " + e.getMessage());
            return false;
        }
    }
}