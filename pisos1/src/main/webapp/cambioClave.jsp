<%@ page import="java.sql.*, com.productos.datos.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");

    String correo = request.getParameter("correo_us");
    String nuevaClave1 = request.getParameter("clave_nueva1");
    String nuevaClave2 = request.getParameter("clave_nueva2");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cambio de Clave | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header style="background-color: #2c3e50; color: white; padding: 20px; text-align: center;">
        <a href="index.jsp"><img src="imagenes/jacko.jpg" alt="Logo" class="logo" style="width: 80px;"></a>
        <h1>H&M Toque Final</h1>
        <p>Estilo y calidad en pisos y acabados</p>
    </header>

    <main class="container mt-5">
        <div class="card p-4">
<%
    if (correo == null || nuevaClave1 == null || nuevaClave2 == null ||
        correo.isEmpty() || nuevaClave1.isEmpty() || nuevaClave2.isEmpty()) {
%>
            <div class="alert alert-warning">Todos los campos son obligatorios.</div>
            <a href="formularioCambioClave.jsp" class="btn btn-secondary">Continuar</a>
<%
    } else if (!nuevaClave1.equals(nuevaClave2)) {
%>
            <div class="alert alert-danger">Las contraseñas no coinciden. Intenta nuevamente.</div>
            <a href="formularioCambioClave.jsp" class="btn btn-secondary">Continuar</a>
<%
    } else {
        Conexion con = new Conexion();
        ResultSet rs = con.Consulta("SELECT * FROM tb_usuario WHERE correo_us = '" + correo + "'");
        if (!rs.next()) {
%>
            <div class="alert alert-danger">El correo no está registrado.</div>
            <a href="formularioCambioClave.jsp" class="btn btn-secondary">Continuar</a>
<%
        } else {
            String sql = "UPDATE tb_usuario SET clave_us = ? WHERE correo_us = ?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setString(1, nuevaClave1);
            ps.setString(2, correo);

            int filas = ps.executeUpdate();
            ps.close();

            if (filas > 0) {
%>
                <div class="alert alert-success">Contraseña actualizada exitosamente.</div>
                <a href="index.jsp" class="btn btn-success">Iniciar sesión</a>
<%
            } else {
%>
                <div class="alert alert-danger">Error al actualizar la contraseña.</div>
                <a href="formularioCambioClave.jsp" class="btn btn-secondary">Continuar</a>
<%
            }
        }
    }
%>
        </div>
    </main>

    <footer class="text-center mt-5 p-3 bg-light">
        <p>Síguenos en nuestras redes sociales</p>
        <div class="social">
            <a href="https://www.facebook.com/"><img src="iconos/facebook.png" alt="Facebook" width="30"></a>
            <a href="https://www.instagram.com/"><img src="iconos/instagram.png" alt="Instagram" width="30"></a>
            <a href="https://www.tiktok.com/"><img src="iconos/tiktok.png" alt="TikTok" width="30"></a>
        </div>
        <p class="mt-2">&copy; 2025 H&M Toque Final - Todos los derechos reservados.</p>
    </footer>
</body>
</html>
