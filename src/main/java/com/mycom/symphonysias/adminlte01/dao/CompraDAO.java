/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.Compra;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.SQLException;





public class CompraDAO {
    public int registrarCompra(Compra compra) {
        String sql = "INSERT INTO compras (id_usuario, fecha, total) VALUES (?, ?, ?)";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, compra.getUsuario());
            ps.setTimestamp(2, compra.getFecha());
            ps.setDouble(3, compra.getTotal());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // ID generado
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al registrar compra: " + e.getMessage());
        }
        return -1;
    }
    
    
    public List<Compra> listarPorUsuario(String usuario) {
        List<Compra> lista = new ArrayList<>();
        String sql = "SELECT * FROM compras WHERE id_usuario = ? ORDER BY fecha DESC";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Compra c = new Compra();
                c.setId(rs.getInt("id"));
                c.setUsuario(rs.getString("id_usuario"));
                c.setFecha(rs.getTimestamp("fecha"));
                c.setTotal(rs.getDouble("total"));
                lista.add(c);
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al listar compras por usuario: " + e.getMessage());
        }
        return lista;
    }
    
    
    
    public List<Compra> listarTodas() {
        List<Compra> lista = new ArrayList<>();
        String sql = "SELECT * FROM compras ORDER BY fecha DESC";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Compra c = new Compra();
                c.setId(rs.getInt("id"));
                c.setUsuario(rs.getString("id_usuario"));
                c.setFecha(rs.getTimestamp("fecha"));
                c.setTotal(rs.getDouble("total"));
                lista.add(c);
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al listar todas las compras: " + e.getMessage());
        }
        return lista;
    }
    
    
}

