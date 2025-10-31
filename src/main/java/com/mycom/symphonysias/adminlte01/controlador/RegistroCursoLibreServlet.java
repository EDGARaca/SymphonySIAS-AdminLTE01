/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO;
import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;


public class RegistroCursoLibreServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validación de codificación
        request.setCharacterEncoding("UTF-8");

        // Captura de datos del formulario
        String nombre = request.getParameter("nombre");
        String valorStr = request.getParameter("valor");
        String frecuencia = request.getParameter("frecuencia");
        String usuario_registro = request.getParameter("usuario_registro");

        // Validación básica
        if (nombre == null || valorStr == null || frecuencia == null || usuario_registro == null) {
            System.out.println("[Servlet] Datos incompletos para registrar curso");
            response.sendRedirect("registroCursoLibre.jsp");
            return;
        }

        int valor = Integer.parseInt(valorStr);

        // Construcción del objeto
        CursoLibre curso = new CursoLibre();
        curso.setNombre(nombre);
        curso.setValor(valor);
        curso.setFrecuencia(frecuencia);
        curso.setEstado("activo");
        curso.setUsuario_registro(usuario_registro);

        // Inserción en base de datos
        CursoLibreDAO dao = new CursoLibreDAO();
        boolean exito = dao.insertar(curso);

        // Trazabilidad y redirección
        if (exito) {
            System.out.println("[Servlet] Curso registrado exitosamente: " + nombre);
            response.sendRedirect("listarCursoLibre.jsp");
        } else {
            System.out.println("[Servlet] Error al registrar curso: " + nombre);
            response.sendRedirect("registroCursoLibre.jsp");
        }
    }
}