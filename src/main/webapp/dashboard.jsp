<%-- 
    Document   : dashboard
    Created on : 1/10/2025, 8:04:14 p. m.
    Author     : Spiri
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="base" value="/SymphonySIAS-AdminLTE01-1.0-SNAPSHOT" />

<%@ include file="/componentes/roles.jspf" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Dashboard SymphonySIAS</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <%-- Estilos de AdminLTE --%>
  <link rel="stylesheet" href="${base}/assets/adminlte/css/bootstrap.min.css">
  <link rel="stylesheet" href="${base}/assets/adminlte/plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="${base}/assets/adminlte/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <%-- Header y Sidebar --%>
    <jsp:include page="/componentes/header.jsp" />
    <jsp:include page="/componentes/sidebar.jsp" />

    <%-- Contenedor principal --%>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row align-items-center mb-3">
                    <!-- Imagen del logo institucional -->
                    <div class="col-12 col-md-6 text-center mb-2">
                        <img src="${base}/assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" style="max-height:220px;">
                    </div>
                    <!-- Imagen representativa -->
                    <div class="col-12 col-md-6 text-center mb-2">
                        <img src="${base}/assets/adminlte/img/banda5.jpg" alt="Fotografía institucional" style="max-height:300px; border-radius:8px;">
                    </div>
                </div>

                <!-- Mensaje institucional -->
                <div class="text-center mb-4 px-3">
                    <h5 class="text-primary text-wrap">
                        <i class="fas fa-music"></i> ¡Somos una Escuela de Música que te ayuda a impulsar tu desarrollo musical!
                    </h5>
                </div>

                <!-- Información de bienvenida -->
                <h5 class="m-0">Bienvenido, <strong>${sessionScope.nombreActivo}</strong> (<strong>${sessionScope.rol}</strong>)</h5>
                <p class="text-muted">Sistema de información estudiantil SymphonySIAS</p>

                <!-- Mensaje condicional para el rol de administrador -->
                <c:if test="${'administrador'.equals(sessionScope.rol)}">
                    <div class="alert alert-info mt-2">
                        <i class="fas fa-user-shield"></i> Acceso completo como <strong>Administrador</strong>. Puedes gestionar usuarios, clases, contenidos y reportes.
                    </div>
                </c:if>
            </div>
        </section>
        
        <section class="content">
            <div class="row mb-4">
              <div class="col-md-6 text-center">
                <img src="${base}/assets/img/logoSymphonySIAS.png" alt="Logo SymphonySIAS" style="max-width: 80%; height: auto;" />
              </div>
              <div class="col-md-6 text-center">
                <img src="${base}/assets/img/groupMusic.jpg" alt="Grupo musical" class="rounded" style="max-width: 80%; height: auto;" />
              </div>
            </div>
        </section>
        

        <%-- Contenido principal: módulos en tarjetas dinámicas según roles --%>
        <section class="content">
          <div class="container-fluid">
            <div class="row">
            
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>

              <%-- Tarjeta: Gestión Estudiantes --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-success">
                  <div class="card-header">Gestión Estudiantes</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${canGestionEstudiantes}">
                        <a href="estudiantes.jsp" class="btn btn-success btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>

              <%-- Tarjeta: Gestión Profesores --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-info">
                  <div class="card-header">Gestión Profesores</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${canGestionProfesores}">
                        <a href="profesores.jsp" class="btn btn-info btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>

              <%-- Tarjeta: Gestión Cursos Libres --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-warning">
                  <div class="card-header">Gestión Cursos Libres</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${canCursosLibres}">
                        <a href="cursoLibre.jsp" class="btn btn-warning btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>

              <%-- Tarjeta: Gestión de Notas --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-danger">
                  <div class="card-header">Gestión de Notas</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${canNotas}">
                        <a href="notas.jsp" class="btn btn-danger btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
              
              <%-- Tarjeta: Administrador SIAS --%>
              <div class="col-lg-3 col-md-4 mb-3">
                <div class="card card-outline card-primary">
                  <div class="card-header">Administrador SIAS</div>
                  <div class="card-body">
                    <c:choose>
                      <c:when test="${isAdmin}">
                        <a href="AdministradorSIAS.jsp" class="btn btn-primary btn-block">Acceder</a>
                      </c:when>
                      <c:otherwise>
                        <button class="btn btn-secondary btn-block" disabled>No disponible</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>










              <%-- Otros módulos y tarjetas dinámicas según roles... --%>

            </div> <!-- /.row -->
          </div> <!-- /.container -->
        </section>
    </div> <!-- /.content-wrapper -->

    <%-- Footer --%>
    <jsp:include page="/componentes/footer.jsp" />
</div>

<script src="${base}/assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="${base}/assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${base}/assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>