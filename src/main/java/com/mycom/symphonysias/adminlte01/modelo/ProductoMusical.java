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
    private int idProducto;
    private String nombre;
    private String descripcion;
    private double precio;
    private double descuento;
    private String imagen;
    private String rutaImagen;
    private boolean ofertaActiva;
    private int cantidadDisponible;
    private String usuarioRegistro;
    private Timestamp fechaRegistro;
    
    public ProductoMusical() {}

    public ProductoMusical(int idProducto, String nombre, String descripcion, double precio, int descuento, String imagen, String rutaImagen) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.descuento = descuento;
        this.imagen = imagen;
        this.rutaImagen = rutaImagen;        
    }

    public int getId() {
        return idProducto;
    }

    
    public int getIdProducto() { return idProducto; }
    public void setId(int idProducto) { this.idProducto = idProducto; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public double getDescuento() { return descuento; }
    public void setDescuento(double descuento) { this.descuento = descuento; }
    
    public String getImagen() { return rutaImagen; }
    public void setImagen(String imagen) { this.rutaImagen = imagen; }
    
    public String getRutaImagen() { return rutaImagen; }
    public void setRutaImagen(String rutaImagen) { this.rutaImagen = rutaImagen; }


    public boolean isOfertaActiva() { return ofertaActiva; }
    public void setOfertaActiva(boolean ofertaActiva) { this.ofertaActiva = ofertaActiva; }

    public int getCantidadDisponible() { return cantidadDisponible; }
    public void setCantidadDisponible(int cantidadDisponible) { this.cantidadDisponible = cantidadDisponible; }

    public String getUsuarioRegistro() { return usuarioRegistro; }
    public void setUsuarioRegistro(String usuarioRegistro) { this.usuarioRegistro = usuarioRegistro; }

    public Timestamp getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(Timestamp fechaRegistro) { this.fechaRegistro = fechaRegistro; }

  


}