/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 * Modelo de Producto Musical.
 * ISO/IEC 25010:
 * - Confiabilidad: getters/setters consistentes con la BD y JSP.
 * - Mantenibilidad: comentarios claros y tipos adecuados.
 * - Trazabilidad: incluye campos de auditoría y relaciones con usuario/profesor.
 */
package com.mycom.symphonysias.adminlte01.modelo;

import java.time.LocalDateTime;

public class ProductoMusical {

    // Identificadores
    private Integer idProducto;          // PK
    private Integer idProfesor;          // FK opcional
    private Integer idUsuarioRegistro;   // FK obligatorio

    // Datos de negocio
    private String nombre;
    private String descripcion;
    private String imagenUrl;            // columna imagen_url
    private double precio;
    private double descuento;            // porcentaje 0–100
    private boolean ofertaActiva;
    private int stock;
    private String estado;               // 'activo' | 'inactivo'

    // Auditoría
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // =========================
    // Getters y Setters
    // =========================

    public Integer getIdProducto() { return idProducto; }
    public void setIdProducto(Integer idProducto) { this.idProducto = idProducto; }

    public Integer getIdProfesor() { return idProfesor; }
    public void setIdProfesor(Integer idProfesor) { this.idProfesor = idProfesor; }

    public Integer getIdUsuarioRegistro() { return idUsuarioRegistro; }
    public void setIdUsuarioRegistro(Integer idUsuarioRegistro) { this.idUsuarioRegistro = idUsuarioRegistro; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public double getDescuento() { return descuento; }
    public void setDescuento(double descuento) { this.descuento = descuento; }

    public boolean isOfertaActiva() { return ofertaActiva; }
    public void setOfertaActiva(boolean ofertaActiva) { this.ofertaActiva = ofertaActiva; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // =========================
    // Métodos auxiliares
    // =========================

    /** Precio con descuento aplicado */
    public double getPrecioConDescuento() {
        if (ofertaActiva && descuento > 0) {
            return precio - (precio * (descuento / 100.0));
        }
        return precio;
    }

    // Métodos auxiliares para compatibilidad con JSP antiguos
    public Integer getId() { return getIdProducto(); }
    public String getImagen() { return getImagenUrl(); }
}