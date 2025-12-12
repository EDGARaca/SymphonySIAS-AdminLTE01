/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/*
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.modelo;

import java.util.Date;

public class Pedido {
    private int idPedido;
    private String usuario;
    private Date fecha;
    private double total;
    private String estado;

    // Constructor vacío
    public Pedido() {
    }

    // Constructor con parámetros
    public Pedido(int idPedido, String usuario, Date fecha, double total, String estado) {
        this.idPedido = idPedido;
        this.usuario = usuario;
        this.fecha = fecha;
        this.total = total;
        this.estado = estado;
    }

    // Getters y Setters
    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    // Lista de detalles del pedido
    private java.util.List<ItemCarrito> detalles;

    public java.util.List<ItemCarrito> getDetalles() {
        return detalles;
    }

    public void setDetalles(java.util.List<ItemCarrito> detalles) {
        this.detalles = detalles;
    }

}