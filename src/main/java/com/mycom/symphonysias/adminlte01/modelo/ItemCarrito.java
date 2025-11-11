/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.modelo;

import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;

public class ItemCarrito {
    private ProductoMusical producto;
    private int cantidad;

    public ItemCarrito(ProductoMusical producto, int cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
    }

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
        if (producto == null) return 0;
        double precioFinal = producto.isOfertaActiva()
            ? producto.getPrecio() * (1 - producto.getDescuento())
            : producto.getPrecio();
        return precioFinal * cantidad;
    }
}