<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.productos.negocio.*, java.io.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>H&M Toque Final | Buscar por Categoría</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<!-- HEADER PRINCIPAL -->
<header id="main-header">
    <h1>H&M Toque Final</h1>
    <p>Encuentra el estilo perfecto para tus espacios</p>
    <img src="imagenes/jacko.jpg" alt="Logo de H&M" width="300" height="300">
</header>

<!-- NAVEGACIÓN -->
<nav>
    <ul>
        <li><a href="sesion.jsp">Iniciar sesión</a></li>
        <li><a href="registro.jsp">Registro</a></li>
        <li><a href="index.jsp">Inicio</a></li>
        <li><a href="consulta.jsp">Ver Productos</a></li>
    </ul>
</nav>

<!-- BANNER -->
<section id="banner">
    <h1>Consulta por Categoría de Pisos</h1>
    <p>Elige una categoría para ver los productos disponibles.</p>
</section>

<!-- CONTENIDO PRINCIPAL -->
<main id="productos">
    <div style="width: 100%; max-width: 800px; margin: auto;">
        <%
            categoria cat = new categoria();
            product prod = new product();
            String categoriaSeleccionada = request.getParameter("cmbCategoria");
        %>

        <!-- FORMULARIO DE CATEGORÍA -->
        <form method="get" action="categoria.jsp">
            <label for="cmbCategoria"><strong>Seleccione una categoría:</strong></label><br><br>
            <%= cat.mostrarCategoria() %>
            <br><br>
            <input type="submit" value="Consultar" class="btn-login">
            <button type="button" onclick="document.getElementById('tablaProductos').innerHTML = '';" class="btn-login" style="background-color: #dc3545;">Limpiar</button>
        </form>

        <!-- RESULTADOS -->
        <div id="tablaProductos" style="margin-top: 30px;">
        <% if (categoriaSeleccionada != null) {
            try {
                int idCategoria = Integer.parseInt(categoriaSeleccionada);
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                PrintStream ps = new PrintStream(baos);
                PrintStream originalOut = System.out;
                System.setOut(ps);
                prod.buscarProductoCategoria(idCategoria);
                System.out.flush();
                System.setOut(originalOut);
                String capturedOutput = baos.toString("UTF-8");
        %>
            <h2 style="text-align: center;">Pisos disponibles:</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tipo de Piso</th>
                        <th>Precio por m²</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (capturedOutput != null && !capturedOutput.trim().isEmpty()) {
                        String[] filas = capturedOutput.split("</tr>");
                        for (String fila : filas) {
                            if (!fila.contains("<tr>")) continue;
                            String[] datos = fila.split("</td>");
                            if (datos.length >= 2) {
                                String nombre = datos[0].replaceAll(".*<td>", "").trim();
                                String precio = datos[1].replaceAll(".*<td>", "").trim();
                                if (!nombre.isEmpty() && !precio.isEmpty()) {
                %>
                    <tr>
                        <td><%= nombre %></td>
                        <td>$<%= precio %></td>
                    </tr>
                <%
                                }
                            }
                        }
                    } else {
                %>
                    <tr><td colspan="2">No se encontraron pisos para esta categoría.</td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        <%
            } catch (NumberFormatException e) {
        %>
            <p style="color: red;">ID de categoría no válido.</p>
        <%
            } catch (Exception e) {
        %>
            <p style="color: red;">Error al cargar los productos: <%= e.getMessage() %></p>
        <%
            }
        } %>
        </div>
    </div>
</main>


<!-- FOOTER -->
<footer>
    <p>&copy; 2025 H&M Toque Final | Todos los derechos reservados.</p>
    <p><a href="https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile">Contacto del desarrollador</a></p>
</footer>

<!-- REDES SOCIALES -->
<ul>
    <li><a href="https://www.facebook.com"><img src="iconos/facebook.png" alt="Facebook"></a></li>
    <li><a href="https://www.instagram.com"><img src="iconos/instagram.png" alt="Instagram"></a></li>
    <li><a href="https://www.tiktok.com"><img src="iconos/tiktok.png" alt="TikTok"></a></li>
</ul>

</body>
</html>
