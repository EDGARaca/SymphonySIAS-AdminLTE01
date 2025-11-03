<%-- 
    Document   : editarInscripcionCursoLibre
    Created on : 2/11/2025, 9:24:25 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mycom.symphonysias.adminlte01.modelo.InscripcionCursoLibre, com.mycom.symphonysias.adminlte01.modelo.Estudiante" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>


<%
    InscripcionCursoLibre insc = (InscripcionCursoLibre) request.getAttribute("inscripcion");
    List<Estudiante> listaEstudiantes = (List<Estudiante>) request.getAttribute("listaEstudiantes");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Inscripción</title>
</head>
<body>
    <h2>Editar Inscripción</h2>
    <form action="EditarInscripcionCursoLibreServlet" method="post">
        <input type="hidden" name="id" value="${insc.id}" />

        <label>Estudiante:</label>
        <select name="idEstudiante" required>
            <c:forEach var="e" items="${listaEstudiantes}">
                <option value="${e.id}" <c:if test="${e.id == insc.idEstudiante}">selected</c:if>>
                    ${e.nombre} ${e.apellido}
                </option>
            </c:forEach>
        </select><br>

        <label>ID Curso Libre:</label>
        <input type="number" name="idCursoLibre" value="${insc.idCursoLibre}" required><br>

        <label>Fecha de Inscripción:</label>
        <input type="date" name="fechaInscripcion" value="${insc.fechaInscripcion}" required><br>

        <label>Estado de Pago:</label>
        <select name="estadoPago">
            <option value="pagó" <c:if test="${insc.estadoPago == 'pagó'}">selected</c:if>>Pagó</option>
            <option value="no_pagó" <c:if test="${insc.estadoPago == 'no_pagó'}">selected</c:if>>No pagó</option>
        </select><br>

        <label>Usuario que registra:</label>
        <input type="text" name="usuarioRegistro" value="${insc.usuarioRegistro}" readonly><br>

        <button type="submit">Actualizar</button>
        <a href="ListarInscripcionCursoLibreServlet">Cancelar</a>
    </form>
</body>
</html>