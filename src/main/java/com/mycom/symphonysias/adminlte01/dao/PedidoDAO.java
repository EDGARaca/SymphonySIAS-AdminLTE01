/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.Pedido;
import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PedidoDAO {

    // Obtener un pedido por ID (incluye detalles)
    public Pedido obtenerPedidoPorId(int idPedido) {
        Pedido pedido = null;
        String sql = "SELECT id_pedido, usuario, fecha, total, estado FROM pedidos WHERE id_pedido=?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idPedido);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pedido = new Pedido();
                    pedido.setIdPedido(rs.getInt("id_pedido"));
                    pedido.setUsuario(rs.getString("usuario"));
                    pedido.setFecha(rs.getTimestamp("fecha"));
                    pedido.setTotal(rs.getDouble("total"));
                    pedido.setEstado(rs.getString("estado"));

                    // Cargar detalles del pedido con la misma conexión
                    pedido.setDetalles(obtenerDetallesPedido(idPedido, con));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pedido;
    }

    // Listar pedidos por usuario (cabecera)
    public List<Pedido> listarPedidosPorUsuario(String usuario) {
        List<Pedido> pedidos = new ArrayList<>();
        String sql = "SELECT id_pedido, usuario, fecha, total, estado " +
                     "FROM pedidos WHERE LOWER(usuario)=? ORDER BY fecha DESC";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.toLowerCase().trim());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pedido p = new Pedido();
                    p.setIdPedido(rs.getInt("id_pedido"));
                    p.setUsuario(rs.getString("usuario"));
                    p.setFecha(rs.getTimestamp("fecha"));
                    p.setTotal(rs.getDouble("total"));
                    p.setEstado(rs.getString("estado"));
                    pedidos.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pedidos;
    }

    // Obtener detalles de un pedido (productos + cantidades + descuento + cálculo de subtotal)
    private List<ItemCarrito> obtenerDetallesPedido(int idPedido, Connection con) {
        List<ItemCarrito> detalles = new ArrayList<>();
        String sql = "SELECT p.id_producto, p.nombre, p.descripcion, p.precio, p.imagen_url, " +
                     "       dp.cantidad, dp.subtotal, dp.descuento " +
                     "FROM detalle_pedido dp " +
                     "JOIN productos p ON dp.id_producto = p.id_producto " +
                     "WHERE dp.id_pedido=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPedido);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductoMusical prod = new ProductoMusical();
                    prod.setIdProducto(rs.getInt("id_producto"));
                    prod.setNombre(rs.getString("nombre"));
                    prod.setDescripcion(rs.getString("descripcion"));
                    prod.setPrecio(rs.getDouble("precio")); // precio original desde productos
                    prod.setImagenUrl(rs.getString("imagen_url"));
                    prod.setDescuento(rs.getDouble("descuento"));

                    int cantidad = rs.getInt("cantidad");
                    double subtotal = rs.getDouble("subtotal");

                    ItemCarrito item = new ItemCarrito(prod, cantidad);
                    item.setSubtotal(subtotal);
                    detalles.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return detalles;
    }

    // Obtener pedidos por usuario (para MisPedidosServlet)
    public List<Pedido> obtenerPedidosPorUsuario(String usuario) {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT id_pedido, fecha, total, estado FROM pedidos WHERE LOWER(usuario)=? ORDER BY fecha DESC";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.toLowerCase().trim());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pedido p = new Pedido();
                    p.setIdPedido(rs.getInt("id_pedido"));
                    Timestamp ts = rs.getTimestamp("fecha");
                    p.setFecha(ts);
                    p.setTotal(rs.getDouble("total"));
                    p.setEstado(rs.getString("estado"));
                    lista.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}