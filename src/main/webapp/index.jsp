<%-- 
    Document   : index.jsp
    Created on : 2/10/2025, 11:31:42 a. m.
    Author     : Spiri
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page session="true"%>



<%
    
    String usuario = (session != null) ? (String) session.getAttribute("usuario") : null;
    
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<p> Bienvenido: <%= session.getAttribute("nombreActivo") %></p> 

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard - SymphonySIAS</title>
               
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/adminlte/css/adminlte.min.css">
        <link rel="stylesheet" href="assets/adminlte/css/estilos.css">
        
        <style>  
        /* === CONTENEDOR DEL CHATBOT (oculto inicialmente) === */
        .chat-container {
          position: fixed;
          bottom: 90px;
          right: 20px;
          width: 100%;
          max-width: 380px;
          height: 500px;
          background: #fff;
          border-radius: 12px;
          box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
          display: flex;
          flex-direction: column;
          opacity: 0;
          pointer-events: none;
          transform: translateY(20px);
          transition: opacity 0.3s ease, transform 0.3s ease;
          overflow: hidden;
          z-index: 9999;
        }

        /* Cuando está activo se muestra con animación */
        .chat-container.active {
          opacity: 1;
          pointer-events: auto;
          transform: translateY(0);
        }

        /* === CABECERA DEL CHATBOT === */
        .chat-header {
          background: #007bff;
          color: #fff;
          padding: 12px;
          text-align: center;
          font-size: 16px;
          font-weight: bold;
          position: relative;
        }

        /* Botón para cerrar el chat */
        .close-btn {
          position: absolute;
          right: 12px;
          top: 12px;
          background: transparent;
          border: none;
          color: #fff;
          font-size: 18px;
          cursor: pointer;
        }

        /* === ÁREA DE MENSAJES === */
        .messages {
          flex: 1;
          padding: 12px;
          overflow-y: auto;
          background: #f4f4f4;
        }

        .message {
          margin: 8px 0;
          padding: 10px;
          border-radius: 10px;
          max-width: 75%;
          font-size: 14px;
          line-height: 1.4;
        }

        .user {
          background-color: #d1e7ff;
          align-self: flex-end;
          margin-left: auto;
        }

        .bot {
          background-color: #e9ecef;
          align-self: flex-start;
          margin-right: auto;
        }

        /* === ÁREA DE INPUT === */
        .input-area {
          display: flex;
          border-top: 1px solid #ccc;
          background: #fff;
        }

        .input-area input {
          flex: 1;
          padding: 12px;
          border: none;
          outline: none;
          font-size: 14px;
        }

        .input-area button {
          padding: 12px 16px;
          background: #007bff;
          color: white;
          border: none;
          cursor: pointer;
          transition: background 0.3s;
        }

        .input-area button:hover {
          background: #0056b3;
        }

        /* === ACCESIBILIDAD Y RESPONSIVIDAD === */
        @media (max-width: 480px) {
          .chat-container {
            right: 10px;
            left: 10px;
            height: 70vh; /* altura dinámica para móviles */
          }
        }
        </style>
        
        <style>
            body {
                margin: 0;
                padding: 0;
                min-height: 100vh;
                background-image: url("public/imagen/pexels-jplenio-1103970.jpg");
                background-size: cover; 
                background-position: center;
                background-repeat: no-repeat;
                backdrop-filter: blur(<%= (usuario != null) ? "0px" : "6px" %>);
                overflow-x: hidden;
            }
            .login-container {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                display: <%= (usuario != null) ? "none" : "flex" %>;
                background-color: rgba(255, 255, 255, 0.95);
                border-radius: 12px;
                box-shadow: 0 0 20px rgba(0,0,0,0.3);
                padding: 30px;
                width: 500px;
                max-width: 90%;
                z-index: 10; <%--Garantiza el login este por encima del fondo y del dashboard--%>
            }
            .login-logo {
                width: 100px;
                margin-right: 20px;
            }
            .login-form {
                flex: 1;
            }
            
            .dashboard {
                opacity: <%= (usuario != null) ? "1" : "0.4" %>; 
                pointer-events: <%= (usuario != null) ? "auto" : "none" %>;
                transition: opacity 0.5s ease;
                padding: 20px;
                position: relative;
                z-index: 1; <%--Garantiza que el dashboard quede por debajo del formulario de login--%>
            }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">
        <div class="wrapper">
            <%-- Navbar --%>
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <form action="LogoutServlet" method="post" style="margin:0;">
                            <button class="btn btn-danger btn-sm">Cerrar sesión</button>
                        </form>
                    </li>
                </ul>
            </nav>
            
            <%-- Sidebar --%>
            <aside class="main-sidebar sidebar-dark-primary elevation-4">
                <a href="#" class="brand-link">
                    <span class="brand-text font-weight-light">SymphonySIAS</span>
                </a>
                <div class="sidebar">
                    <nav class="mt-2">
                        <ul class="nav nav-pills nav-sidebar flex-column" role="menu">
                            <li class="nav-item">
                                <a href="UsuarioServlet" class="nav-link">
                                    <i class="nav-icon fas fa-users"></i>
                                    <p>Gestion de Usuarios</p>
                                </a>                                
                            </li>
                            <li class="nav-item">
                                <a href="ReporteServlet" class="nav-link">
                                    <i class="nav-icon fas fa-chart-bar"></i>
                                    <p>Resportes Institucionales</p>
                                </a>                                
                            </li>
                            <li class="nav-item">
                                <a href="ChatbotServlet" class="nav-link">
                                    <i class="nav-icon fas fa-robot"></i>
                                    <p>Chatbot SymphonySIAS</p>
                                </a>                                
                            </li>
                        </ul>
                    </nav>
                </div>
            </aside>
        
            <%-- Content --%>
            <div class="content-wrapper">
                <div class="content-header">
                    <div class="container-fluid">
                        <h1 class="m-0">Bienvenido, <%= usuario %></h1>
                    </div>
                </div>
                <div class="content">
                    <div class="container-fluid">
                        <p>Selecciona un módulo desde el menú lateral</p>
                    </div>
                </div>
            </div>
        </div>
            
        <%-- Chatbot embebido --%>
        
        <!-- BURBUJA FLOTANTE -->
        <button class="chat-bubble" id="chatToggle" aria-label="Abrir chat con el bot">💬</button>

        <!-- CONTENEDOR PRINCIPAL DEL CHAT -->
        <div class="chat-container" id="chatContainer" role="dialog" aria-modal="true" aria-labelledby="chatTitle">
        <!-- CABECERA -->
        <div class="chat-header">
            <span id="chatTitle">Chat SYMPHONY-BOT</span>
            <button class="close-btn" id="closeChat" aria-label="Cerrar chat">✖</button>
        </div>

        <!-- ÁREA DE MENSAJES -->
        <div class="messages" id="messages" role="log" aria-live="polite"></div>

        <!-- ÁREA DE INPUT -->
        <div class="input-area">
            <input type="text" id="userInput" aria-label="Escribe tu mensaje" placeholder="Escribe tu pregunta..." />
            <button id="sendBtn">Enviar</button>
        </div>
        </div>

        <script>
        // === REFERENCIAS A ELEMENTOS DEL DOM ===
        const chatToggle = document.getElementById("chatToggle");
        const chatContainer = document.getElementById("chatContainer");
        const closeChat = document.getElementById("closeChat");
        const messages = document.getElementById("messages");
        const userInput = document.getElementById("userInput");
        const sendBtn = document.getElementById("sendBtn");

        /* === FUNCIÓN: agregar mensaje al área === */
        function addMessage(text, sender) {
            const div = document.createElement("div");
            div.classList.add("message", sender);
            div.textContent = text;
            messages.appendChild(div);
            messages.scrollTop = messages.scrollHeight; // siempre baja al último mensaje
        }

        /* === RESPUESTAS SIMPLES DEL BOT === */
        function botResponse(input) {
            const pregunta = input.toLowerCase();
            if (pregunta.includes("hola")) {
                return "Hola soy ChatBot SYMPHONY, me encanta ayudarte a resolver tus melodiosas preguntas frecuentes, sobre el proyecto de música SYMPHONY-SIAS de la escuela La Gran Sinfonía.";
            }
            else if (pregunta.includes("objetivo")) {
                return "El objetivo del proyecto es desarrollar habilidades en programación y tecnología.";
            } else if (pregunta.includes("tecnologias")) {
                return "Estamos usando JavaScript como base del chatbot, pero también se aplica en Python.";
            } else if (pregunta.includes("integracion")) {
                return "La integración consiste en combinar el chatbot con tu proyecto formativo.";
            } else if (pregunta.includes("salir")) {
                return "Gracias por conversar conmigo. ¡Éxitos en tu proyecto! 👋";
            } else if (pregunta.includes("instrumentos")) {
                return "Tú puedes aprender a tocar Piano, Guitarra Eléctrica, Guitarra Acústica, Batería, Violín, Trompeta, Saxofón, Tiple.";
            } else if (pregunta.includes("cursos")) {
                return "Tenemos los curso de Preparatorio 1, Preparatorio 2, Básico 1, Básico 2, Básico 3, Básico 4";
            } else if (pregunta.includes("valor")) {
                return "El valor del semestre es de $ 3.850.000 COP y si gustas cursar con Armonía Aplicada $ 5.000.000 COP.";
            } else if (pregunta.includes("forma")) {
                return "Para tú comodidad puedes pagar en efectivo en nuestras oficinas, pago eléctronico con Daviplata, Nequi, PayPal.";
            } else {
                return "Lo siento, aún no tengo respuesta para esa pregunta.";
            }
        }

        /* === FUNCIÓN: enviar mensaje del usuario === */
        function sendMessage() {
            const text = userInput.value.trim();
            if (!text) return;

            addMessage(text, "user"); // añade mensaje de usuario
            userInput.value = ""; // limpia input

            // pequeña pausa para simular procesamiento
            const respuesta = botResponse(text);
            setTimeout(() => addMessage(respuesta, "bot"), 400);
        }

        /* === EVENTOS === */

        // Abrir / cerrar chatbot al hacer clic en la burbuja
        chatToggle.addEventListener("click", () => {
            chatContainer.classList.toggle("active");
            if (chatContainer.classList.contains("active")) {
                userInput.focus();
            }
        });


        // Cerrar chatbot y limpiar historial de mensajes
        closeChat.addEventListener("click", () => {
            chatContainer.classList.remove("active");
            messages.innerHTML = ""; // limpia mensajes automáticamente
        });

        // Botón enviar
        sendBtn.addEventListener("click", sendMessage);

        // Enviar con tecla Enter
        userInput.addEventListener("keypress", (e) => {
            if (e.key === "Enter") sendMessage();
        });
        /*************************************************************************
        * Inicialización: añadir mensaje de bienvenida (opcional)
        *************************************************************************/
        (function init() {
            // Mensaje inicial del bot para orientar al aprendiz
            addMessage('Hola — soy el asistente del proyecto de música SYMPHONY. Puedes preguntar por Qué instrumento tocar?, Qué cursos hay?, Valor del curso. o Formas de pago. ');
            })();
        </script>
                   
        <script src="assets/adminlte/plugins/jquery/jquery.min.js"></script>
        <script src="assets/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/adminlte/dist/js/adminlte.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>
