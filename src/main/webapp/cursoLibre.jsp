<%-- 
    Document   : cursoLibre
    Created on : 31/10/2025, 10:17:03 p. m.
    Author     : Spiri
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="componentes/roles.jspf" %>
<!--
  cursoLibre.jsp
  Cumple ISO/IEC 25010:
  - Confiabilidad: control de sesión y roles a través de roles.jspf; sin scriptlets.
  - Mantenibilidad: uso de JSTL/EL; comentarios claros; enlaces con contextPath.
  - Trazabilidad: mensajes de estado parametrizados; estructura coherente.
  Integración:
  - NetBeans 27 + JDK 21 + Tomcat 9.0.112
  - Espera que el servlet controlador coloque en request:
      request.setAttribute("resultados", List<CursoLibre>);
  - Atributos de sesión requeridos: sessionScope.usuario, sessionScope.rol (definidos por LoginServlet).
-->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Cursos Libres</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/adminlte/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- Componentes comunes -->
    <jsp:include page="componentes/header.jsp" />
    <jsp:include page="componentes/sidebar.jsp" />

    <div class="content-wrapper">
        <!-- Encabezado -->
        <section class="content-header">
            <div class="container-fluid">
                <h4 class="mb-3 text-success">
                    <i class="fas fa-book-open"></i> Módulo Cursos Libres
                </h4>
                <p class="text-muted">Accede a las funcionalidades del módulo cursos libres según tu rol institucional.</p>
            </div>
        </section>

        <!-- Contenido principal -->
        <section class="content">
            <div class="container-fluid">

                <!-- Acciones principales -->
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <!-- Listar cursos libres: usa contextPath para no romper sesión -->
                        <a href="${pageContext.request.contextPath}/ListarCursoLibreServlet" class="btn btn-outline-success btn-block">
                            <i class="fas fa-list-alt"></i> Listar Cursos Libres
                        </a>
                    </div>

                    <!-- Registrar curso libre: permitido a admin/director/coordinador -->
                    <c:if test="${isAdmin or isDirector or isCoord}">
                        <div class="col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/registroCursoLibre.jsp" class="btn btn-outline-success btn-block">
                                <i class="fas fa-plus-circle"></i> Registrar Curso Libre
                            </a>
                        </div>
                    </c:if>

                    <!-- Exportar PDF: permitido a admin y director -->
                    <c:if test="${isAdmin or isDirector}">
                        <div class="col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/ExportarCursosLibresServlet" class="btn btn-outline-danger btn-block">
                                <i class="fas fa-file-pdf"></i> Exportar PDF
                            </a>
                        </div>
                    </c:if>
                </div>

                <!-- Mensajes de estado (paramétricos) -->
                <c:if test="${param.ok eq 'registrado'}">
                    <div class="alert alert-success text-center">
                        <i class="fas fa-check-circle"></i> Curso registrado correctamente.
                    </div>
                </c:if>
                <c:if test="${param.error eq 'permiso'}">
                    <div class="alert alert-danger text-center">
                        <i class="fas fa-exclamation-triangle"></i> No tienes permisos para registrar cursos.
                    </div>
                </c:if>
                <c:if test="${param.error eq 'parametros'}">
                    <div class="alert alert-warning text-center">
                        <i class="fas fa-exclamation-circle"></i> Parámetros inválidos en el registro.
                    </div>
                </c:if>

                <!-- Formulario de búsqueda -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Buscar cursos libres</h5>
                    </div>
                    <div class="card-body">
                        <!-- Enviar a un servlet de búsqueda que devuelva 'resultados' -->
                        <form class="row g-3" method="get" action="${pageContext.request.contextPath}/BuscarCursoLibreServlet">
                            <div class="col-md-4">
                                <label class="form-label">Nombre del curso</label>
                                <input type="text" name="nombre" class="form-control" maxlength="100" placeholder="Ej: Fundamentos de Música">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Estado</label>
                                <select name="estado" class="form-control">
                                    <option value="">Todos</option>
                                    <option value="activo">Activo</option>
                                    <option value="inactivo">Inactivo</option>
                                </select>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary btn-block">
                                    <i class="fas fa-search"></i> Buscar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Resultados de búsqueda (si el servlet los proporciona) -->
                <c:if test="${not empty requestScope.resultados}">
                    <div class="card mt-3">
                        <div class="card-header bg-info text-white">
                            <h5 class="card-title mb-0">
                                Resultados encontrados: ${fn:length(requestScope.resultados)}
                            </h5>
                        </div>
                        <div class="card-body table-responsive">
                            <c:if test="${fn:length(requestScope.resultados) == 0}">
                                <div class="alert alert-warning text-center">
                                    <i class="fas fa-exclamation-circle"></i> No se encontraron cursos con los filtros aplicados.
                                </div>
                            </c:if>

                            <c:if test="${fn:length(requestScope.resultados) > 0}">
                                <table class="table table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Descripción</th>
                                            <th>Estado</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="c" items="${requestScope.resultados}">
                                            <tr>
                                                <td>${c.id}</td>
                                                <td>${c.nombre}</td>
                                                <td>${c.descripcion}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${c.estado eq 'activo'}">
                                                            <span class="badge badge-success">Activo</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-secondary">Inactivo</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-nowrap">
                                                    <a href="${pageContext.request.contextPath}/VerCursoLibreServlet?id=${c.id}" class="btn btn-sm btn-outline-primary">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${isAdmin or isCoord}">
                                                        <a href="${pageContext.request.contextPath}/EditarCursoLibreServlet?id=${c.id}" class="btn btn-sm btn-outline-warning">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </div>
                    </div>
                </c:if>

            </div> <!-- /.container-fluid -->
        </section>
    </div> <!-- /.content-wrapper -->

    <!-- Footer / scripts -->
    <script src="${pageContext.request.contextPath}/assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/adminlte/js/adminlte.min.js"></script>
</div>
</body>
</html>