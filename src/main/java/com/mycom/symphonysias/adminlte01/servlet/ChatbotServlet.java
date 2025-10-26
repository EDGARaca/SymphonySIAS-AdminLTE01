/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ChatbotServlet")
public class ChatbotServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configurar respuesta como texto plano o JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Obtener pregunta del usuario
        String pregunta = request.getParameter("pregunta");
        String respuesta;

        // Lógica simple de respuesta (puedes mejorarla luego)
        if (pregunta == null || pregunta.trim().isEmpty()) {
            respuesta = "No entendí tu pregunta.";
        } else {
            String p = pregunta.toLowerCase();
            if (p.contains("hola")) {
                respuesta = "Hola soy ChatBot SYMPHONY, ¿en qué puedo ayudarte?";
            } else if (p.contains("instrumentos")) {
                respuesta = "Puedes aprender Piano, Guitarra, Batería, Violín, Trompeta, Saxofón, Tiple.";
            } else if (p.contains("cursos")) {
                respuesta = "Tenemos Preparatorio 1 y 2, Básico 1 a 4.";
            } else if (p.contains("valor")) {
                respuesta = "El semestre cuesta $3.850.000 COP. Con Armonía Aplicada: $5.000.000 COP.";
            } else if (p.contains("forma")) {
                respuesta = "Puedes pagar en efectivo, Daviplata, Nequi o PayPal.";
            } else {
                respuesta = "Lo siento, aún no tengo respuesta para esa pregunta.";
            }
        }

        // Enviar respuesta como JSON
        response.getWriter().write("{\"respuesta\":\"" + respuesta + "\"}");
    }
}