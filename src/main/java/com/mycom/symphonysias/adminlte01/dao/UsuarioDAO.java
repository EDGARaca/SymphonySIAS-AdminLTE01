/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.util.Conexion;
import com.mycom.symphonysias.adminlte01.modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;
import java.util.ArrayList;

/*
 * DAO para validación de usuarios en SymphonySIAS-AdminLTE01
 * Cumple trazabilidad y consistencia con ISO/IEC 25010
 * @author Spiri
 */
public class UsuarioDAO {
    private static final Logger LOGGER = Logger.getLogger(UsuarioDAO.class.getName());
    private Connection conn;

    public UsuarioDAO() {
        try {
            conn = Conexion.getConexion();
            LOGGER.log(Level.INFO, "[DAO] Conexión establecida correctamente");
        } catch (SQLException e){
            LOGGER.log(Level.SEVERE, "Error al conectar desde UsuarioDAO", e);
        }
    }

    /*
     * Valida credenciales: usuario en texto plano + hash SHA-256
     * IMPORTANTE: la columna en BD es 'clave' (no 'contraseña')
     */
    public Usuario validar(String usuarioPlano, String hashSha256) throws SQLException {
        final String sql =
            "SELECT id, usuario, nombre, rol, activo " +
            "FROM usuarios " +
            "WHERE usuario = ? AND clave = ? " +
            "LIMIT 1";

        try (Connection cx = Conexion.getConexion();
             PreparedStatement ps = cx.prepareStatement(sql)) {

            ps.setString(1, usuarioPlano.trim());
            ps.setString(2, hashSha256.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setNombre(rs.getString("nombre"));
                    u.setRol(rs.getString("rol"));
                    u.setActivo(rs.getBoolean("activo"));
                    LOGGER.log(Level.INFO, "[DAO] Validación exitosa para usuario: {0}", usuarioPlano);
                    return u;
                } else {
                    LOGGER.log(Level.WARNING, "[DAO] Sin coincidencias: usuario/clave no válidos para usuario: {0}", usuarioPlano);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "[DAO] Error en validar credenciales", e);
            throw e;
        }
        return null;
    }

    public boolean existeUsuario(String usuario) {
        final String sql = "SELECT COUNT(*) FROM usuarios WHERE usuario = ?";

        try (Connection cx = Conexion.getConexion();
             PreparedStatement stmt = cx.prepareStatement(sql)) {

            stmt.setString(1, usuario);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "[ERROR DAO] Validación de duplicado fallida", e);
        }

        return false;
    }

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();

        if (conn == null) {
            LOGGER.log(Level.SEVERE, "[DAO] Conexión no disponible en listarUsuarios");
            return lista;
        }

        final String sql = "SELECT id, nombre, usuario, clave, correo, rol, activo FROM usuarios";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setUsuario(rs.getString("usuario"));
                u.setClave(rs.getString("clave"));
                u.setCorreo(rs.getString("correo"));
                u.setRol(rs.getString("rol"));
                u.setActivo(rs.getBoolean("activo"));
                lista.add(u);
            }
        } catch (SQLException e){
            LOGGER.log(Level.SEVERE, "Error al listar usuarios", e);
        }

        LOGGER.log(Level.INFO, "[DAO] Usuarios recuperados: {0}", lista.size());
        return lista;
    }

    public boolean actualizar(Usuario u) {
        boolean resultado = false;
        PreparedStatement ps = null;

        if (conn == null) {
            LOGGER.log(Level.SEVERE, "[DAO] Conexión no disponible en actualizar");
            return false;
        }

        final String sql = "UPDATE usuarios SET nombre = ?, usuario = ?, rol = ?, activo = ? WHERE id = ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getUsuario());
            ps.setString(3, u.getRol());
            ps.setBoolean(4, u.isActivo());
            ps.setInt(5, u.getId());

            int filas = ps.executeUpdate();
            resultado = filas > 0;

            LOGGER.log(Level.INFO, "[DAO] Usuario actualizado. Filas afectadas: {0}", filas);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al actualizar usuario", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error al cerrar PreparedStatement", e);
            }
        }

        return resultado;
    }

    public boolean crear(Usuario u) {
        boolean resultado = false;
        PreparedStatement ps = null;

        if (conn == null) {
            LOGGER.log(Level.SEVERE, "[DAO] Conexión no disponible en crear");
            return false;
        }

        final String sql = "INSERT INTO usuarios (nombre, usuario, clave, correo, rol, activo) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getUsuario());
            ps.setString(3, u.getClave()); // debe venir ya hasheada (SHA-256) desde capa de servicio/servlet
            ps.setString(4, u.getCorreo());
            ps.setString(5, u.getRol());
            ps.setBoolean(6, u.isActivo());

            int filas = ps.executeUpdate();
            resultado = filas > 0;

            LOGGER.log(Level.INFO, "[DAO] Usuario creado. Filas afectadas: {0}", filas);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al crear usuario", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error al cerrar PreparedStatement", e);
            }
        }

        return resultado;
    }

    public boolean eliminarUsuario(String id) {
        boolean eliminado = false;

        final String sql = "DELETE FROM usuarios WHERE id = ?";

        try (Connection cx = Conexion.getConexion();
             PreparedStatement stmt = cx.prepareStatement(sql)) {

            stmt.setString(1, id);
            int filas = stmt.executeUpdate();
            eliminado = filas > 0;

            LOGGER.log(Level.INFO, "[DAO] Usuario eliminado. Filas afectadas: {0}", filas);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "[ERROR] Fallo al eliminar usuario", ex);
        }

        return eliminado;
    }

    public boolean actualizarEstado(int id, boolean estado) {
        boolean actualizado = false;

        if (conn == null) {
            LOGGER.log(Level.SEVERE, "[DAO] Conexión no disponible en actualizarEstado");
            return false;
        }

        final String sql = "UPDATE usuarios SET activo = ? WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, estado);
            ps.setInt(2, id);

            int filas = ps.executeUpdate();
            actualizado = filas > 0;

            LOGGER.log(Level.INFO, "[DAO] Estado actualizado para usuario ID {0}: {1}", new Object[]{id, estado});
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "[ERROR DAO] Fallo al actualizar estado", e);
        }

        return actualizado;
    }

    // Actualiza la clave (hash) por ID de usuario
    public boolean actualizarClave(int id, String nuevoHash) {
        final String sql = "UPDATE usuarios SET clave = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        if (nuevoHash == null || nuevoHash.trim().isEmpty()) {
            LOGGER.warning("[UsuarioDAO] Hash vacío o nulo");
            return false;
        }

        try (Connection cx = Conexion.getConexion();
             PreparedStatement ps = cx.prepareStatement(sql)) {

            ps.setString(1, nuevoHash);
            ps.setInt(2, id);

            int filas = ps.executeUpdate();
            LOGGER.info("[UsuarioDAO] actualizarClave -> filas afectadas: " + filas);
            return filas > 0;

        } catch (SQLException e) {
            LOGGER.severe("[UsuarioDAO] Error al actualizar clave: " + e.getMessage());
            return false;
        }
    }

    // (Opcional) Actualiza la clave por nombre de usuario
    public boolean actualizarClavePorUsuario(String usuario, String nuevoHash) {
        final String sql = "UPDATE usuarios SET clave = ?, updated_at = CURRENT_TIMESTAMP WHERE usuario = ?";

        if (usuario == null || usuario.trim().isEmpty() || nuevoHash == null || nuevoHash.trim().isEmpty()) {
            LOGGER.warning("[UsuarioDAO] usuario/hash inválidos");
            return false;
        }

        try (Connection cx = Conexion.getConexion();
             PreparedStatement ps = cx.prepareStatement(sql)) {

            ps.setString(1, nuevoHash);
            ps.setString(2, usuario);

            int filas = ps.executeUpdate();
            LOGGER.info("[UsuarioDAO] actualizarClavePorUsuario -> filas afectadas: " + filas);
            return filas > 0;

        } catch (SQLException e) {
            LOGGER.severe("[UsuarioDAO] Error al actualizar clave por usuario: " + e.getMessage());
            return false;
        }
    }
}