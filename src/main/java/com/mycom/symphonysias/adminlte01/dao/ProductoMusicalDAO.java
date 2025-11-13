/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoMusicalDAO {

    public List<ProductoMusical> listar() {
        List<ProductoMusical> lista = new ArrayList<>();
        String sql = "SELECT * FROM instrumentos_musicales";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductoMusical p = new ProductoMusical();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setImagen(rs.getString("imagen"));
                p.setPrecio(rs.getDouble("precio"));
                p.setDescuento(rs.getDouble("descuento"));
                p.setOfertaActiva(rs.getBoolean("oferta_activa"));
                p.setCantidadDisponible(rs.getInt("cantidad_disponible"));
                p.setUsuarioRegistro(rs.getString("usuario_registro"));
                p.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                lista.add(p);
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al listar productos: " + e.getMessage());
        }
        return lista;
    }

    public ProductoMusical buscarPorId(int id) {
        String sql = "SELECT * FROM instrumentos_musicales WHERE id = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductoMusical p = new ProductoMusical();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setImagen(rs.getString("imagen"));
                p.setPrecio(rs.getDouble("precio"));
                p.setDescuento(rs.getDouble("descuento"));
                p.setOfertaActiva(rs.getBoolean("oferta_activa"));
                p.setCantidadDisponible(rs.getInt("cantidad_disponible"));
                p.setUsuarioRegistro(rs.getString("usuario_registro"));
                p.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                return p;
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al buscar producto por ID: " + e.getMessage());
        }
        return null;
    }

    public void registrar(ProductoMusical p) {
        String sql = "INSERT INTO instrumentos_musicales (nombre, descripcion, precio, imagen, descuento, oferta_activa, cantidad_disponible, usuario_registro, fecha_registro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setString(4, p.getImagen());
            ps.setDouble(5, p.getDescuento());
            ps.setBoolean(6, p.isOfertaActiva());
            ps.setInt(7, p.getCantidadDisponible());
            ps.setString(8, p.getUsuarioRegistro());
            ps.setTimestamp(9, p.getFechaRegistro());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al registrar producto: " + e.getMessage());
        }
    }

    public void actualizar(ProductoMusical p) {
        String sql = "UPDATE instrumentos_musicales SET nombre = ?, descripcion = ?, precio = ?, imagen = ?, descuento = ?, oferta_activa = ?, cantidad_disponible = ?, usuario_registro = ?, fecha_registro = ? WHERE id = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setString(4, p.getImagen());
            ps.setDouble(5, p.getDescuento());
            ps.setBoolean(6, p.isOfertaActiva());
            ps.setInt(7, p.getCantidadDisponible());
            ps.setString(8, p.getUsuarioRegistro());
            ps.setTimestamp(9, p.getFechaRegistro());
            ps.setInt(10, p.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al actualizar producto: " + e.getMessage());
        }
    }

    public void eliminar(int id) {
        String sql = "DELETE FROM instrumentos_musicales WHERE id = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al eliminar producto: " + e.getMessage());
        }
    }

    public void actualizarCantidad(int id, int nuevaCantidad) {
        String sql = "UPDATE instrumentos_musicales SET cantidad_disponible = ? WHERE id = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, nuevaCantidad);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] al actualizar cantidad: " + e.getMessage());
        }
    }
}