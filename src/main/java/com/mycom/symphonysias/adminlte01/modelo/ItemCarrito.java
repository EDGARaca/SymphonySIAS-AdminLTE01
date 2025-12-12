/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.modelo;

/**
 * ItemCarrito representa un producto musical dentro del carrito o en un pedido.
 * ISO/IEC 25010:
 * - Confiabilidad: cálculos consistentes de subtotal y descuento.
 * - Mantenibilidad: métodos claros y comentarios explicativos.
 * - Trazabilidad: incluye subtotalPersistido para reflejar valores históricos guardados en BD.
 */
public class ItemCarrito {

    private ProductoMusical producto;   // Producto asociado
    private int cantidad;               // Cantidad seleccionada
    private double subtotalPersistido;  // Subtotal histórico guardado en BD (detalle_pedido)

    // Constructor vacío
    public ItemCarrito() {
    }

    // Constructor con parámetros
    public ItemCarrito(ProductoMusical producto, int cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
    }

    // Getters y Setters
    public ProductoMusical getProducto() {
        return producto;
    }

    public void setProducto(ProductoMusical producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    /**
     * Subtotal calculado dinámicamente (precio actual * cantidad).
     * No incluye descuentos.
     */
    public double getSubtotal() {
        if (producto != null) {
            return producto.getPrecio() * cantidad;
        }
        return 0.0;
    }

    /**
     * Subtotal con descuento aplicado (precio con descuento * cantidad).
     * Usa los campos precio y descuento del modelo ProductoMusical.
     */
    public double getSubtotalConDescuento() {
        if (producto != null) {
            double precioBase = producto.getPrecio();
            double descuento = producto.getDescuento(); // porcentaje 0–100
            double precioConDescuento = precioBase;

            if (producto.isOfertaActiva() && descuento > 0) {
                precioConDescuento = precioBase - (precioBase * (descuento / 100.0));
            }

            return precioConDescuento * cantidad;
        }
        return 0.0;
    }

    /**
     * Subtotal persistido en BD (detalle_pedido).
     * Se usa para trazabilidad histórica de pedidos.
     */
    public double getSubtotalPersistido() {
        return subtotalPersistido;
    }

    public void setSubtotalPersistido(double subtotalPersistido) {
        this.subtotalPersistido = subtotalPersistido;
    }
}