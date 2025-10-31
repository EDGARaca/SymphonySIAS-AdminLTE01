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
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CursoLibreDAO {

    private Connection conn;

    public CursoLibreDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:33065/login_symphony", "root", "");
            System.out.println("[DAO] Conexión establecida con curso_libre");
        } catch (Exception e) {
            System.out.println("[DAO] Error de conexión: " + e.getMessage());
        }
    }

    // INSERTAR
    public boolean insertar(CursoLibre curso) {
        String sql = "INSERT INTO curso_libre (nombre, valor, frecuencia, estado, usuario_registro) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, curso.getNombre());
            stmt.setInt(2, curso.getValor());
            stmt.setString(3, curso.getFrecuencia());
            stmt.setString(4, curso.getEstado());
            stmt.setString(5, curso.getUsuario_registro());

            int filas = stmt.executeUpdate();
            System.out.println("[DAO] Curso insertado: " + curso.getNombre() + " | Filas afectadas: " + filas);
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("[DAO] Error al insertar curso: " + e.getMessage());
            return false;
        }
    }

    // LISTAR TODOS
    public List<CursoLibre> listar() {
        List<CursoLibre> lista = new ArrayList<>();
        String sql = "SELECT * FROM curso_libre ORDER BY id DESC";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                CursoLibre c = new CursoLibre();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                c.setValor(rs.getInt("valor"));
                c.setFrecuencia(rs.getString("frecuencia"));
                c.setEstado(rs.getString("estado"));
                c.setUsuario_registro(rs.getString("usuario_registro"));

                lista.add(c);
            }

            System.out.println("[DAO] Cursos listados: " + lista.size());
        } catch (SQLException e) {
            System.out.println("[DAO] Error al listar cursos: " + e.getMessage());
        }

        return lista;
    }

    // BUSCAR POR ID
    public CursoLibre buscarPorId(int id) {
        CursoLibre curso = null;
        String sql = "SELECT * FROM curso_libre WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                curso = new CursoLibre();
                curso.setId(rs.getInt("id"));
                curso.setNombre(rs.getString("nombre"));
                curso.setValor(rs.getInt("valor"));
                curso.setFrecuencia(rs.getString("frecuencia"));
                curso.setEstado(rs.getString("estado"));
                curso.setUsuario_registro(rs.getString("usuario_registro"));

                System.out.println("[DAO] Curso encontrado: " + curso.getNombre());
            } else {
                System.out.println("[DAO] No se encontró curso con ID: " + id);
            }
        } catch (SQLException e) {
            System.out.println("[DAO] Error al buscar curso: " + e.getMessage());
        }

        return curso;
    }

    // ACTUALIZAR
    public boolean actualizar(CursoLibre curso) {
        String sql = "UPDATE curso_libre SET nombre = ?, valor = ?, frecuencia = ?, estado = ?, usuario_registro = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, curso.getNombre());
            stmt.setInt(2, curso.getValor());
            stmt.setString(3, curso.getFrecuencia());
            stmt.setString(4, curso.getEstado());
            stmt.setString(5, curso.getUsuario_registro());
            stmt.setInt(6, curso.getId());

            int filas = stmt.executeUpdate();
            System.out.println("[DAO] Curso actualizado: " + curso.getNombre() + " | Filas afectadas: " + filas);
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("[DAO] Error al actualizar curso: " + e.getMessage());
            return false;
        }
    }

    // ELIMINAR (CAMBIO DE ESTADO)
    public boolean eliminar(int id) {
        String sql = "UPDATE curso_libre SET estado = 'inactivo' WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            int filas = stmt.executeUpdate();
            System.out.println("[DAO] Curso inactivado con ID: " + id + " | Filas afectadas: " + filas);
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("[DAO] Error al inactivar curso: " + e.getMessage());
            return false;
        }
    }
}