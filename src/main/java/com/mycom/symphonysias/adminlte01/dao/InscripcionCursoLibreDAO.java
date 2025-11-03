/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.InscripcionCursoLibre;
import java.sql.*;
import java.util.*;

public class InscripcionCursoLibreDAO {

    private Connection conectar() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:33065/login_symphony?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "");
    }

    public boolean registrar(InscripcionCursoLibre insc) {
        String sql = "INSERT INTO inspcurlibre (id_estudiante, id_curso_libre, fecha_inscripcion, estado_pago, usuario_registro) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = conectar(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, insc.getIdEstudiante());
            ps.setInt(2, insc.getIdCursoLibre());
            ps.setDate(3, new java.sql.Date(insc.getFechaInscripcion().getTime()));
            ps.setString(4, insc.getEstadoPago());
            ps.setString(5, insc.getUsuarioRegistro());
            int filas = ps.executeUpdate();
            System.out.println("[DAO] Inscripción creada. Filas afectadas: " + filas);
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("[ERROR DAO] " + e.getMessage());
            return false;
        }
    }

    public List<InscripcionCursoLibre> listar() {
        List<InscripcionCursoLibre> lista = new ArrayList<>();
        String sql = "SELECT * FROM inspcurlibre";
        try (Connection con = conectar(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                InscripcionCursoLibre i = new InscripcionCursoLibre();
                i.setId(rs.getInt("id"));
                i.setIdEstudiante(rs.getInt("id_estudiante"));
                i.setIdCursoLibre(rs.getInt("id_curso_libre"));
                i.setFechaInscripcion(rs.getDate("fecha_inscripcion"));
                i.setEstadoPago(rs.getString("estado_pago"));
                i.setUsuarioRegistro(rs.getString("usuario_registro"));
                lista.add(i);
            }
            System.out.println("[DAO] Inscripciones recuperadas: " + lista.size());
        } catch (SQLException e) {
            System.out.println("[ERROR DAO] " + e.getMessage());
        }
        return lista;
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM inspcurlibre WHERE id = ?";
        try (Connection con = conectar(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            int filas = ps.executeUpdate();
            System.out.println("[DAO] Inscripción eliminada. Filas afectadas: " + filas);
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo eliminar inscripción: " + e.getMessage());
            return false;
        }
    }
    
    
    public InscripcionCursoLibre buscarPorId(int id) {
        String sql = "SELECT * FROM inspcurlibre WHERE id = ?";
        try (Connection con = conectar(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                InscripcionCursoLibre i = new InscripcionCursoLibre();
                i.setId(rs.getInt("id"));
                i.setIdEstudiante(rs.getInt("id_estudiante"));
                i.setIdCursoLibre(rs.getInt("id_curso_libre"));
                i.setFechaInscripcion(rs.getDate("fecha_inscripcion"));
                i.setEstadoPago(rs.getString("estado_pago"));
                i.setUsuarioRegistro(rs.getString("usuario_registro"));
                return i;
            }
        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo buscar inscripción: " + e.getMessage());
        }
        return null;
    }

    public boolean actualizar(InscripcionCursoLibre insc) {
        String sql = "UPDATE inspcurlibre SET id_estudiante=?, id_curso_libre=?, fecha_inscripcion=?, estado_pago=?, usuario_registro=? WHERE id=?";
        try (Connection con = conectar(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, insc.getIdEstudiante());
            ps.setInt(2, insc.getIdCursoLibre());
            ps.setDate(3, new java.sql.Date(insc.getFechaInscripcion().getTime()));
            ps.setString(4, insc.getEstadoPago());
            ps.setString(5, insc.getUsuarioRegistro());
            ps.setInt(6, insc.getId());
            int filas = ps.executeUpdate();
            System.out.println("[DAO] Inscripción actualizada. Filas afectadas: " + filas);
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("[ERROR DAO] No se pudo actualizar inscripción: " + e.getMessage());
            return false;
        }
    }   
}