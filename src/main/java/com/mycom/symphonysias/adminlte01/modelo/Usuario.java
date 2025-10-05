/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01.modelo;

/**
 *
 * @author Spiri
 */
public class Usuario {
    private String nombre;
    private String usuario;
    private String clave;
    private String rol;
    private int id;
    private boolean activo;
    
    // Constructo completo  
    public Usuario(String nombre, String usuario, String clave, String rol) {
        this.nombre = nombre;
        this.usuario = usuario;
        this.clave = clave;
        this.rol = rol;
    }
    
    public Usuario() {
        // Constructor vacío para uso en DAO
    }
    
    // Getters
    public String getNombre() {
        return nombre;
    }
    
    public String getUsuario() {
        return usuario;
    }
    
    public String getClave() {
        return clave;
    }
    
    public String getRol() {
        return rol;
    }
    
    // Setters
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
    
    public void setClave(String clave) {
        this.clave = clave;
    }
    
    public void setRol(String rol) {
        this.rol = rol;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public boolean isActivo() {
        return activo;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo; 
    }  
}
