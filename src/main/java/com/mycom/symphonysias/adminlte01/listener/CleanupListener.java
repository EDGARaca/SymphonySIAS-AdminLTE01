/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.mycom.symphonysias.adminlte01.util.Conexion;

public class CleanupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // No se requiere inicialización
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        Conexion.cerrarHilosMySQL();
    }
}
