<%-- 
    Document   : registroCursoLibre
    Created on : 30/10/2025, 5:31:21 p. m.
    Author     : Spiri
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="com.mycom.symphonysias.adminlte01.modelo.Profesor"%>
<%@page import="com.mycom.symphonysias.adminlte01.dao.ProfesorDAO"%>

<%
    ProfesorDAO profesorDAO = new ProfesorDAO();
    List<Profesor> profesores = profesorDAO.listar();
%>

<select name="id_profesor" class="form-control" required>
    <option value="">Seleccione un profesor</option>
    <% for (Profesor p : profesores) { %>
        <option value="<%= p.getId() %>"><%= p.getNombre() %></option>
    <% } %> 
    
</select>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SymphonySIAS | Registro Curso Libre</title>
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 40px 0;
            overflow-x: hidden;
        }

        .container-fluid {
            padding-left: 40px;
            padding-right: 40px;
        }

        .form-box {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px 60px;
            border-radius: 12px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: auto;
        }

        h5 {
            font-size: 1.4rem;
            font-weight: 600;
            color: #007bff;
            margin-top: 20px;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 6px;
            color: #343a40;
        }

        .form-control {
            font-size: 1rem;
            padding: 10px 14px;
            border-radius: 8px;
            border: 1px solid #ced4da;
        }

        .mb-3 {
            margin-bottom: 1rem !important;
        }

        .btn-block {
            font-size: 1rem;
            padding: 12px;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            border: none;
        }

        .btn-block:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="form-box">
            <div class="text-center">
                <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" class="img-fluid" style="height:80px;">
                <h5><i class="fas fa-music"></i> Registro de Curso Libre</h5>
            </div>

            <form action="RegistroCursoLibreServlet" method="post" accept-charset="UTF-8">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="nombre">Nombre del curso</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="valor">Valor mensual</label>
                        <input type="number" name="valor" id="valor" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="frecuencia">Frecuencia</label>
                        <select name="frecuencia" id="frecuencia" class="form-control" required>
                            <option value="semanal">Semanal</option>
                            <option value="mensual">Mensual</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="usuario_registro">Usuario que registra</label>
                        <input type="text" name="usuario_registro" id="usuario_registro" class="form-control" value="<%= session.getAttribute("usuarioActivo") %>" readonly>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label" for="id_profesor">Profesor asignado</label>
                        <select name="id_profesor" id="id_profesor" class="form-control" required>
                            <option value="">Seleccione un profesor</option>
                            <%
                                for (com.mycom.symphonysias.adminlte01.modelo.Profesor p : profesores) {
                            %>
                                <option value="<%= p.getId() %>"><%= p.getNombre() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-block">Guardar curso</button>
                    <a href="listarCursoLibre.jsp" class="btn btn-secondary mt-3">
                        <i class="fas fa-arrow-left"></i> Cancelar y volver al listado
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>