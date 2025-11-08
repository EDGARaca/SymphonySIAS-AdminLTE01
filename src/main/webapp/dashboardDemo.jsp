<%-- 
    Document   : dashboardDemo
    Created on : 16/10/2025, 12:19:05 p. m.
    Author     : Spiri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Demo Dashboard - SymphonySIAS</title>
    <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="assets/adminlte/plugins/bootstrap/css/bootstrap.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">

        <!-- Encabezado institucional -->
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row align-items-center mb-3">
                        <div class="col-md-6 text-center mb-2">
                            <img src="assets/adminlte/img/LogoSymphonySIAS.png" alt="Logo SymphonySIAS" style="max-height:220px;">
                        </div>
                        <div class="col-md-6 text-center mb-2">
                            <img src="assets/adminlte/img/banda5.jpg" alt="Fotografía institucional" style="max-height:300px; border-radius:8px;">
                        </div>
                    </div>

                    <div class="text-center mb-4 px-3">
                        <h5 class="text-primary text-wrap">
                            <i class="fas fa-music"></i> Vista demostrativa del sistema institucional SymphonySIAS
                        </h5>
                        <p class="text-muted">Todos los módulos se muestran con etiquetas por rol. Esta vista no requiere sesión activa.</p>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid px-3">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-school"></i> Módulos Institucionales</h3>
                        </div>
                        <div class="card-body">
                            <div class="row text-center">

                                <!-- ADMIN SIAS -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-primary btn-block disabled">
                                        <i class="fas fa-tools"></i> ADMIN SIAS <br><small>(Administrador)</small>
                                    </a>
                                </div>

                                <!-- Gestión Estudiantes -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-success btn-block disabled">
                                        <i class="fas fa-user-graduate"></i> Gestión Estudiantes <br><small>(Director, Coordinador, Aux. Administrativo)</small>
                                    </a>
                                </div>

                                <!-- Gestión Profesores -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-warning btn-block disabled">
                                        <i class="fas fa-chalkboard-teacher"></i> Gestión Profesores <br><small>(Director, Coordinador)</small>
                                    </a>
                                </div>

                                <!-- Auxiliar Contable -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-dark btn-block disabled">
                                        <i class="fas fa-calculator"></i> Auxiliar Contable <br><small>(Aux. Contable)</small>
                                    </a>
                                </div>

                                <!-- Auxiliar Administrativo -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-secondary btn-block disabled">
                                        <i class="fas fa-user-clock"></i> Auxiliar Administrativo <br><small>(Aux. Administrativo)</small>
                                    </a>
                                </div>

                                <!-- Clases y Horarios -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-info btn-block disabled">
                                        <i class="fas fa-calendar-alt"></i> Clases y Horarios <br><small>(Docente, Coordinador, Director)</small>
                                    </a>
                                </div>

                                <!-- Coordinador Académico -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-primary btn-block disabled">
                                        <i class="fas fa-user-cog"></i> Coordinador Académico <br><small>(Coordinador)</small>
                                    </a>
                                </div>

                                <!-- Gestión Director -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-primary btn-block disabled">
                                        <i class="fas fa-user-tie"></i> Gestión Director <br><small>(Director)</small>
                                    </a>
                                </div>

                                <!-- Contenidos -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-success btn-block disabled">
                                        <i class="fas fa-book-reader"></i> Contenidos <br><small>(Estudiante, Docente)</small>
                                    </a>
                                </div>

                                <!-- Horarios -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-info btn-block disabled">
                                        <i class="fas fa-clock"></i> Horarios <br><small>(Estudiante)</small>
                                    </a>
                                </div>

                                <!-- Notificaciones -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-danger btn-block disabled">
                                        <i class="fas fa-bell"></i> Notificaciones <br><small>(Todos los roles)</small>
                                    </a>
                                </div>
                                
                                <!-- Gestión de Notas -->
                                <div class="col-md-3 mb-3">
                                    <a href="#" class="btn btn-outline-success btn-block disabled">
                                        <i class="fas fa-clipboard-list"></i> Gestión de Notas <br><small>(Docente, Estudiante, Coordinador, Director)</small>
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </div>
    </div>

    <!-- Scripts -->
    <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
    <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/adminlte/js/adminlte.min.js"></script>
</body>
</html>