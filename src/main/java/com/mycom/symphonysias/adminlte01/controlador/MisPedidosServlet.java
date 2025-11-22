/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.PedidoDAO;
import com.mycom.symphonysias.adminlte01.modelo.Pedido;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class MisPedidosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String usuario = (session != null) ? (String) session.getAttribute("usuario") : null;

        if (usuario == null || usuario.trim().isEmpty()) {
            System.out.println("[MisPedidosServlet] Usuario no encontrado en sesión. Redirigiendo a login.");
            response.sendRedirect("login.jsp");
            return;
        }

        // Normalizar usuario para evitar inconsistencias con la BD
        usuario = usuario.trim().toLowerCase();
        System.out.println("[MisPedidosServlet] Consultando pedidos para usuario=" + usuario);

        PedidoDAO dao = new PedidoDAO();
        List<Pedido> pedidos = dao.obtenerPedidosPorUsuario(usuario);

        if (pedidos == null || pedidos.isEmpty()) {
            System.out.println("[MisPedidosServlet] No se encontraron pedidos para usuario=" + usuario);
        } else {
            System.out.println("[MisPedidosServlet] Pedidos encontrados=" + pedidos.size());
            for (Pedido p : pedidos) {
                System.out.println("[MisPedidosServlet] Pedido #" + p.getIdPedido() +
                        " total=" + p.getTotal() + " estado=" + p.getEstado());
            }
        }

        request.setAttribute("pedidos", pedidos);
        request.getRequestDispatcher("misPedidos.jsp").forward(request, response);
    }
}