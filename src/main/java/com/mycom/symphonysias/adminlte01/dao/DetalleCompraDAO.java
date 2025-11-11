/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.DetalleCompra;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.SQLException;



public class DetalleCompraDAO {
    public void registrarDetalle(DetalleCompra detalle) {
        String sql = "INSERT INTO detalle_compra (id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, detalle.getIdCompra());
            ps.setInt(2, detalle.getIdProducto());
            ps.setInt(3, detalle.getCantidad());
            ps.setDouble(4, detalle.getPrecioUnitario());
            ps.setDouble(5, detalle.getSubtotal());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al registrar detalle: " + e.getMessage());
        }
    }
    
    public List<DetalleCompra> listarPorCompra(int idCompra) {
        List<DetalleCompra> lista = new ArrayList<>();
        String sql = "SELECT * FROM detalle_compra WHERE id_compra = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCompra);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DetalleCompra d = new DetalleCompra();
                d.setId(rs.getInt("id"));
                d.setIdCompra(rs.getInt("id_compra"));
                d.setIdProducto(rs.getInt("id_producto"));
                d.setCantidad(rs.getInt("cantidad"));
                d.setPrecioUnitario(rs.getDouble("precio_unitario"));
                d.setSubtotal(rs.getDouble("subtotal"));
                lista.add(d);
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al listar detalles por compra: " + e.getMessage());
        }
        return lista;
    }
    
    
    
    
}

