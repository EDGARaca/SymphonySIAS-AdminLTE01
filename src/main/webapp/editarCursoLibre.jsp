<%-- 
    Document   : editarCursoLibre
    Created on : 31/10/2025, 5:34:39 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO"%>

<%
    // Validación de sesión
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Captura de ID
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("listarCursoLibre.jsp?error=id");
        return;
    }

    int id = Integer.parseInt(idStr);
    CursoLibreDAO dao = new CursoLibreDAO();
    CursoLibre curso = dao.buscarPorId(id);

    if (curso == null) {
        response.sendRedirect("listarCursoLibre.jsp?error=notfound");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Curso Libre</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <jsp:include page="header.jsp" />
    <jsp:include page="sidebar.jsp" />

    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <h4 class="text-primary"><i class="fas fa-edit"></i> Editar Curso Libre</h4>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <form action="RegistroCursoLibreServlet" method="post" class="card p-4">
                    <input type="hidden" name="id" value="<%= curso.getId() %>">
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="usuario_registro" value="<%= usuario %>">

                    <div class="form-group">
                        <label>Nombre del curso</label>
                        <input type="text" name="nombre" class="form-control" value="<%= curso.getNombre() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Valor</label>
                        <input type="number" name="valor" class="form-control" value="<%= curso.getValor() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Frecuencia</label>
                        <select name="frecuencia" class="form-control" required>
                            <option value="mensual" <%= curso.getFrecuencia().equals("mensual") ? "selected" : "" %>>Mensual</option>
                            <option value="quincenal" <%= curso.getFrecuencia().equals("quincenal") ? "selected" : "" %>>Quincenal</option>
                            <option value="semanal" <%= curso.getFrecuencia().equals("semanal") ? "selected" : "" %>>Semanal</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Estado</label>
                        <select name="estado" class="form-control" required>
                            <option value="activo" <%= curso.getEstado().equals("activo") ? "selected" : "" %>>Activo</option>
                            <option value="inactivo" <%= curso.getEstado().equals("inactivo") ? "selected" : "" %>>Inactivo</option>
                        </select>
                    </div>

                    <div class="row mt-4 justify-content-center">
                        <div class="col-auto">
                            <button type="submit" class="btn btn-success px-4">
                                <i class="fas fa-save"></i> Guardar cambios
                            </button>
                        </div>
                        <div class="col-auto">
                            <a href="listarCursoLibre.jsp" class="btn btn-secondary px-4">
                                <i class="fas fa-arrow-left"></i> Cancelar
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </section>

        <jsp:include page="footer.jsp" />
    </div>
</div>

<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>
