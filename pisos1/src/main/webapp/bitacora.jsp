<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.productos.seguridad.*, com.productos.datos.*, java.sql.*, java.util.*" session="true"%>
<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("usuario") == null) {
%>
    <jsp:forward page="login.jsp">
        <jsp:param name="error" value="Debe iniciar sesión." />
    </jsp:forward>
<%
    }

    String usuario = (String) sesion.getAttribute("usuario");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    pagina pag = new pagina();
    String menuHTML = pag.mostrarMenu(perfil);

    Conexion conexion = new Conexion();
    ResultSet rs = null;
    List<String[]> registros = new ArrayList<>();

    try {
        String query = "SELECT * FROM auditoria.tb_auditoria ORDER BY fecha_aud DESC";
        rs = conexion.Consulta(query);

        while (rs.next()) {
            String tabla = rs.getString("tabla_aud");
            String operacion = rs.getString("operacion_aud");
            String valorAnterior = rs.getString("valoranterior_aud");
            String valorNuevo = rs.getString("valornuevo_aud");
            java.sql.Date fecha = rs.getDate("fecha_aud");
            String usuarioAud = rs.getString("usuario_aud");

            String fechaStr = (fecha != null) ? fecha.toString() : "Sin fecha";
            registros.add(new String[]{tabla, operacion, valorAnterior, valorNuevo, fechaStr, usuarioAud});
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bitácora | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
        }

        header {
            background-color: #3c3c3c;
            color: white;
            padding: 20px;
            text-align: center;
        }

        header h1 {
            margin: 0;
            font-size: 2em;
        }

        header p {
            margin: 5px 0;
        }

        nav {
            margin-top: 15px;
        }

        main {
            padding: 40px;
            max-width: 1200px;
            margin: auto;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2c3e50;
            color: white;
            text-transform: uppercase;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px 0;
            margin-top: 40px;
        }

        .social img {
            width: 30px;
            margin: 0 10px;
            vertical-align: middle;
        }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                display: none;
            }

            td {
                position: relative;
                padding-left: 50%;
                text-align: left;
            }

            td::before {
                position: absolute;
                top: 12px;
                left: 10px;
                width: 45%;
                white-space: nowrap;
                font-weight: bold;
            }

            td:nth-of-type(1)::before { content: "Tabla"; }
            td:nth-of-type(2)::before { content: "Operación"; }
            td:nth-of-type(3)::before { content: "Valor Anterior"; }
            td:nth-of-type(4)::before { content: "Valor Nuevo"; }
            td:nth-of-type(5)::before { content: "Fecha"; }
            td:nth-of-type(6)::before { content: "Usuario"; }
        }
    </style>
</head>
<body>
    <header>
        <h1>H&M Toque Final</h1>
        <p>Control de auditoría</p>
        <h3>Bienvenido <%= usuario %></h3>
        <nav>
            <%= menuHTML %>
        </nav>
    </header>

    <main>
        <h2>Bitácora del Sistema</h2>
        <table>
            <thead>
                <tr>
                    <th>Tabla</th>
                    <th>Operación</th>
                    <th>Valor Anterior</th>
                    <th>Valor Nuevo</th>
                    <th>Fecha</th>
                    <th>Usuario</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] registro : registros) { %>
                    <tr>
                        <td><%= registro[0] %></td>
                        <td><%= registro[1] %></td>
                        <td><%= registro[2] %></td>
                        <td><%= registro[3] %></td>
                        <td><%= registro[4] %></td>
                        <td><%= registro[5] %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
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
</body>
</html>
