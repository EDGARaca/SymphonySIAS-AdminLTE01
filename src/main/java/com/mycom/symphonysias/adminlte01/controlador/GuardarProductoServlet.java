/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/*
 *
 * @author Spiri
 */

package com.mycom.symphonysias.adminlte01.controlador;

import com.mycom.symphonysias.adminlte01.dao.ProductoMusicalDAO;
import com.mycom.symphonysias.adminlte01.modelo.ProductoMusical;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;

/**
 * GuardarProductoServlet
 * Registra/actualiza productos musicales con soporte de imagen opcional.
 *
 * ISO/IEC 25010:
 * - Confiabilidad: validaciones de sesión/rol y parámetros, manejo de excepciones, coherencia oferta/descuento.
 * - Mantenibilidad: alineación con el modelo/DAO, comentarios claros, responsabilidades separadas.
 * - Trazabilidad: logs consistentes, mensajes de estado y auditoría básica.
 *
 * Notas:
 * - El ID de usuario de sesión debe mapearse a id_usuario_registro (int). Se deja comentario para integración.
 * - La subida de imagen guarda en /assets/adminlte/img y almacena la ruta relativa en imagen_url.
 */
@MultipartConfig
public class GuardarProductoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Directorio público para imágenes dentro del contexto
    private static final String IMG_DIR = "/assets/adminlte/img/";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validación de sesión y rol
        HttpSession session = request.getSession(false);
        String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
        String rol = (session != null) ? (String) session.getAttribute("rol") : null;

        if (usuario == null || rol == null ||
                !(rol.equalsIgnoreCase("ADMIN") || rol.equalsIgnoreCase("DIRECTOR") || rol.equalsIgnoreCase("COORDINADOR"))) {
            System.out.println("[GuardarProductoServlet] Usuario sin permisos intentó guardar producto.");
            response.sendRedirect("adminProductos.jsp?error=permiso");
            return;
        }

        try {
            // Lectura segura de parámetros
            String idStr = trimOrNull(request.getParameter("id"));
            String nombre = trimOrNull(request.getParameter("nombre"));
            String descripcion = trimOrNull(request.getParameter("descripcion"));
            String precioStr = trimOrNull(request.getParameter("precio"));
            String descuentoStr = trimOrNull(request.getParameter("descuento"));
            String stockStr = trimOrNull(request.getParameter("stock"));
            String ofertaStr = trimOrNull(request.getParameter("oferta_activa")); // opcional: “true”/“false”

            if (nombre == null || precioStr == null || stockStr == null) {
                System.out.println("[GuardarProductoServlet] Parámetros requeridos faltantes.");
                response.sendRedirect("adminProductos.jsp?error=parametros");
                return;
            }

            double precio = Double.parseDouble(precioStr);
            double descuento = (descuentoStr != null && !descuentoStr.isEmpty())
                    ? Double.parseDouble(descuentoStr) : 0.0;
            int stock = Integer.parseInt(stockStr);

            // Normalización y validación de rangos
            if (precio < 0 || stock < 0 || descuento < 0 || descuento > 100) {
                System.out.println("[GuardarProductoServlet] Rango inválido (precio/stock/descuento).");
                response.sendRedirect("adminProductos.jsp?error=parametros");
                return;
            }

            boolean ofertaActiva = (ofertaStr != null) ? Boolean.parseBoolean(ofertaStr) : (descuento > 0);

            // Manejo de imagen subida (opcional)
            String imagenUrl = null;
            Part imagenPart = request.getPart("imagen"); // name="imagen" en el form
            if (imagenPart != null && imagenPart.getSize() > 0) {
                String nombreArchivo = sanitizeFileName(imagenPart.getSubmittedFileName());
                if (nombreArchivo != null && !nombreArchivo.isEmpty()) {
                    String realPath = getServletContext().getRealPath(IMG_DIR);
                    Path dir = Paths.get(realPath);
                    if (!Files.exists(dir)) {
                        Files.createDirectories(dir);
                    }
                    Path destino = dir.resolve(nombreArchivo);
                    imagenPart.write(destino.toString());
                    imagenUrl = (IMG_DIR + nombreArchivo).replace("\\", "/");
                }
            }

            // Construcción del modelo alineado
            ProductoMusical producto = new ProductoMusical();
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            producto.setDescuento(descuento);
            producto.setStock(stock);
            producto.setOfertaActiva(ofertaActiva);
            producto.setEstado("activo"); // por defecto
            if (imagenUrl != null) {
                producto.setImagenUrl(imagenUrl);
            }

            // Auditoría: created/updated
            producto.setCreatedAt(LocalDateTime.now());
            producto.setUpdatedAt(LocalDateTime.now());

            // Trazabilidad usuario: AJUSTAR para usar el ID real del usuario logueado
            // Ejemplo: int idUsuario = ((Usuario) session.getAttribute("usuarioObj")).getId();
            int idUsuarioRegistro = 1; // placeholder
            producto.setIdUsuarioRegistro(idUsuarioRegistro);

            ProductoMusicalDAO dao = new ProductoMusicalDAO();

            boolean ok;
            if (idStr != null && !idStr.isEmpty()) {
                // Actualización
                int idProducto = Integer.parseInt(idStr);
                producto.setIdProducto(idProducto);
                ok = dao.actualizar(producto);
                System.out.println("[GuardarProductoServlet] Actualización producto id=" + idProducto + " ok=" + ok);
            } else {
                // Registro
                ok = dao.registrar(producto);
                System.out.println("[GuardarProductoServlet] Registro producto ok=" + ok);
            }

            // Redirección con mensaje de estado
            if (ok) {
                response.sendRedirect("adminProductos.jsp?ok=guardado");
            } else {
                response.sendRedirect("adminProductos.jsp?error=dao");
            }

        } catch (NumberFormatException nfe) {
            System.err.println("[GuardarProductoServlet] Error numérico: " + nfe.getMessage());
            response.sendRedirect("adminProductos.jsp?error=parametros");
        } catch (Exception e) {
            System.err.println("[GuardarProductoServlet] Error general: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }

    // =========================
    // Utilidades privadas
    // =========================

    private String trimOrNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    /**
     * Sanitiza el nombre de archivo para evitar rutas maliciosas y caracteres inválidos.
     */
    private String sanitizeFileName(String fileName) {
        if (fileName == null) return null;
        // Eliminar directorios (IE/Edge antiguos envían ruta completa)
        fileName = fileName.replace("\\", "/");
        int idx = fileName.lastIndexOf('/');
        if (idx >= 0) fileName = fileName.substring(idx + 1);
        // Permitir solo letras, números, puntos, guiones y guion bajo
        return fileName.replaceAll("[^A-Za-z0-9._-]", "_");
    }
}