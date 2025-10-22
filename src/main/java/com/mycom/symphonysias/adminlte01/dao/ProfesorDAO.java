/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.Profesor;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;

public class ProfesorDAO {

    public boolean insertarProfesor(Profesor profesor) {
        String sql = "INSERT INTO profesores (nombre, apellido, documento, direccion, telefono, correo, fecha_nacimiento, especialidad, genero, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, profesor.getNombre());
            stmt.setString(2, profesor.getApellido());
            stmt.setString(3, profesor.getDocumento());
            stmt.setString(4, profesor.getDireccion());
            stmt.setString(5, profesor.getTelefono());
            stmt.setString(6, profesor.getCorreo());
            stmt.setDate(7, new java.sql.Date(profesor.getFechaNacimiento().getTime()));
            stmt.setString(8, profesor.getEspecialidad());
            stmt.setString(9, profesor.getGenero());
            stmt.setString(10, profesor.getEstado());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("[ERROR DAO] No se pudo insertar profesor: " + e.getMessage());
            return false;
        }
    }

    public List<Profesor> listarProfesores() {
        List<Profesor> lista = new ArrayList<>();
        String sql = "SELECT * FROM profesores";

        try (Connection conn = Conexion.getConexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Profesor prof = new Profesor();
                prof.setId(rs.getInt("id"));
                prof.setNombre(rs.getString("nombre"));
                prof.setApellido(rs.getString("apellido"));
                prof.setDocumento(rs.getString("documento"));
                prof.setDireccion(rs.getString("direccion"));
                prof.setTelefono(rs.getString("telefono"));
                prof.setCorreo(rs.getString("correo"));
                prof.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                prof.setEspecialidad(rs.getString("especialidad"));
                prof.setGenero(rs.getString("genero"));
                prof.setEstado(rs.getString("estado"));

                lista.add(prof);
            }

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo listar profesores: " + e.getMessage());
        }

        return lista;
    }

    public Profesor buscarPorId(int id) {
        String sql = "SELECT * FROM profesores WHERE id = ?";
        Profesor prof = null;

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                prof = new Profesor();
                prof.setId(rs.getInt("id"));
                prof.setNombre(rs.getString("nombre"));
                prof.setApellido(rs.getString("apellido"));
                prof.setDocumento(rs.getString("documento"));
                prof.setDireccion(rs.getString("direccion"));
                prof.setTelefono(rs.getString("telefono"));
                prof.setCorreo(rs.getString("correo"));
                prof.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                prof.setEspecialidad(rs.getString("especialidad"));
                prof.setGenero(rs.getString("genero"));
                prof.setEstado(rs.getString("estado"));
            }

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo buscar profesor por ID: " + e.getMessage());
        }

        return prof;
    }

    public boolean actualizarProfesor(Profesor profesor) {
        String sql = "UPDATE profesores SET nombre=?, apellido=?, documento=?, direccion=?, telefono=?, correo=?, fecha_nacimiento=?, especialidad=?, genero=?, estado=? WHERE id=?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, profesor.getNombre());
            stmt.setString(2, profesor.getApellido());
            stmt.setString(3, profesor.getDocumento());
            stmt.setString(4, profesor.getDireccion());
            stmt.setString(5, profesor.getTelefono());
            stmt.setString(6, profesor.getCorreo());
            stmt.setDate(7, new java.sql.Date(profesor.getFechaNacimiento().getTime()));
            stmt.setString(8, profesor.getEspecialidad());
            stmt.setString(9, profesor.getGenero());
            stmt.setString(10, profesor.getEstado());
            stmt.setInt(11, profesor.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo actualizar profesor: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminarProfesor(int id) {
        String sql = "DELETE FROM profesores WHERE id=?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo eliminar profesor: " + e.getMessage());
            return false;
        }
    }
    
    public List<Profesor> listar() {
        List<Profesor> lista = new ArrayList<>();
        String sql = "SELECT * FROM profesores";

        try (Connection conn = Conexion.getConexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Profesor prof = new Profesor();
                prof.setId(rs.getInt("id"));
                prof.setNombre(rs.getString("nombre"));
                prof.setApellido(rs.getString("apellido"));
                prof.setDocumento(rs.getString("documento"));
                prof.setDireccion(rs.getString("direccion"));
                prof.setTelefono(rs.getString("telefono"));
                prof.setCorreo(rs.getString("correo"));
                prof.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                prof.setEspecialidad(rs.getString("especialidad"));
                prof.setGenero(rs.getString("genero"));
                prof.setEstado(rs.getString("estado"));

                lista.add(prof);
            }

        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo listar profesores: " + e.getMessage());
        }

        return lista;
    }
    
    
}