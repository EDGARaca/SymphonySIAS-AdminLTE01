/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/*
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.dao;

import com.mycom.symphonysias.adminlte01.modelo.CursoLibre;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO (Data Access Object) para CursoLibre.
 * Operaciones CRUD + métodos alias para compatibilidad con Servlets existentes.
 * ISO/IEC 25010:
 * - Mantenibilidad: métodos claros, nombres consistentes, comentarios.
 * - Confiabilidad: try-with-resources, PreparedStatement, manejo de errores.
 * - Trazabilidad: logs en puntos críticos.
 */
public class CursoLibreDAO {

    /**
     * Conexión JDBC local.
     * Si usas DataSource/JNDI de Tomcat, reemplaza por tu clase centralizada (p.ej. ConexionDB.getConnection()).
     */
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/login_symphony?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
        String user = "root";         // AJUSTAR
        String pass = "tu_password";  // AJUSTAR
        return DriverManager.getConnection(url, user, pass);
    }

    /**
     * Mapea ResultSet → CursoLibre. Centraliza el mapeo para evitar duplicación.
     */
    private CursoLibre map(ResultSet rs) throws SQLException {
        CursoLibre c = new CursoLibre();
        c.setId(rs.getInt("id"));
        c.setNombre(rs.getString("nombre"));
        c.setValor(rs.getDouble("valor"));
        c.setDuracionMeses(rs.getInt("duracion_meses"));
        c.setFrecuencia(rs.getString("frecuencia"));
        c.setEstado(rs.getString("estado"));
        c.setIdUsuarioRegistro(rs.getInt("id_usuario_registro"));
        c.setIdProfesor(rs.getInt("id_profesor"));

        Timestamp created = rs.getTimestamp("created_at");
        Timestamp updated = rs.getTimestamp("updated_at");
        c.setCreatedAt(created != null ? created.toLocalDateTime() : null);
        c.setUpdatedAt(updated != null ? updated.toLocalDateTime() : null);
        return c;
    }

    // =========================
    // Lectura (Read)
    // =========================

    /** Listar todos los cursos (ordenados por creación) */
    public List<CursoLibre> listar() {
        String sql = "SELECT * FROM curso_libre ORDER BY created_at DESC";
        List<CursoLibre> lista = new ArrayList<>();
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(map(rs));
        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] listar() error: " + ex.getMessage());
        }
        return lista;
    }

    /** Listar activos (estado='activo') */
    public List<CursoLibre> listarActivos() {
        String sql = "SELECT * FROM curso_libre WHERE estado='activo' ORDER BY created_at DESC";
        List<CursoLibre> lista = new ArrayList<>();
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(map(rs));
        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] listarActivos() error: " + ex.getMessage());
        }
        return lista;
    }

    /** Listar por profesor asignado */
    public List<CursoLibre> listarPorProfesor(int idProfesor) {
        String sql = "SELECT * FROM curso_libre WHERE id_profesor=? ORDER BY created_at DESC";
        List<CursoLibre> lista = new ArrayList<>();
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idProfesor);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(map(rs));
            }
        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] listarPorProfesor() error: " + ex.getMessage());
        }
        return lista;
    }

    /** Buscar por ID (PK) */
    public CursoLibre findById(int id) {
        String sql = "SELECT * FROM curso_libre WHERE id=?";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] findById() error: " + ex.getMessage());
        }
        return null;
    }

    /**
     * Búsqueda con filtros opcionales por nombre, frecuencia y estado.
     * Compatible con FiltrarCursoLibreServlet (buscarCursos(String, String, String)).
     */
    public List<CursoLibre> buscarCursos(String nombre, String frecuencia, String estado) {
        StringBuilder sb = new StringBuilder("SELECT * FROM curso_libre WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (nombre != null && !nombre.isBlank()) {
            sb.append("AND nombre LIKE ? ");
            params.add("%" + nombre.trim() + "%");
        }
        if (frecuencia != null && !frecuencia.isBlank()) {
            sb.append("AND frecuencia = ? ");
            params.add(frecuencia.trim());
        }
        if (estado != null && !estado.isBlank()) {
            sb.append("AND estado = ? ");
            params.add(estado.trim());
        }
        sb.append("ORDER BY created_at DESC");

        List<CursoLibre> lista = new ArrayList<>();
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sb.toString())) {

            // Bind dinámico
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(map(rs));
            }

        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] buscarCursos() error: " + ex.getMessage());
        }
        return lista;
    }

    // =========================
    // Escritura (Create/Update/Delete)
    // =========================

    /** Insertar nuevo curso libre (nombre+profesor UNIQUE) */
    public boolean registrar(CursoLibre c) {
        String sql = "INSERT INTO curso_libre " +
                "(nombre, valor, duracion_meses, frecuencia, estado, id_usuario_registro, id_profesor) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, c.getNombre());
            ps.setDouble(2, c.getValor());
            ps.setInt(3, c.getDuracionMeses());
            ps.setString(4, c.getFrecuencia());
            ps.setString(5, c.getEstado() != null ? c.getEstado() : "activo");
            ps.setInt(6, c.getIdUsuarioRegistro());
            ps.setInt(7, c.getIdProfesor());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) c.setId(keys.getInt(1));
                }
            }
            System.out.println("[CursoLibreDAO] registrar() OK: id=" + c.getId());
            return rows > 0;

        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] registrar() error: " + ex.getMessage());
            return false;
        }
    }

    /** Actualizar curso (sin tocar usuario_registro) */
    public boolean editar(CursoLibre c) {
        String sql = "UPDATE curso_libre SET " +
                "nombre=?, valor=?, duracion_meses=?, frecuencia=?, estado=?, id_profesor=? " +
                "WHERE id=?";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.setDouble(2, c.getValor());
            ps.setInt(3, c.getDuracionMeses());
            ps.setString(4, c.getFrecuencia());
            ps.setString(5, c.getEstado());
            ps.setInt(6, c.getIdProfesor());
            ps.setInt(7, c.getId());

            int rows = ps.executeUpdate();
            System.out.println("[CursoLibreDAO] editar() filas=" + rows);
            return rows > 0;

        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] editar() error: " + ex.getMessage());
            return false;
        }
    }

    /** Eliminación lógica: estado='inactivo' (recomendado) */
    public boolean eliminar(int id) {
        String sql = "UPDATE curso_libre SET estado='inactivo' WHERE id=?";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            System.out.println("[CursoLibreDAO] eliminar(logico) filas=" + rows);
            return rows > 0;
        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] eliminar() error: " + ex.getMessage());
            return false;
        }
    }

    /** Eliminación física (usar con precaución) */
    public boolean eliminarFisico(int id) {
        String sql = "DELETE FROM curso_libre WHERE id=?";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            System.out.println("[CursoLibreDAO] eliminarFisico() filas=" + rows);
            return rows > 0;
        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] eliminarFisico() error: " + ex.getMessage());
            return false;
        }
    }

    /** Actualiza el estado del curso (p.ej. 'activo' → 'inactivo' o viceversa) */
    public boolean actualizarEstado(int id, String nuevoEstado) {
        String sql = "UPDATE curso_libre SET estado=? WHERE id=?";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            int rows = ps.executeUpdate();
            System.out.println("[CursoLibreDAO] actualizarEstado() filas=" + rows + " estado=" + nuevoEstado);
            return rows > 0;
        } catch (SQLException ex) {
            System.err.println("[CursoLibreDAO] actualizarEstado() error: " + ex.getMessage());
            return false;
        }
    }

    // =========================
    // Métodos alias (retrocompatibilidad con Servlets existentes)
    // =========================

    /** Alias: listarCursos() → delega en listar() */
    public List<CursoLibre> listarCursos() { return listar(); }

    /** Alias: listarCursosPorProfesor(int) → delega en listarPorProfesor(int) */
    public List<CursoLibre> listarCursosPorProfesor(int idProfesor) { return listarPorProfesor(idProfesor); }

    /** Alias: insertar(CursoLibre) → delega en registrar(CursoLibre) */
    public boolean insertar(CursoLibre c) { return registrar(c); }

    /** Alias: actualizar(CursoLibre) → delega en editar(CursoLibre) */
    public boolean actualizar(CursoLibre c) { return editar(c); }
}