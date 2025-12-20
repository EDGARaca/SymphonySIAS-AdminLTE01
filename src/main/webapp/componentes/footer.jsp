<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String base = request.getContextPath();
%>

<!-- Footer institucional -->
<footer class="bg-primary text-light text-center p-2 mt-2" style="background-color:#00bffd;">
    <div class="container">
        <div class="row">

            <!-- Información institucional -->
            <div class="col-md-4 mb-3">
                <h5 class="text-primary">Escuela "La Gran Sinfonía"</h5>
                <p class="mb-1"><i class="fas fa-map-marker-alt text-secondary"></i> Calle 75 No. 28-53 Bogotá D.C.</p>
                <p class="mb-1"><i class="fas fa-envelope text-secondary"></i> info@symphony.com.co</p>
                <p class="mb-1"><i class="fas fa-phone-alt text-secondary"></i> +057 316-9875571</p>
                <p class="text-muted small mt-2">“¡Somos una Escuela de Música que te ayuda a impulsar tu desarrollo musical!”</p>
            </div>

            <!-- Enlaces rápidos -->
            <div class="col-md-4 mb-3">
                <h5 class="text-primary">Accesos rápidos</h5>
                <ul class="list-unstyled">
                    <li><a href="<c:url value='/vistas/dashboard.jsp'/>" class="text-dark"><i class="fas fa-home"></i> Inicio</a></li>
                    <li><a href="<c:url value='/vistas/contacto.jsp'/>" class="text-dark"><i class="fas fa-envelope-open-text"></i> Contáctanos</a></li>
                    <li><a href="<c:url value='/vistas/privacidad.jsp'/>" class="text-dark"><i class="fas fa-user-shield"></i> Política de privacidad</a></li>
                    <li><a href="<c:url value='/vistas/terminos.jsp'/>" class="text-dark"><i class="fas fa-file-contract"></i> Términos y condiciones</a></li>
                    <li><a href="<c:url value='/vistas/ayuda.jsp'/>" class="text-dark"><i class="fas fa-question-circle"></i> Ayuda</a></li>
                </ul>
            </div>

            <!-- Redes sociales -->
            <div class="col-md-4 mb-3">
                <h5 class="text-warning">Síguenos</h5>
                <div class="d-flex gap-3">
                    <a href="#" class="mx-2 text-light"><i class="fab fa-facebook fa-lg"></i></a>
                    <a href="#" class="mx-2 text-light"><i class="fab fa-instagram fa-lg"></i></a>
                    <a href="#" class="mx-2 text-light"><i class="fab fa-whatsapp fa-lg"></i></a>
                    <a href="#" class="mx-2 text-light"><i class="fab fa-youtube fa-lg"></i></a>
                    <a href="#" class="mx-2 text-light"><i class="fab fa-x-twitter fa-lg"></i></a>
                </div>
            </div>
        </div>

        <hr>
        <div class="text-left small text-muted">
            Copyright © Domain. All Rights Reserved. | Desarrollado por Edgar Ceballos - Ficha 2977514 ADSO | Año: 2025
        </div>
    </div>
</footer>

<!-- Chatbot institucional -->
<jsp:include page="/componentes/chatbot.jspf" />

<!-- Scripts finales -->
<script src="<%= base %>/assets/adminlte/plugins/jquery/jquery.min.js"></script>
<script src="<%= base %>/assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%= base %>/assets/adminlte/js/adminlte.min.js"></script>

<script>
    // Ocultar alertas después de 8 segundos
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            alert.classList.remove('show');
            alert.classList.add('fade');
        });
    }, 8000);
</script>

</body>
</html>