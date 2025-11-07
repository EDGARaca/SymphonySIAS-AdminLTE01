/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 * Modelo para inscripción a curso libre
 * @author EdgarACA
 */


package com.mycom.symphonysias.adminlte01.modelo;

import java.util.Date;

public class InscripcionCursoLibre {
    private int id;
    private int idEstudiante;
    private int idCursoLibre;
    private Date fechaInscripcion;
    private String estadoPago;
    private String usuarioRegistro;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdEstudiante() { return idEstudiante; }
    public void setIdEstudiante(int idEstudiante) { this.idEstudiante = idEstudiante; }

    public int getIdCursoLibre() { return idCursoLibre; }
    public void setIdCursoLibre(int idCursoLibre) { this.idCursoLibre = idCursoLibre; }

    public Date getFechaInscripcion() { return fechaInscripcion; }
    public void setFechaInscripcion(Date fechaInscripcion) { this.fechaInscripcion = fechaInscripcion; }

    public String getEstadoPago() { return estadoPago; }
    public void setEstadoPago(String estadoPago) { this.estadoPago = estadoPago; }

    public String getUsuarioRegistro() { return usuarioRegistro; }
    public void setUsuarioRegistro(String usuarioRegistro) { this.usuarioRegistro = usuarioRegistro; }
}