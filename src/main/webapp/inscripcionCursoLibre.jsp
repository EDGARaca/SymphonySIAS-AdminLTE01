<%-- 
    Document   : inscripcionCursoLibre
    Created on : 4/11/2025, 8:33:55 p. m.
    Author     : Spiri
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Estudiante"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.CursoLibre"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.EstudianteDAO"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.CursoLibreDAO"%>

<%
    String usuario = (session != null) ? (String) session.getAttribute("usuarioActivo") : null;
    String rol = (session != null) ? (String) session.getAttribute("rolActivo") : null;

    if (usuario == null || rol == null ||
        !(rol.equalsIgnoreCase("ADMINISTRADOR SIAS") || rol.equalsIgnoreCase("COORDINADOR ACADÉMICO") || rol.equalsIgnoreCase("DIRECTOR"))) {
        response.sendRedirect("login.jsp?logout=true");
        return;
    }

    EstudianteDAO estudianteDAO = new EstudianteDAO();
    CursoLibreDAO cursoDAO = new CursoLibreDAO();
    List<Estudiante> estudiantes = estudianteDAO.listarEstudiantes();
    List<CursoLibre> cursos = cursoDAO.listarActivos();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inscripción a Curso Libre | SymphonySIAS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="assets/adminlte/css/alt/estilos.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <%-- Encabezado y menú lateral institucional --%>
    <jsp:include page="componentes/header.jsp" />
    <jsp:include page="componentes/sidebar.jsp" />

    <%-- Contenido principal alineado --%>
    <div class="content-wrapper">
        <section class="content pt-4">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-9">
                        <section id="requisitos">
                            <h2>Requisitos</h2>
                            <img src="assets/img/Documentos.png" class="img-fluid mb-2">
                            <p>Solicita y diligencia el formulario de inscripción Escuela "SYMPHONY".</p>
                        </section>

                        <section id="documentos">
                            <h2>Documentos Necesarios</h2>
                            <img src="assets/img/identidad.jpg" class="img-fluid mb-2">
                            <p>Presenta un documento público con tus datos personales.</p>
                        </section>

                        <section id="formulario" class="mt-4">
                            <h2><i class="fas fa-book-open"></i> Formulario de Inscripción</h2>

                            <% String error = request.getParameter("error"); %>
                            <% if ("true".equals(error)) { %>
                                <div class="alert alert-danger mt-3">⚠️ Error: Debes seleccionar estudiante y curso.</div>
                            <% } else if ("duplicado".equals(error)) { %>
                                <div class="alert alert-warning mt-3">⚠️ Ya estás inscrito en este curso.</div>
                            <% } else if ("bd".equals(error)) { %>
                                <div class="alert alert-danger mt-3">⚠️ Error en la base de datos. Intenta nuevamente.</div>
                            <% } else if ("true".equals(request.getParameter("exito"))) { %>
                                <div class="alert alert-success mt-3">✅ Inscripción realizada correctamente.</div>
                            <% } %>

                            <form action="InscripcionCursoLibreServlet" method="post">
                                <div class="form-group mb-3">
                                    <label for="id_estudiante"><i class="fas fa-user-graduate"></i> Estudiante:</label>
                                    <select name="id_estudiante" id="id_estudiante" class="form-control" required>
                                        <option value="" disabled selected>Seleccione un estudiante</option>
                                        <% for (Estudiante e : estudiantes) { %>
                                            <option value="<%= e.getId() %>"><%= e.getNombre() %> - <%= e.getDocumento() %></option>
                                        <% } %>
                                    </select>                   
                                </div>

                                <div class="form-group mb-3">
                                    <label for="id_curso"><i class="fas fa-chalkboard-teacher"></i> Curso Libre:</label>
                                    <select name="id_curso" id="id_curso" class="form-control" required>
                                        <option value="" disabled selected>Seleccione un curso</option>
                                        <% for (CursoLibre c : cursos) { %>
                                            <option value="<%= c.getId() %>"><%= c.getNombre() %> - <%= c.getHorario() %></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-success px-4">Inscribir</button>
                                </div>
                            </form>
                        </section>

                        <section id="contacto" class="mt-4">
                            <h2>Contacto</h2>
                            <img src="assets/img/contactanos.jpg" class="img-fluid mb-2">
                            <p>Celular: 320-9999432 | WhatsApp: 317-6789090</p>
                        </section>
                    </div>

                    <aside class="col-md-3 bg-light p-3">
                        <h2>Fechas Importantes</h2>
                        <img src="assets/img/Fechas.png" class="img-fluid mb-2">
                        <p>Inscripciones: del 03 al 20 de junio de 2025.</p>
                        <img src="assets/img/instrum1.png" class="img-fluid mb-2">
                        <p>Elige tu instrumento musical preferido.</p>
                    </aside>
                </div>
            </div>
        </section>
    </div>

    <%-- Pie de página institucional --%>
    <jsp:include page="componentes/footer.jsp" />
</div>

<!-- Scripts -->
<script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelector("form").addEventListener("submit", function(e) {
        const estudiante = document.getElementById("id_estudiante").value;
        const curso = document.getElementById("id_curso").value;

        if (!estudiante || !curso) {
            alert("⚠️ Debes seleccionar estudiante y curso antes de inscribirte.");
            e.preventDefault();
        }
    });
</script>
</body>
</html>