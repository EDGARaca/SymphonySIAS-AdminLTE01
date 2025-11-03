<%-- 
    Document   : modalInscripcionCursoLibre
    Created on : 2/11/2025, 5:39:04 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="modalInscripcion" style="display:none;">
    <form action="RegistrarInscripcionCursoLibreServlet" method="post">
        <h3>Registrar Inscripción</h3>
        <label>Estudiante:</label>
        <select name="idEstudiante" required>
            <c:forEach var="e" items="${listaEstudiantes}">
                <option value="${e.id}">${e.nombre} ${e.apellido}</option>
            </c:forEach>
        </select><br>

        <label>ID Curso Libre:</label>
        <input type="number" name="idCursoLibre" required><br>

        <label>Fecha de Inscripción:</label>
        <input type="date" name="fechaInscripcion" required><br>

        <label>Estado de Pago:</label>
        <select name="estadoPago">
            <option value="pagó">Pagó</option>
            <option value="no_pagó">No pagó</option>
        </select><br>

        <label>Usuario que registra:</label>
        <input type="text" name="usuario_registro" value="${sessionScope.usuarioLogueado.usuario}" readonly><br>

        <button type="submit">Registrar</button>
        <button type="button" onclick="document.getElementById('modalInscripcion').style.display='none'">Cancelar</button>
    </form>
</div>

