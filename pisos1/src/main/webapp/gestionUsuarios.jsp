<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, com.productos.datos.*" %>
<%
    String idUsuarioStr = request.getParameter("id_us");
    if (idUsuarioStr == null) {
        response.sendRedirect("usuarios.jsp"); // Redirige si no hay ID
        return;
    }

    int idUsuario = Integer.parseInt(idUsuarioStr);
    Conexion con = new Conexion();
    ResultSet rs = con.Consulta("SELECT * FROM tb_usuario WHERE id_us = " + idUsuario);

    String nombre = "", cedula = "", correo = "", clave = "";
    int perfil = 0, estadoCivil = 0;

    if (rs != null && rs.next()) {
        nombre = rs.getString("nombre_us");
        cedula = rs.getString("cedula_us");
        correo = rs.getString("correo_us");
        clave = rs.getString("clave_us");
        perfil = rs.getInt("id_per");
        estadoCivil = rs.getInt("id_est");
    } else {
%>
    <p>Usuario no encontrado.</p>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<header id="main-header">
    <h1>H&M Toque Final</h1>
    <p>Administración de usuarios</p>
    <button id="toggle-theme">Cambiar Tema</button>
</header>

<section id="banner">
    <h1>Editar Usuario</h1>
</section>

<main style="padding: 40px;">
    <form action="actualizarUsuario.jsp" method="post" onsubmit="return validarClave();">
        <input type="hidden" name="id_us" value="<%= idUsuario %>">

        <label>Nombre completo:</label><br>
        <input type="text" name="nombre_us" value="<%= nombre %>" required><br><br>

        <label>Cédula:</label><br>
        <input type="text" name="cedula_us" value="<%= cedula %>" required><br><br>

        <label>Correo electrónico:</label><br>
        <input type="email" name="correo_us" value="<%= correo %>" required><br><br>

        <label>Contraseña:</label><br>
        <input type="password" id="clave" name="txtClave" value="<%= clave %>" required>
        <input type="checkbox" id="mostrarClave" onclick="togglePassword()"> Mostrar clave<br><br>

        <label>Perfil:</label><br>
        <select name="id_per" required>
            <option value="1" <%= perfil == 1 ? "selected" : "" %>>Administrador</option>
            <option value="2" <%= perfil == 2 ? "selected" : "" %>>Cliente</option>
            <option value="3" <%= perfil == 3 ? "selected" : "" %>>Vendedor</option>
        </select><br><br>

        <label>Estado civil:</label><br>
        <select name="id_est" required>
            <option value="1" <%= estadoCivil == 1 ? "selected" : "" %>>Casado</option>
            <option value="2" <%= estadoCivil == 2 ? "selected" : "" %>>Soltero</option>
            <option value="3" <%= estadoCivil == 3 ? "selected" : "" %>>Divorciado</option>
            <option value="4" <%= estadoCivil == 4 ? "selected" : "" %>>Viudo</option>
        </select><br><br>

        <input type="submit" value="Actualizar Usuario" class="btn-login">
        <a href="usuarios.jsp" class="btn-cancelar">Cancelar</a>
    </form>
</main>

<footer>
    <p>Síguenos en nuestras redes sociales</p>
    <div class="social">
        <a href="https://www.facebook.com/"><img src="iconos/facebook.png" alt="Facebook"></a>
        <a href="https://www.instagram.com/"><img src="iconos/instagram.png" alt="Instagram"></a>
        <a href="https://www.tiktok.com/"><img src="iconos/tiktok.png" alt="TikTok"></a>
    </div>
    <p>&copy; 2025 H&M Toque Final - Todos los derechos reservados.</p>
</footer>

<script>
    function togglePassword() {
        var passwordField = document.getElementById("clave");
        var showPassword = document.getElementById("mostrarClave");
        passwordField.type = showPassword.checked ? "text" : "password";
    }

    function validarClave() {
        var clave = document.getElementById("clave").value;
        if (clave.length < 8) {
            alert("La clave debe tener al menos 8 caracteres.");
            return false;
        }
        return true;
    }

    const toggleBtn = document.getElementById("toggle-theme");
    toggleBtn.addEventListener("click", () => {
        document.body.classList.toggle("light-mode");
        toggleBtn.textContent = document.body.classList.contains("light-mode") ? "Modo Oscuro" : "Modo Claro";
    });
</script>

</body>
</html>
