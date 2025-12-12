/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para ProductoMusical.
 * ISO/IEC 25010:
 * - Confiabilidad: PreparedStatement, try-with-resources, manejo de nulls.
 * - Mantenibilidad: CRUD claros y alineados con el esquema.
 * - Trazabilidad: logs consistentes; lectura/escritura de auditoría.
 *
 * Nota: El control de permisos y reglas (ej. coherencia oferta/descuento) van en Servlets/JSP.
 */
public class ProductoMusicalDAO {

    // =========================
    // Listar todos los productos
    // =========================
    public List<ProductoMusical> listar() {
        List<ProductoMusical> lista = new ArrayList<>();
        final String sql = "SELECT id_producto, nombre, descripcion, imagen_url, precio, descuento, oferta_activa, " +
                           "stock, estado, id_usuario_registro, id_profesor, created_at, updated_at " +
                           "FROM productos_musicales ORDER BY created_at DESC";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductoMusical p = new ProductoMusical();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setImagenUrl(rs.getString("imagen_url"));
                p.setPrecio(rs.getDouble("precio"));
                p.setDescuento(rs.getDouble("descuento"));
                p.setOfertaActiva(rs.getBoolean("oferta_activa"));
                p.setStock(rs.getInt("stock"));
                p.setEstado(rs.getString("estado"));
                p.setIdUsuarioRegistro(rs.getInt("id_usuario_registro"));

                // id_profesor puede ser NULL → usar wasNull para representarlo como Integer null
                int idProf = rs.getInt("id_profesor");
                p.setIdProfesor(rs.wasNull() ? null : idProf);

                // Auditoría (pueden venir NULL)
                Timestamp cAt = rs.getTimestamp("created_at");
                Timestamp uAt = rs.getTimestamp("updated_at");
                p.setCreatedAt(cAt != null ? cAt.toLocalDateTime() : null);
                p.setUpdatedAt(uAt != null ? uAt.toLocalDateTime() : null);

                lista.add(p);
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] listar productos: " + e.getMessage());
        }
        return lista;
    }

    // =========================
    // Buscar producto por ID
    // =========================
    public ProductoMusical buscarPorId(int idProducto) {
        final String sql = "SELECT id_producto, nombre, descripcion, imagen_url, precio, descuento, oferta_activa, " +
                           "stock, estado, id_usuario_registro, id_profesor, created_at, updated_at " +
                           "FROM productos_musicales WHERE id_producto = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductoMusical p = new ProductoMusical();
                    p.setIdProducto(rs.getInt("id_producto"));
                    p.setNombre(rs.getString("nombre"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setImagenUrl(rs.getString("imagen_url"));
                    p.setPrecio(rs.getDouble("precio"));
                    p.setDescuento(rs.getDouble("descuento"));
                    p.setOfertaActiva(rs.getBoolean("oferta_activa"));
                    p.setStock(rs.getInt("stock"));
                    p.setEstado(rs.getString("estado"));
                    p.setIdUsuarioRegistro(rs.getInt("id_usuario_registro"));

                    int idProf = rs.getInt("id_profesor");
                    p.setIdProfesor(rs.wasNull() ? null : idProf);

                    Timestamp cAt = rs.getTimestamp("created_at");
                    Timestamp uAt = rs.getTimestamp("updated_at");
                    p.setCreatedAt(cAt != null ? cAt.toLocalDateTime() : null);
                    p.setUpdatedAt(uAt != null ? uAt.toLocalDateTime() : null);

                    return p;
                }
            }
        } catch (SQLException e) {
            System.err.println("[ERROR DAO] buscarPorId: " + e.getMessage());
        }
        return null;
    }

    // =========================
    // Registrar nuevo producto
    // =========================
    public boolean registrar(ProductoMusical p) {
        final String sql = "INSERT INTO productos_musicales " +
                           "(nombre, descripcion, imagen_url, precio, descuento, oferta_activa, stock, estado, id_usuario_registro, id_profesor) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getImagenUrl());
            ps.setDouble(4, p.getPrecio());
            ps.setDouble(5, p.getDescuento());
            ps.setBoolean(6, p.isOfertaActiva());
            ps.setInt(7, p.getStock());
            ps.setString(8, p.getEstado() != null ? p.getEstado() : "activo");
            ps.setInt(9, p.getIdUsuarioRegistro());
            if (p.getIdProfesor() != null) {
                ps.setInt(10, p.getIdProfesor());
            } else {
                ps.setNull(10, Types.INTEGER);
            }

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        p.setIdProducto(keys.getInt(1));
                    }
                }
            }
            System.out.println("[DAO] registrar() OK: id=" + p.getIdProducto());
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("[ERROR DAO] registrar producto: " + e.getMessage());
            return false;
        }
    }

    // =========================
    // Actualizar producto existente
    // =========================
    public boolean actualizar(ProductoMusical p) {
        final String sql = "UPDATE productos_musicales SET " +
                           "nombre = ?, descripcion = ?, imagen_url = ?, precio = ?, descuento = ?, oferta_activa = ?, " +
                           "stock = ?, estado = ?, id_profesor = ? " +
                           "WHERE id_producto = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getImagenUrl());
            ps.setDouble(4, p.getPrecio());
            ps.setDouble(5, p.getDescuento());
            ps.setBoolean(6, p.isOfertaActiva());
            ps.setInt(7, p.getStock());
            ps.setString(8, p.getEstado());
            if (p.getIdProfesor() != null) {
                ps.setInt(9, p.getIdProfesor());
            } else {
                ps.setNull(9, Types.INTEGER);
            }
            ps.setInt(10, p.getIdProducto());

            int rows = ps.executeUpdate();
            System.out.println("[DAO] actualizar() filas=" + rows);
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("[ERROR DAO] actualizar producto: " + e.getMessage());
            return false;
        }
    }

    // =========================
    // Eliminación lógica (estado='inactivo')
    // =========================
    public boolean eliminar(int idProducto) {
        final String sql = "UPDATE productos_musicales SET estado='inactivo' WHERE id_producto = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            int rows = ps.executeUpdate();
            System.out.println("[DAO] eliminar(logico) filas=" + rows);
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("[ERROR DAO] eliminar(logico): " + e.getMessage());
            return false;
        }
    }

    // =========================
    // Eliminación física (precaución)
    // =========================
    public boolean eliminarFisico(int idProducto) {
        final String sql = "DELETE FROM productos_musicales WHERE id_producto = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            int rows = ps.executeUpdate();
            System.out.println("[DAO] eliminarFisico() filas=" + rows);
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("[ERROR DAO] eliminarFisico(): " + e.getMessage());
            return false;
        }
    }
}