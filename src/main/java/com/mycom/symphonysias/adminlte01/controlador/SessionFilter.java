/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.controlador;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización opcional
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();

        System.out.println("[FILTER] URI=" + uri);
        if (session != null) {
            System.out.println("[FILTER] usuario=" + session.getAttribute("usuario"));
            System.out.println("[FILTER] rolActivo=" + session.getAttribute("rolActivo"));
        } else {
            System.out.println("[FILTER] Sesión nula");
        }


        // Validar atributos de sesión estándar
        String usuario = (session != null) ? (String) session.getAttribute("usuario") : null;
        String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

        if (usuario == null || rol == null) {
            // No hay sesión → redirigir al login
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Si hay sesión válida, continuar
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Limpieza opcional
    }
}