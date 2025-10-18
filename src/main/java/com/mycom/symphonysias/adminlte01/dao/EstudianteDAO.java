/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.Estudiante;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;


public class EstudianteDAO {

    public boolean insertarEstudiante(Estudiante estudiante) {
        String sql = "INSERT INTO estudiantes (nombre, apellido, documento, direccion, telefono, correo, fecha_nacimiento, genero, estado, usuario_registro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, estudiante.getNombre());
            stmt.setString(2, estudiante.getApellido());
            stmt.setString(3, estudiante.getDocumento());
            stmt.setString(4, estudiante.getDireccion());
            stmt.setString(5, estudiante.getTelefono());
            stmt.setString(6, estudiante.getCorreo());
            stmt.setDate(7, new java.sql.Date(estudiante.getFechaNacimiento().getTime()));
            stmt.setString(8, estudiante.getGenero());
            stmt.setString(9, estudiante.getEstado());
            stmt.setString(10, estudiante.getUsuarioRegistro());

            return stmt.executeUpdate() > 0;
            

        } catch (Exception e) {
            System.out.println("[ERROR DAO] No se pudo insertar estudiante: " + e.getMessage());
            return false;
        }
    }
    
    public List<Estudiante> listarEstudiantes() {
        List<Estudiante> lista = new ArrayList<>();
        String sql = "SELECT * FROM estudiantes";

        try (Connection conn = Conexion.getConexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Estudiante est = new Estudiante();
                est.setId(rs.getInt("id"));
                est.setNombre(rs.getString("nombre"));
                est.setApellido(rs.getString("apellido"));
                est.setDocumento(rs.getString("documento"));
                est.setDireccion(rs.getString("direccion"));
                est.setTelefono(rs.getString("telefono"));
                est.setCorreo(rs.getString("correo"));
                est.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                est.setGenero(rs.getString("genero"));
                est.setEstado(rs.getString("estado"));
                est.setUsuarioRegistro(rs.getString("usuario_registro"));

                lista.add(est);
            }

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo listar estudiantes: " + e.getMessage());
        }

        return lista;
    }
    
    public Estudiante buscarPorId(int id) {
        String sql = "SELECT * FROM estudiantes WHERE id = ?";
        Estudiante est = null;

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                est = new Estudiante();
                est.setId(rs.getInt("id"));
                est.setNombre(rs.getString("nombre"));
                est.setApellido(rs.getString("apellido"));
                est.setDocumento(rs.getString("documento"));
                est.setDireccion(rs.getString("direccion"));
                est.setTelefono(rs.getString("telefono"));                
                est.setCorreo(rs.getString("correo"));
                est.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                est.setGenero(rs.getString("genero"));
                est.setEstado(rs.getString("estado"));
                est.setUsuarioRegistro(rs.getString("usuario_registro"));
            }

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo buscar estudiante por ID: " + e.getMessage());
        }

        return est;
    }
    
    public boolean actualizarEstudiante(Estudiante estudiante) {
        String sql = "UPDATE estudiantes SET nombre=?, apellido=?, documento=?, direccion=?, telefono=?, correo=?, fecha_nacimiento=?, genero=?, estado=? WHERE id=?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, estudiante.getNombre());
            stmt.setString(2, estudiante.getApellido());
            stmt.setString(3, estudiante.getDocumento());
            stmt.setString(4, estudiante.getDireccion());
            stmt.setString(5, estudiante.getTelefono());
            stmt.setString(6, estudiante.getCorreo());
            stmt.setDate(7, new java.sql.Date(estudiante.getFechaNacimiento().getTime()));
            stmt.setString(8, estudiante.getGenero());
            stmt.setString(9, estudiante.getEstado());
            stmt.setInt(10, estudiante.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo actualizar estudiante: " + e.getMessage());
            return false;
        }
    }
    
    public boolean eliminarEstudiante(int id) {
        String sql = "DELETE FROM estudiantes WHERE id=?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo eliminar estudiante: " + e.getMessage());
            return false;
        }
    }

}