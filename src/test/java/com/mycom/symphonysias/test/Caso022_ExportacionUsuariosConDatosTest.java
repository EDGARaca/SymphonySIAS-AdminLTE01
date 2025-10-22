/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author Spiri
 */


package com.mycom.symphonysias.test;

import com.mycom.symphonysias.adminlte01.dao.UsuarioDAO;
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import org.junit.jupiter.api.Test;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class Caso022_ExportacionUsuariosConDatosTest {

    @Test
    public void testExportacionConDatos() {
        List<Usuario> lista = new UsuarioDAO().listarUsuarios();
        assertNotNull(lista, "La lista de usuarios no debe ser nula");
        assertFalse(lista.isEmpty(), "Se esperaba al menos un usuario registrado para exportar");
        System.out.println("[TEST] Usuarios disponibles para exportación: " + lista.size());
    }
}