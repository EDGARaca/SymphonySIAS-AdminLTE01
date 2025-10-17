/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import com.mycom.symphonysias.adminlte01.dao.EstudianteDAO;
import com.mycom.symphonysias.adminlte01.modelo.Estudiante;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/EstudianteServlet")
public class EstudianteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Trazabilidad en consola
        System.out.println("[SERVLET] Registro de nuevo estudiante");

        try {
            // Obtener parámetros del formulario
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String documento = request.getParameter("documento");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String email = request.getParameter("email");
            String fechaStr = request.getParameter("fechaNacimiento");
            String genero = request.getParameter("genero");
            String estado = request.getParameter("estado");
            String usuarioRegistro = request.getParameter("usuario_registro");

            // Convertir fecha
            Date fechaNacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

            // Crear objeto estudiante
            Estudiante estudiante = new Estudiante(nombre, apellido, documento, direccion,
                    telefono, email, fechaNacimiento, genero, estado, usuarioRegistro);

            // Insertar en base de datos
            EstudianteDAO dao = new EstudianteDAO();
            boolean exito = dao.insertarEstudiante(estudiante);

            if (exito) {
                System.out.println("[SERVLET] Estudiante registrado correctamente");
                response.sendRedirect("listarEstudiantes.jsp");
            } else {
                System.out.println("[SERVLET] Error al registrar estudiante");
                response.sendRedirect("registroEstudiante.jsp?error=1");
            }
            
          // Captura general para trazabilidad institucional
        } catch (Exception e) {
            System.out.println("[ERROR SERVLET] " + e.getMessage());
            response.sendRedirect("registroEstudiante.jsp?error=2");
        }
    }
}
