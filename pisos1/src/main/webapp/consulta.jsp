<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, com.productos.datos.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String rol = (String) session.getAttribute("rol");
    boolean esVendedor = "vendedor".equals(rol);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos | Tienda de Pisos</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        header, footer { background-color: #333; color: white; text-align: center; padding: 1em; }
        nav { background-color: #444; padding: 10px; text-align: center; }
        nav a { color: white; margin: 0 15px; text-decoration: none; }
        nav a:hover { text-decoration: underline; }
        .main-content { padding: 20px; }
        table { width: 90%; margin: auto; border-collapse: collapse; background-color: white; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        th, td { padding: 12px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #eee; }
        .acciones form { display: inline-block; margin: 5px; }
        .acciones input[type="submit"] {
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .acciones input[type="submit"]:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>

<header>
    <h1>Tienda de Pisos Flotantes</h1>
    <p>Catálogo de productos</p>
</header>

<nav>
    <a href="index.jsp">Inicio</a>
    <% if (rol == null) { %>
        <a href="login.jsp">Iniciar Sesión</a>
    <% } else { %>
        <a href="logout.jsp">Cerrar Sesión</a>
    <% } %>
</nav>

<div class="main-content">
    <h2 style="text-align:center;">Lista de Productos</h2>

    <%
        ResultSet rs = null;
        try {
            Conexion con = new Conexion();
            String sql = "SELECT id_pr, nombre_pr, cantidad_pr, precio_pr FROM tb_producto;";
            rs = con.Consulta(sql);
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Cantidad</th>
            <th>Precio</th>
            <% if (rol != null) { %><th>Acciones</th><% } %>
        </tr>

        <%
            while (rs != null && rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id_pr") %></td>
            <td><%= rs.getString("nombre_pr") %></td>
            <td><%= rs.getInt("cantidad_pr") %></td>
            <td>$<%= rs.getDouble("precio_pr") %></td>
            <% if (rol != null) { %>
            <td class="acciones">
                <% int id = rs.getInt("id_pr"); %>
                <% if (esVendedor) { %>
                    <form action="modificarProducto.jsp" method="get">
                        <input type="hidden" name="id" value="<%= id %>">
                        <input type="submit" value="Modificar">
                    </form>
                    <form action="eliminarProducto.jsp" method="post" onsubmit="return confirm('¿Seguro que deseas eliminar este producto?');">
                        <input type="hidden" name="id" value="<%= id %>">
                        <input type="submit" value="Eliminar">
                    </form>
                <% } else { %>
                    <form action="comprarProducto.jsp" method="get">
                        <input type="hidden" name="id" value="<%= id %>">
                        <input type="submit" value="Comprar">
                    </form>
                <% } %>
            </td>
            <% } %>
        </tr>
        <%
            }
        %>
    </table>

    <%
        } catch (Exception e) {
            out.println("<p style='color:red; text-align:center;'>Error al mostrar productos: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
        }
    %>
</div>

<footer>
    <p>&copy; 2025 Tienda de Pisos Flotantes. Todos los derechos reservados.</p>
</footer>
</body>
</html>
