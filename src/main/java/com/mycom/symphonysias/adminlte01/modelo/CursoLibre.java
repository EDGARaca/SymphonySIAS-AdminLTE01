/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/*
 * Entidad de dominio: CursoLibre.
 * Representa la tabla curso_libre en la BD login_symphony.
 * ISO/IEC 25010:
 * - Claridad: nombres explícitos.
 * - Mantenibilidad: encapsulación y métodos alias para retrocompatibilidad.
 * - Confiabilidad: conversiones controladas y campos de auditoría.
 */


package com.mycom.symphonysias.adminlte01.modelo;

import java.time.LocalDateTime;

public class CursoLibre {

    // Identificador único (PK)
    private Integer id;

    // Nombre del curso (ej. "Guitarra Básica")
    private String nombre;

    // Costo del curso (DECIMAL 12,2). Usamos Double para interoperabilidad con JDBC.
    private Double valor;

    // Duración del curso en meses (INT)
    private Integer duracionMeses;

    // Frecuencia: semanal, mensual, quincenal
    private String frecuencia;

    // Estado del curso: activo / inactivo
    private String estado;

    // Usuario que registró el curso (FK usuarios.id) — INT
    private Integer idUsuarioRegistro;

    // Profesor asignado al curso (FK profesores.id)
    private Integer idProfesor;

    // Auditoría
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Constructor vacío
    public CursoLibre() {}

    // Constructor completo
    public CursoLibre(Integer id, String nombre, Double valor, Integer duracionMeses,
                      String frecuencia, String estado, Integer idUsuarioRegistro,
                      Integer idProfesor, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.nombre = nombre;
        this.valor = valor;
        this.duracionMeses = duracionMeses;
        this.frecuencia = frecuencia;
        this.estado = estado;
        this.idUsuarioRegistro = idUsuarioRegistro;
        this.idProfesor = idProfesor;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // =============================
    // Getters / Setters principales (camelCase)
    // =============================

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public Double getValor() { return valor; }
    public void setValor(Double valor) { this.valor = valor; }

    // Alias para compatibilidad con Servlets que envían int
    public void setValor(int valorEntero) { this.valor = Double.valueOf(valorEntero); }

    // Alias adicional para String (p.ej., lectura desde formularios)
    public void setValor(String valorStr) {
        if (valorStr == null || valorStr.isBlank()) {
            this.valor = null;
            return;
        }
        try {
            this.valor = Double.valueOf(valorStr.trim());
        } catch (NumberFormatException ex) {
            // Mantener confiabilidad: deja null para que el flujo superior valide
            this.valor = null;
        }
    }

    public Integer getDuracionMeses() { return duracionMeses; }
    public void setDuracionMeses(Integer duracionMeses) { this.duracionMeses = duracionMeses; }

    public String getFrecuencia() { return frecuencia; }
    public void setFrecuencia(String frecuencia) { this.frecuencia = frecuencia; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public Integer getIdUsuarioRegistro() { return idUsuarioRegistro; }
    public void setIdUsuarioRegistro(Integer idUsuarioRegistro) { this.idUsuarioRegistro = idUsuarioRegistro; }

    public Integer getIdProfesor() { return idProfesor; }
    public void setIdProfesor(Integer idProfesor) { this.idProfesor = idProfesor; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // =============================
    // Métodos alias (retrocompatibilidad snake_case)
    // =============================

    /**
     * Alias para compatibilidad con código legado:
     * getUsuario_registro() → devuelve idUsuarioRegistro.
     */
    public Integer getUsuario_registro() { return this.idUsuarioRegistro; }

    /**
     * Alias para compatibilidad con código legado:
     * setUsuario_registro(int) → asigna idUsuarioRegistro.
     */
    public void setUsuario_registro(int idUsuarioRegistro) { this.idUsuarioRegistro = idUsuarioRegistro; }

    /**
     * Alias extra: setUsuario_registro(String).
     * Convierte a entero cuando el String es numérico (evita errores de compilación
     * y facilita la integración con formularios).
     */
    public void setUsuario_registro(String idUsuarioRegistroStr) {
        if (idUsuarioRegistroStr == null || idUsuarioRegistroStr.isBlank()) {
            this.idUsuarioRegistro = null;
            return;
        }
        try {
            this.idUsuarioRegistro = Integer.valueOf(idUsuarioRegistroStr.trim());
        } catch (NumberFormatException ex) {
            // Si no es numérico, deja nulo para que el Servlet/DAO valide y reporte
            this.idUsuarioRegistro = null;
        }
    }

    /**
     * Alias snake_case para compatibilidad con código legado:
     * setId_profesor(Integer) → asigna idProfesor.
     */
    public void setId_profesor(Integer idProfesor) { this.idProfesor = idProfesor; }

    /**
     * Alias snake_case para compatibilidad con código legado:
     * getId_profesor() → devuelve idProfesor.
     */
    public Integer getId_profesor() { return this.idProfesor; }
}