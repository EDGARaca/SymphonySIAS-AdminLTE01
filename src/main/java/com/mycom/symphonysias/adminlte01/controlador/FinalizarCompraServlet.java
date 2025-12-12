/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.controlador;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import com.mycom.symphonysias.adminlte01.modelo.ItemCarrito;
import com.mycom.symphonysias.adminlte01.util.Conexion;

public class FinalizarCompraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String usuario = (String) session.getAttribute("usuario");
        if (usuario == null || usuario.trim().isEmpty()) {
            System.out.println("[FinalizarCompraServlet] Usuario no encontrado en sesión. Redirigiendo a login.");
            response.sendRedirect("login.jsp");
            return;
        }
        usuario = usuario.trim().toLowerCase(); // normalizar según consultas DAO

        @SuppressWarnings("unchecked")
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        System.out.println("[FinalizarCompraServlet] POST recibido, usuario=" + usuario);

        if (carrito == null || carrito.isEmpty()) {
            System.out.println("[FinalizarCompraServlet] Carrito vacío. Redirigiendo a verCarrito.jsp");
            response.sendRedirect("verCarrito.jsp");
            return;
        }

        try (Connection con = Conexion.getConexion()) {
            System.out.println("[DB] Conectado a esquema: " + con.getCatalog()); // debe ser login_symphony
            con.setAutoCommit(false);

            // 1) Calcular total con descuentos y trazar productos
            double total = 0;
            for (ItemCarrito item : carrito) {
                int idProd = item.getProducto().getIdProducto();
                String nombre = item.getProducto().getNombre();
                int cantidad = item.getCantidad();
                double precio = item.getProducto().getPrecio();
                double desc = item.getProducto().getDescuento();
                double subtotalDesc = item.getSubtotalConDescuento();
                total += subtotalDesc;

                System.out.println("[DETALLE] id_producto=" + idProd +
                        " nombre=" + nombre +
                        " cantidad=" + cantidad +
                        " precio=" + precio +
                        " desc(%)=" + desc +
                        " subtotal(desc)=" + subtotalDesc);
            }
            System.out.println("[TOTAL] Calculado para " + usuario + " = $" + String.format("%.2f", total));

            // 2) Insertar cabecera del pedido
            String sqlPedido = "INSERT INTO pedidos (usuario, fecha, total, estado) VALUES (?, NOW(), ?, 'CONFIRMADO')";
            try (PreparedStatement psPedido = con.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS)) {
                psPedido.setString(1, usuario);
                psPedido.setDouble(2, total);
                int affectedCab = psPedido.executeUpdate();
                System.out.println("[INSERT PEDIDO] filas afectadas=" + affectedCab);

                int idPedido = 0;
                try (ResultSet rsKeys = psPedido.getGeneratedKeys()) {
                    if (rsKeys.next()) idPedido = rsKeys.getInt(1);
                }
                System.out.println("[ID NUEVO PEDIDO] " + idPedido);

                if (idPedido <= 0) {
                    throw new RuntimeException("No se obtuvo id_pedido generado.");
                }

                // 3) Insertar detalles del pedido
                String sqlDetalle = "INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal, descuento) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement psDetalle = con.prepareStatement(sqlDetalle)) {
                    for (ItemCarrito item : carrito) {
                        psDetalle.setInt(1, idPedido);
                        psDetalle.setInt(2, item.getProducto().getIdProducto()); // debe existir (1 o 2 en tu BD actual)
                        psDetalle.setInt(3, item.getCantidad());
                        psDetalle.setDouble(4, item.getSubtotalConDescuento());  // guardar subtotal con descuento
                        psDetalle.setDouble(5, item.getProducto().getDescuento());
                        psDetalle.addBatch();
                    }
                    int[] detBatch = psDetalle.executeBatch();
                    int filasDet = java.util.Arrays.stream(detBatch).sum();
                    System.out.println("[INSERT DETALLE] filas afectadas=" + filasDet);
                }

                // 4) Registrar en tabla compras (auditoría)
                String sqlCompra = "INSERT INTO compras (id_usuario, fecha, total) VALUES (?, NOW(), ?)";
                try (PreparedStatement psCompra = con.prepareStatement(sqlCompra)) {
                    psCompra.setString(1, usuario);
                    psCompra.setDouble(2, total);
                    int affectedCompra = psCompra.executeUpdate();
                    System.out.println("[INSERT COMPRAS] filas afectadas=" + affectedCompra);
                }

                // 5) Confirmar transacción
                con.commit();
                System.out.println("[COMMIT] Pedido confirmado en BD con ID=" + idPedido);

                // 6) Limpiar y redirigir a confirmación
                session.removeAttribute("carrito");
                session.setAttribute("mensajeCompra", "Tu pedido #" + idPedido + " fue registrado correctamente.");
                response.sendRedirect("compraExitosa.jsp"); // pantalla de confirmación con enlaces a pedidos y compras
            }

        } catch (Exception e) {
            System.out.println("[ERROR] FinalizarCompraServlet: " + e.getClass().getName() + " - " + e.getMessage());
            if (e instanceof java.sql.SQLException) {
                java.sql.SQLException se = (java.sql.SQLException) e;
                System.out.println("[SQL ERROR] State=" + se.getSQLState() + " Code=" + se.getErrorCode());
            }
            // Intentar rollback si la conexión viva lo permite
            try (Connection c = Conexion.getConexion()) {
                c.rollback();
                System.out.println("[ROLLBACK] Transacción revertida.");
            } catch (Exception ex) {
                System.out.println("[ROLLBACK] No se pudo revertir: " + ex.getMessage());
            }
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}