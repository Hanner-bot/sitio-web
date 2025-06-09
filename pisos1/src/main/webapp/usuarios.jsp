<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.ResultSet, com.productos.seguridad.*, com.productos.datos.*" session="true"%>
<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("usuario") == null) {
%>
    <jsp:forward page="sesion.jsp">
        <jsp:param name="error" value="Debe iniciar sesión." />
    </jsp:forward>
<%
    }

    String usuario = (String) sesion.getAttribute("usuario");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    pagina pag = new pagina();
    String menuHTML = pag.mostrarMenu(perfil);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<header id="main-header">
    <h1>H&M Toque Final</h1>
    <p>Administración de usuarios del sistema</p>
    <h2>Bienvenido, <%= usuario %></h2>
    <nav><%= menuHTML %></nav>
</header>

<section id="banner">
    <h1>Gestión de Usuarios</h1>
    <p>Administra usuarios registrados en la plataforma</p>
</section>

<main style="padding: 40px;">
    <div id="registroUsuario">
        <h2>Registrar nuevo usuario</h2>
        <form action="registroUsuario.jsp" method="post">
            <label>Nombre completo:</label><br>
            <input type="text" name="nombre_us" required><br><br>

            <label>Cédula:</label><br>
            <input type="text" name="cedula_us" required><br><br>

            <label>Correo electrónico:</label><br>
            <input type="email" name="correo_us" required><br><br>

            <label>Contraseña:</label><br>
            <input type="password" name="clave_us" required><br><br>

            <label>Perfil:</label><br>
            <select name="id_per" required>
                <option value="1">Administrador</option>
                <option value="2">Cliente</option>
                <option value="3">Vendedor</option>
            </select><br><br>

            <label>Estado civil:</label><br>
            <select name="id_est" required>
                <option value="1">Casado</option>
                <option value="2">Soltero</option>
                <option value="3">Divorciado</option>
                <option value="4">Viudo</option>
            </select><br><br>

            <input type="submit" value="Registrar Usuario" class="btn-login">
        </form>
    </div>

    <div id="table" style="margin-top: 50px;">
        <h2>Usuarios Registrados</h2>
        <table border="1" cellpadding="10" cellspacing="0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Cédula</th>
                    <th>Correo</th>
                    <th>Perfil</th>
                    <th>Estado Civil</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Conexion con = new Conexion();
                    String sql = "SELECT * FROM tb_usuario";
                    ResultSet rs = con.Consulta(sql);

                    try {
                        while (rs != null && rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id_us") %></td>
                    <td><%= rs.getString("nombre_us") %></td>
                    <td><%= rs.getString("cedula_us") %></td>
                    <td><%= rs.getString("correo_us") %></td>
                    <td><%= rs.getInt("id_per") %></td>
                    <td><%= rs.getInt("id_est") %></td>
                    <td><%= rs.getInt("estado") == 1 ? "Activo" : "Inactivo" %></td>
                    <td>
                        <!-- Bloquear/Desbloquear -->
                        <form action="bloquearUsuario.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="id_us" value="<%= rs.getInt("id_us") %>">
                            <input type="hidden" name="estado" value="<%= rs.getInt("estado") %>">
                            <button type="submit" title="<%= rs.getInt("estado") == 1 ? "Bloquear" : "Desbloquear" %>">
                                <%= rs.getInt("estado") == 1 ? "🔒" : "🔓" %>
                            </button>
                        </form>

                        <!-- Eliminar -->
                        <form action="eliminarUsuario.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="id_us" value="<%= rs.getInt("id_us") %>">
                            <button type="submit" onclick="return confirm('¿Estás seguro de eliminar este usuario?');" title="Eliminar">
                                <img src="iconos/eliminar.png" alt="Eliminar" style="width: 30px; height: 30px;">
                            </button>
                        </form>

                        <!-- Editar -->
                        <form action="gestionUsuarios.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="id_us" value="<%= rs.getInt("id_us") %>">
                            <button type="submit" title="Editar">
                                <img src="iconos/editar.png" alt="Editar" style="width: 30px; height: 30px;">
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        if (rs != null) rs.close();
                    } catch (Exception ex) {
                        out.println("<tr><td colspan='8'>Error: " + ex.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</main>

    <footer>
        <p>&copy; 2024 Tienda de Piso Flotante | Todos los derechos reservados.</p>
        <p><a href="https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile">Contacta con el desarrollador</a></p>
    </footer>
    	<ul align="center">
    		<li><a href="https://wwww.facebook.com">
    			<img src="iconos/facebook.png" width="60" height="60" alt="imagen facebook"/></a></li>
    		<li><a href="https://wwww.instagram.com">
    			<img src="iconos/instagram.png" width="60" height="60" alt="imagen instagram"/></a></li>
    		<li><a href="https://wwww.tiktok.com">
    			<img src="iconos/tiktok.png" width="60" height="60" alt="imagen tiktok"/></a></li>		
    	</ul>


</body>
</html>
