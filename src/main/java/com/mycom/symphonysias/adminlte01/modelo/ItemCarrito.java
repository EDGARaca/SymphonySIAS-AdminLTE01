/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.modelo;

public class ItemCarrito {
    private ProductoMusical producto;
    private int cantidad;
    private double subtotal;

    // Constructor vacío
    public ItemCarrito() {
    }

    // Constructor con parámetros
    public ItemCarrito(ProductoMusical producto, int cantidad, double subtotal) {
        this.producto = producto;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
    }

    // Constructor con producto y cantidad
    public ItemCarrito(ProductoMusical producto, int cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
        this.subtotal = producto.getPrecio() * cantidad; // calcula subtotal automáticamente
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

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    // Método auxiliar para calcular subtotal automáticamente
    public void calcularSubtotal() {
        if (producto != null) {
            this.subtotal = producto.getPrecio() * cantidad;
        }
    }

    // 🔹 Subtotal con descuento aplicado desde el modelo
    public double getSubtotalConDescuento() {
        if (producto != null) {
            double precioConDescuento = producto.getPrecioConDescuento(); // usa lógica del modelo
            return precioConDescuento * cantidad;
        }
        return subtotal;
    }
}