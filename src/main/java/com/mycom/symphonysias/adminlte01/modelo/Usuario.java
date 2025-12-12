/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.modelo;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * Modelo de Usuario para SymphonySIAS-AdminLTE01
 * Mejora robustez y mantenibilidad sin romper compatibilidad
 */


public class Usuario {
    // Campos principales (compatibles con DAO y BD)
    private int id;
    private String nombre;
    private String usuario;
    private String clave;
    private String correo;
    private String rol;
    private boolean activo;
    
    // Auditoría (presentes en BD)
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    private LocalDateTime last_password_change;
    
    // Constructores
    public Usuario() {
        // Constructor vacío para uso en DAO
    }
    
    // Constructor completo  
    public Usuario(String nombre, String usuario, String clave, String rol) {
        this.nombre = nombre;
        this.usuario = usuario;
        this.clave = clave;
        this.rol = rol;
    }
    
    public Usuario(int id, String nombre, String usuario, String clave, String correo, String rol, boolean activo) {
        this.id = id;
        this.nombre = nombre;
        this.usuario = usuario;
        this.clave = clave;
        this.correo = correo;
        this.rol = rol;
        this.activo = activo;
    }
    
    // Getters
    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public String getUsuario() { return usuario; }
    public String getClave() { return clave; }
    public String getCorreo() { return correo; }
    public String getRol() { return rol; }
    public boolean isActivo() { return activo; }
    public LocalDateTime getCreated_at() { return created_at; }
    public LocalDateTime getUpdated_at() { return updated_at; }
    public LocalDateTime getLast_password_change() { return last_password_change; }

    public void setId(int id) { this.id = id; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public void setClave(String clave) { this.clave = clave; } // debe ser hash SHA-256
    public void setCorreo(String correo) { this.correo = correo; }
    public void setRol(String rol) { this.rol = rol; }
    public void setActivo(boolean activo) { this.activo = activo; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }
    public void setUpdated_at(LocalDateTime updated_at) { this.updated_at = updated_at; }
    public void setLast_password_change(LocalDateTime last_password_change) { this.last_password_change = last_password_change; }

// Mantenibilidad y trazabilidad
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Usuario)) return false;
        Usuario usuario1 = (Usuario) o;
        return id == usuario1.id &&
               Objects.equals(usuario, usuario1.usuario);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, usuario);
    }

    @Override
    public String toString() {
        return "Usuario{" +
               "id=" + id +
               ", nombre='" + nombre + '\'' +
               ", usuario='" + usuario + '\'' +
               ", correo='" + correo + '\'' +
               ", rol='" + rol + '\'' +
               ", activo=" + activo +
               '}';
    }
}
