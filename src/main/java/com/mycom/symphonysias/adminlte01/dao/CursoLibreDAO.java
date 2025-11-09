/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CursoLibreDAO {

    public static List<CursoLibre> buscarCursos(String nombre, String frecuencia, String estado) {
        List<CursoLibre> lista = new ArrayList<>();
        String sql = "SELECT * FROM curso_libre WHERE 1=1";

        if (nombre != null && !nombre.trim().isEmpty()) {
            sql += " AND nombre LIKE ?";
        }
        if (frecuencia != null && !frecuencia.trim().isEmpty()) {
            sql += " AND frecuencia = ?";
        }
        if (estado != null && !estado.trim().isEmpty()) {
            sql += " AND estado = ?";
        }

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;
            if (nombre != null && !nombre.trim().isEmpty()) {
                ps.setString(index++, "%" + nombre + "%");
            }
            if (frecuencia != null && !frecuencia.trim().isEmpty()) {
                ps.setString(index++, frecuencia);
            }
            if (estado != null && !estado.trim().isEmpty()) {
                ps.setString(index++, estado);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CursoLibre curso = new CursoLibre();
                curso.setId(rs.getInt("id"));
                curso.setNombre(rs.getString("nombre"));
                curso.setValor(rs.getDouble("valor"));
                curso.setFrecuencia(rs.getString("frecuencia"));
                curso.setEstado(rs.getString("estado"));
                curso.setUsuario_registro(rs.getString("usuario_registro"));
                curso.setNombreProfesor(rs.getString("nombre_profesor"));
                lista.add(curso);
            }

        } catch (Exception e) {
            System.err.println("[ERROR DAO] buscarCursos(): " + e.getMessage());
        }

        return lista;
    }
    
    public List<CursoLibre> listarActivos() {
    List<CursoLibre> lista = new ArrayList<>();
    String sql = "SELECT c.id, c.nombre, c.valor, c.frecuencia, c.estado, c.usuario_registro, p.nombre AS nombre_profesor " +
             "FROM curso_libre c " +
             "LEFT JOIN profesores p ON c.id_profesor = p.id " +
             "WHERE c.estado = 'activo'";
    
    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            CursoLibre c = new CursoLibre(
                rs.getInt("id"),
                rs.getString("nombre"),
                rs.getDouble("valor"),
                rs.getString("frecuencia"),
                rs.getString("estado"),
                rs.getString("usuario_registro")
            );

            c.setNombreProfesor(rs.getString("nombre_profesor"));
            lista.add(c);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return lista;
}
    
    public static boolean insertar(CursoLibre curso) {
        String sql = "INSERT INTO curso_libre (nombre, valor, frecuencia, estado, usuario_registro) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, curso.getNombre());
            ps.setDouble(2, curso.getValor());
            ps.setString(3, curso.getFrecuencia());
            ps.setString(4, curso.getEstado());
            ps.setString(5, curso.getUsuario_registro());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("[ERROR DAO] insertar(): " + e.getMessage());
            return false;
        }
    }
    
    public static boolean actualizar(CursoLibre curso) {
        String sql = "UPDATE curso_libre SET nombre=?, valor=?, frecuencia=?, estado=?, usuario_registro=? WHERE id=?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, curso.getNombre());
            ps.setDouble(2, curso.getValor());
            ps.setString(3, curso.getFrecuencia());
            ps.setString(4, curso.getEstado());
            ps.setString(5, curso.getUsuario_registro());
            ps.setInt(6, curso.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("[ERROR DAO] actualizar(): " + e.getMessage());
            return false;
        }
    }
    
    public static boolean actualizarEstado(int id, String estado) {
        String sql = "UPDATE curso_libre SET estado=? WHERE id=?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, estado);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("[ERROR DAO] actualizarEstado(): " + e.getMessage());
            return false;
        }
    }
    
    public static boolean eliminarFisico(int id) {
        String sql = "DELETE FROM curso_libre WHERE id=?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("[ERROR DAO] eliminarFisico(): " + e.getMessage());
            return false;
        }
    }
    
    public List<CursoLibre> listarSinProfesor() {
        List<CursoLibre> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, valor, frecuencia, estado, usuario_registro FROM curso_libre WHERE estado = 'activo' AND id_profesor IS NULL";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CursoLibre curso = new CursoLibre();
                curso.setId(rs.getInt("id"));
                curso.setNombre(rs.getString("nombre"));
                curso.setValor(rs.getDouble("valor"));
                curso.setFrecuencia(rs.getString("frecuencia"));
                curso.setEstado(rs.getString("estado"));
                curso.setUsuario_registro(rs.getString("usuario_registro"));
                curso.setIdProfesor(0); // trazabilidad: sin asignar
                curso.setNombreProfesor("Sin asignar");
                lista.add(curso);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
    
}