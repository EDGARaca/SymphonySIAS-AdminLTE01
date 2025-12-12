/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import com.mycom.symphonysias.adminlte01.modelo.Pedido;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;
import com.mycom.symphonysias.adminlte01.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * PedidoDAO
 * Acceso a datos para pedidos y sus detalles.
 *
 * ISO/IEC 25010:
 * - Confiabilidad: consultas parametrizadas, try-with-resources, manejo seguro de nulls.
 * - Mantenibilidad: métodos claros y comentarios, separación de responsabilidades.
 * - Trazabilidad: logs de error controlados (prefijo [PedidoDAO]), resultados ordenados por fecha.
 *
 * Nota:
 * - Este DAO asume que la tabla "pedidos" usa un campo "usuario" (VARCHAR) y que
 *   "detalle_pedido" referencia productos por "id_producto".
 * - Los detalles se obtienen uniendo a "productos_musicales" (no "productos" legacy).
 */
public class PedidoDAO {

    // =========================
    // Obtener un pedido por ID (incluye detalles)
    // =========================
    public Pedido obtenerPedidoPorId(int idPedido) {
        Pedido pedido = null;
        final String sql = "SELECT id_pedido, usuario, fecha, total, estado " +
                           "FROM pedidos WHERE id_pedido = ?";

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
            System.err.println("[PedidoDAO] obtenerPedidoPorId error: " + e.getMessage());
        }
        return pedido;
    }

    // =========================
    // Listar pedidos por usuario (cabeceras)
    // =========================
    public List<Pedido> listarPedidosPorUsuario(String usuario) {
        List<Pedido> pedidos = new ArrayList<>();
        final String sql = "SELECT id_pedido, usuario, fecha, total, estado " +
                           "FROM pedidos WHERE LOWER(usuario) = ? ORDER BY fecha DESC";

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
            System.err.println("[PedidoDAO] listarPedidosPorUsuario error: " + e.getMessage());
        }
        return pedidos;
    }

    // =========================
    // Obtener detalles de un pedido
    // =========================
    private List<ItemCarrito> obtenerDetallesPedido(int idPedido, Connection con) {
        List<ItemCarrito> detalles = new ArrayList<>();

        // Se alinea al modelo actual uniendo contra productos_musicales
        final String sql = "SELECT pm.id_producto, pm.nombre, pm.descripcion, pm.precio, pm.imagen_url, " +
                           "       pm.descuento AS descuento_producto, pm.oferta_activa, " +
                           "       dp.cantidad, dp.subtotal, dp.descuento AS descuento_detalle " +
                           "FROM detalle_pedido dp " +
                           "JOIN productos_musicales pm ON dp.id_producto = pm.id_producto " +
                           "WHERE dp.id_pedido = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPedido);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductoMusical prod = new ProductoMusical();
                    prod.setIdProducto(rs.getInt("id_producto"));
                    prod.setNombre(rs.getString("nombre"));
                    prod.setDescripcion(rs.getString("descripcion"));
                    prod.setPrecio(rs.getDouble("precio"));         // precio original de catálogo
                    prod.setImagenUrl(rs.getString("imagen_url"));

                    // Preferimos el descuento guardado en el detalle si existe; si es 0, usamos el del producto
                    double descDetalle = rs.getDouble("descuento_detalle");
                    double descProducto = rs.getDouble("descuento_producto");
                    double descuentoAplicado = (descDetalle > 0) ? descDetalle : descProducto;
                    prod.setDescuento(descuentoAplicado);
                    prod.setOfertaActiva(descuentoAplicado > 0 || rs.getBoolean("oferta_activa"));

                    int cantidad = rs.getInt("cantidad");
                    double subtotal = rs.getDouble("subtotal");

                    ItemCarrito item = new ItemCarrito(prod, cantidad);
                    // Mantener subtotal del pedido (ya calculado y persistido)
                    // aunque ItemCarrito puede recalcular, usamos el guardado para trazabilidad histórica
                    // (descuentos y precios pueden haber cambiado después).
                    item.setSubtotalPersistido(subtotal);

                    detalles.add(item);
                }
            }
        } catch (Exception e) {
            System.err.println("[PedidoDAO] obtenerDetallesPedido error: " + e.getMessage());
        }
        return detalles;
    }

    // =========================
    // Obtener pedidos por usuario (alias para MisPedidosServlet)
    // =========================
    public List<Pedido> obtenerPedidosPorUsuario(String usuario) {
        List<Pedido> lista = new ArrayList<>();
        final String sql = "SELECT id_pedido, usuario, fecha, total, estado " +
                           "FROM pedidos WHERE LOWER(usuario) = ? ORDER BY fecha DESC";

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
                    p.setUsuario(usuario);
                    lista.add(p);
                }
            }
        } catch (Exception e) {
            System.err.println("[PedidoDAO] obtenerPedidosPorUsuario error: " + e.getMessage());
        }

        return lista;
    }
}