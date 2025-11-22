/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */
package com.mycom.symphonysias.adminlte01.modelo;

import java.sql.Timestamp;

public class ProductoMusical {
    // --- Identificadores ---
    private int idProducto;   // usado en PedidoDAO y AgregarCarritoServlet
    private int id;           // usado en ProductoMusicalDAO y otros servlets

    // --- Datos principales ---
    private String nombre;
    private String descripcion;
    private double precio;

    // --- Imagen ---
    private String imagen;       // mapea a imagen_url en BD
    private String rutaImagen;   // opcional, para rutas locales
    private String imagenUrl;    // compatibilidad con PedidoDAO

    // --- Extras opcionales ---
    private int cantidadDisponible;   // no existe en tabla productos, pero útil si lo agregas
    private String usuarioRegistro;   // idem
    private Timestamp fechaRegistro;  // idem

    // --- Oferta ---
    private double descuento;
    private boolean ofertaActiva;

    public ProductoMusical() {}

    // --- Getters y Setters ---
    public int getIdProducto() {
        return idProducto;
    }
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }
    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getImagen() {
        return imagen;
    }
    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getRutaImagen() {
        return rutaImagen;
    }
    public void setRutaImagen(String rutaImagen) {
        this.rutaImagen = rutaImagen;
    }

    public String getImagenUrl() {
        return imagenUrl;
    }
    public void setImagenUrl(String imagenUrl) {
        this.imagenUrl = imagenUrl;
    }

    public int getCantidadDisponible() {
        return cantidadDisponible;
    }
    public void setCantidadDisponible(int cantidadDisponible) {
        this.cantidadDisponible = cantidadDisponible;
    }

    public String getUsuarioRegistro() {
        return usuarioRegistro;
    }
    public void setUsuarioRegistro(String usuarioRegistro) {
        this.usuarioRegistro = usuarioRegistro;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }
    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public double getDescuento() {
        return descuento;
    }
    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public boolean isOfertaActiva() {
        return ofertaActiva;
    }
    public void setOfertaActiva(boolean ofertaActiva) {
        this.ofertaActiva = ofertaActiva;
    }

    // --- Precio con descuento aplicado ---
    public double getPrecioConDescuento() {
        if (ofertaActiva && descuento > 0) {
            return precio - (precio * descuento / 100.0);
        }
        return precio;
    }
}