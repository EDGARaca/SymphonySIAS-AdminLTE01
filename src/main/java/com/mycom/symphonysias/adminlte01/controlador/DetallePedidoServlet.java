/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 *
 * @author Spiri
 */


package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.PedidoDAO;
import com.mycom.symphonysias.adminlte01.modelo.Pedido;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DetallePedidoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            System.out.println("[DetallePedidoServlet] ID de pedido no especificado.");
            request.setAttribute("error", "ID de pedido no especificado");
            request.getRequestDispatcher("misPedidos.jsp").forward(request, response);
            return;
        }

        int idPedido;
        try {
            idPedido = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            System.out.println("[DetallePedidoServlet] ID inválido: " + idParam);
            request.setAttribute("error", "ID de pedido inválido");
            request.getRequestDispatcher("misPedidos.jsp").forward(request, response);
            return;
        }

        System.out.println("[DetallePedidoServlet] Consultando pedido #" + idPedido);

        PedidoDAO dao = new PedidoDAO();
        Pedido pedido = dao.obtenerPedidoPorId(idPedido);

        if (pedido == null) {
            System.out.println("[DetallePedidoServlet] Pedido no encontrado en BD.");
            request.setAttribute("error", "Pedido no encontrado");
            request.getRequestDispatcher("misPedidos.jsp").forward(request, response);
            return;
        }

        if (pedido.getDetalles() == null || pedido.getDetalles().isEmpty()) {
            System.out.println("[DetallePedidoServlet] Pedido #" + idPedido + " sin detalles.");
            request.setAttribute("pedido", pedido);
            request.setAttribute("sinDetalles", true);
        } else {
            System.out.println("[DetallePedidoServlet] Pedido #" + idPedido + " con " + pedido.getDetalles().size() + " detalles.");
            request.setAttribute("pedido", pedido);
        }

        request.getRequestDispatcher("detallePedido.jsp").forward(request, response);
    }
}