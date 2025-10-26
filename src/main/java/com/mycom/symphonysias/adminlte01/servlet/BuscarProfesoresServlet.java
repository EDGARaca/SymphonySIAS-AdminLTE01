/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

public class BuscarProfesoresServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String criterio = request.getParameter("criterio");
        String tipoFiltro = request.getParameter("tipoFiltro");

        System.out.println("[BUSCAR PROFESORES] Filtro: " + tipoFiltro + " | Criterio: " + criterio);

        ArrayList<String[]> resultados = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:33065/login_symphony", "root", "");

            String sql = "";
            switch (tipoFiltro) {
                case "nombre":
                    sql = "SELECT nombre, apellido, documento, estado FROM profesores WHERE nombre LIKE ?";
                    break;
                case "apellido":
                    sql = "SELECT nombre, apellido, documento, estado FROM profesores WHERE apellido LIKE ?";
                    break;
                case "documento":
                    sql = "SELECT nombre, apellido, documento, estado FROM profesores WHERE documento LIKE ?";
                    break;
                case "estado":
                    sql = "SELECT nombre, apellido, documento, estado FROM profesores WHERE estado LIKE ?";
                    break;
                default:
                    throw new IllegalArgumentException("Filtro no válido");
            }

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + criterio + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String[] fila = new String[4];
                fila[0] = rs.getString("nombre");
                fila[1] = rs.getString("apellido");
                fila[2] = rs.getString("documento");
                fila[3] = rs.getString("estado");
                resultados.add(fila);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("[ERROR] " + e.getMessage());
        }

        request.setAttribute("resultados", resultados);
        request.getRequestDispatcher("buscarProfesores.jsp").forward(request, response);
    }
}
