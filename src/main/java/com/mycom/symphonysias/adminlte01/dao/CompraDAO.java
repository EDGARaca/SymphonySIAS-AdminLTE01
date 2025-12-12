/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.Compra;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CompraDAO {

    // Registrar compra en tabla compras
    public int registrarCompra(String usuario, double total) {
        String sql = "INSERT INTO compras (id_usuario, fecha, total) VALUES (?, NOW(), ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, usuario);
            ps.setDouble(2, total);
            int affected = ps.executeUpdate();

            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Listar compras por usuario
    public List<Compra> listarComprasPorUsuario(String usuario) {
        List<Compra> compras = new ArrayList<>();
        String sql = "SELECT id, id_usuario, fecha, total FROM compras WHERE LOWER(id_usuario)=? ORDER BY fecha DESC";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.toLowerCase().trim());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Compra c = new Compra();
                    c.setId(rs.getInt("id"));
                    c.setUsuario(rs.getString("id_usuario")); // ⚠️ propiedad debe llamarse usuario en Compra.java
                    c.setFecha(rs.getTimestamp("fecha"));
                    c.setTotal(rs.getDouble("total"));
                    compras.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return compras;
    }

}