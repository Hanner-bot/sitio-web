<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" import="com.productos.seguridad.* , java.util.*" %>
<%
    HttpSession sesion = request.getSession();

    if (sesion.getAttribute("usuario") == null) {
%>
    <jsp:forward page="sesion.jsp">
        <jsp:param name="error" value="Debe iniciar sesión primero." />
    </jsp:forward>
<%
    } else {
        String nombreUsuario = (String) sesion.getAttribute("usuario");
        Integer perfil = (Integer) sesion.getAttribute("perfil");

        pagina pag = new pagina();
        String menuHTML = pag.mostrarMenu(perfil);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="ISO-8859-1">
    <title>Menú Principal - H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
    <style>
        .logo {
            width: 100px;
            height: auto;
            margin-top: 10px;
        }
        .usuario-info {
            background-color: #f4f4f4;
            margin: 30px auto;
            max-width: 600px;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .usuario-info h2 {
            margin-top: 0;
        }
        .btn-sesion {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn-sesion:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <header id="main-header">
        <img src="imagenes/jacko.jpg" alt="Logo H&M" class="logo">
        <h1>H&M Toque Final</h1>
        <p>Bienvenido, <strong><%= nombreUsuario %></strong></p>
        <p>Especialistas en acabados para el hogar</p>
    </header>

    <nav>
        <%= menuHTML %>
    </nav>

    <div class="usuario-info">
        <h2>Datos de tu sesión</h2>
        <%
            Date creacion = new Date(sesion.getCreationTime());
            Date ultimoAcceso = new Date(sesion.getLastAccessedTime());
            String idSesion = sesion.getId();
        %>
        <p><strong>ID de sesión:</strong> <%= idSesion %></p>
        <p><strong>Creación:</strong> <%= creacion %></p>
        <p><strong>Último acceso:</strong> <%= ultimoAcceso %></p>
        <a class="btn-sesion" href="cerrarSesion.jsp">Cerrar Sesión</a>
    </div>

    <footer>
    <p>&copy; 2025 H&M Toque Final - Todos los derechos reservados.</p>
    <p>Síguenos en nuestras redes sociales</p>
    <ul class="redes-sociales">
        <li><a href="https://www.facebook.com/"><img src="iconos/facebook.png" alt="Facebook"></a></li>
        <li><a href="https://www.instagram.com/"><img src="iconos/instagram.png" alt="Instagram"></a></li>
        <li><a href="https://www.tiktok.com/"><img src="iconos/tiktok.png" alt="TikTok"></a></li>
    </ul>
</footer>


</body>
</html>
<%
    }
%>
