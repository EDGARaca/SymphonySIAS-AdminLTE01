# SymphonySIAS-AdminLTE01

Sistema institucional web desarrollado en NetBeans IDE 17, con interfaz visual basada en AdminLTE 3.2.0, arquitectura modular en JSP/Servlets, y conexión a base de datos real `login_symphony`. El proyecto es académico, no comercial, y se enfoca en trazabilidad, validación incremental y buenas prácticas técnicas.

## 🎯 Objetivo institucional

Desarrollar un sistema web funcional para la gestión institucional, con autenticación segura, control de acceso por rol, trazabilidad técnica y estructura modular reutilizable.

## 🧰 Tecnologías utilizadas

- NetBeans IDE 27
- Apache Tomcat 9.0.109
- Jakarta EE 8 (Servlets y JSP)
- MySQL 8.0 (puerto 33065)
- AdminLTE 3.2.0 (interfaz visual)
- SHA-256 para encriptación de claves
- Git y GitHub para control de versiones

## 🗂️ Estructura del proyecto

SymphonySIAS-AdminLTE01/ ├── web/ │   ├── login.jsp │   ├── dashboard.jsp │   ├── header.jsp │   ├── sidebar.jsp │   ├── footer.jsp │   └── assets/ (AdminLTE) ├── src/ │   ├── modelo/ │   │   └── Usuario.java │   ├── dao/ │   │   └── UsuarioDAO.java │   └── servlet/ │       └── LoginServlet.java ├── WEB-INF/ │   └── web.xml


## 🔐 Módulos funcionales

- Login con validación SHA-256
- Dashboard con sesión activa y trazabilidad
- Control de acceso por rol (`ADMIN`, `USUARIO`)
- Menú lateral dinámico
- Logout seguro
- Modularización en `header.jsp`, `sidebar.jsp`, `footer.jsp`

## 📋 Bitácora técnica (resumen)

- [x] Reinstalación y configuración de Tomcat 9
- [x] Validación de base de datos real con claves encriptadas
- [x] Corrección de errores en `LoginServlet` y `UsuarioDAO`
- [x] Trazabilidad en consola y en vistas JSP
- [x] Modularización inicial del layout
- [x] Primer commit funcional en rama `DevEDGAR`

## 🚀 Cómo ejecutar

1. Clonar el repositorio: bash: git clone https://github.com/tu_usuario/SymphonySIAS-AdminLTE01.git
2. Abrir en NetBeans y configurar Tomcat 
3. Verificar conexión a base de datos login_symphony en puerto 33065
4. Ejecutar el proyecto: http://localhost:8080/SymphonySIAS-AdminLTE01/


📌 Notas
- Proyecto académico
- En desarrollo activo desde la rama DevEDGAR
- Se prioriza trazabilidad, validación incremental y documentación técnica

>>>>>>> 86b33c16fff2a608dbd525d77c0027d85fa3c233
