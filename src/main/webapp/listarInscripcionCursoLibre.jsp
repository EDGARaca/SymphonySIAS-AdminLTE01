<%-- 
    Document   : listarInscripcionCursoLibre
    Created on : 2/11/2025, 5:38:12 p. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.mycom.symphonysias.adminlte01.modelo.InscripcionCursoLibre,com.mycom.symphonysias.adminlte01.modelo.Estudiante" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Inscripciones a Cursos Libres</title>
</head>
<body>
    <h2>Listado de Inscripciones</h2>
    <button onclick="document.getElementById('modalInscripcion').style.display='block'">Nueva Inscripción</button>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Estudiante</th>
            <th>ID Curso</th>
            <th>Fecha</th>
            <th>Estado Pago</th>
            <th>Registrado por</th>
        </tr>
        <c:forEach var="i" items="${listaInscripciones}">
            <tr>
                <td>${i.id}</td>
                <td>
                    <c:forEach var="e" items="${listaEstudiantes}">
                        <c:if test="${e.id == i.idEstudiante}">
                            ${e.nombre} ${e.apellido}
                        </c:if>
                    </c:forEach>
                </td>
                <td>${i.idCursoLibre}</td>
                <td>${i.fechaInscripcion}</td>
                <td>${i.estadoPago}</td>
                <td>${i.usuarioRegistro}</td>
            </tr>
        </c:forEach>
    </table>

    <%@ include file="modalInscripcionCursoLibre.jsp" %>
</body>
</html>