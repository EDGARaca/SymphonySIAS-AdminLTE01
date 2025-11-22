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

    // Listar todos los productos
    public List<ProductoMusical> listar() {
        List<ProductoMusical> lista = new ArrayList<>();
        String sql = "SELECT id_producto, nombre, descripcion, precio, imagen_url, descuento, oferta_activa FROM productos";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductoMusical p = new ProductoMusical();
                p.setId(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setImagen(rs.getString("imagen_url"));
                p.setDescuento(rs.getDouble("descuento"));
                p.setOfertaActiva(rs.getBoolean("oferta_activa"));
                lista.add(p);
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] listar productos: " + e.getMessage());
        }
        return lista;
    }

    // Buscar producto por ID
    public ProductoMusical buscarPorId(int idProducto) {
        String sql = "SELECT id_producto, nombre, descripcion, precio, imagen_url, descuento, oferta_activa FROM productos WHERE id_producto = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductoMusical p = new ProductoMusical();
                    p.setId(rs.getInt("id_producto"));
                    p.setNombre(rs.getString("nombre"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setPrecio(rs.getDouble("precio"));
                    p.setImagen(rs.getString("imagen_url"));
                    p.setDescuento(rs.getDouble("descuento"));
                    p.setOfertaActiva(rs.getBoolean("oferta_activa"));
                    return p;
                }
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] buscarPorId: " + e.getMessage());
        }
        return null;
    }

    // Registrar nuevo producto
    public void registrar(ProductoMusical p) {
        String sql = "INSERT INTO productos (nombre, descripcion, precio, imagen_url, descuento, oferta_activa) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setString(4, p.getImagen());
            ps.setDouble(5, p.getDescuento());
            ps.setBoolean(6, p.isOfertaActiva());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] registrar producto: " + e.getMessage());
        }
    }

    // Actualizar producto existente
    public void actualizar(ProductoMusical p) {
        String sql = "UPDATE productos SET nombre = ?, descripcion = ?, precio = ?, imagen_url = ?, descuento = ?, oferta_activa = ? WHERE id_producto = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setString(4, p.getImagen());
            ps.setDouble(5, p.getDescuento());
            ps.setBoolean(6, p.isOfertaActiva());
            ps.setInt(7, p.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] actualizar producto: " + e.getMessage());
        }
    }

    // Eliminar producto por ID
    public void eliminar(int idProducto) {
        String sql = "DELETE FROM productos WHERE id_producto = ?";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] eliminar producto: " + e.getMessage());
        }
    }
}