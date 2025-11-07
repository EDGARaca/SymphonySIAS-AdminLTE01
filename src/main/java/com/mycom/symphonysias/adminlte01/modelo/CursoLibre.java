/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.modelo;

public class CursoLibre {
    private int id;
    private String nombre;
    private int valor;
    private String frecuencia;
    private String estado;
    private String usuario_registro;
    private String horario;
    private String nombreProfesor;

    // Constructor vacío
    public CursoLibre() {}

    // Constructor completo
    public CursoLibre(int id, String nombre, int valor, String frecuencia, String estado, String usuario_registro) {
        this.id = id;
        this.nombre = nombre;
        this.valor = valor;
        this.frecuencia = frecuencia;
        this.estado = estado;
        this.usuario_registro = usuario_registro;
    }

    // Getters y Setters
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

    public int getValor() {
        return valor;
    }

    public void setValor(int valor) {
        this.valor = valor;
    }

    public String getFrecuencia() {
        return frecuencia;
    }

    public void setFrecuencia(String frecuencia) {
        this.frecuencia = frecuencia;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getUsuario_registro() {
        return usuario_registro;
    }

    public void setUsuario_registro(String usuario_registro) {
        this.usuario_registro = usuario_registro;
    }
    
    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }
    
    public String getNombreProfesor() {
    return nombreProfesor;
    }

    public void setNombreProfesor(String nombreProfesor) {
        this.nombreProfesor = nombreProfesor;
    }

    
}