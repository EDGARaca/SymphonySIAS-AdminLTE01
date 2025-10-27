/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycom.symphonysias.adminlte01;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author Spiri
 */

public class SessionFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {}
    
    @Override
    public void destroy() {}
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request; // ← este cast es obligatorio
        HttpSession session = req.getSession(false);

        String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
        String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

        if (usuario == null || rol == null) {
            ((HttpServletResponse) response).sendRedirect("login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
