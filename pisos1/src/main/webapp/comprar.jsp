<%@ page import="java.util.*, com.productos.datos.*, java.sql.*, com.productos.seguridad.*" %>
<%@ page session="true" %>
<%
    // Obtener carrito actual de la sesión o crear uno nuevo
    List<Map<String, Object>> carrito = (List<Map<String, Object>>) session.getAttribute("carrito");
    if (carrito == null) {
        carrito = new ArrayList<>();
        session.setAttribute("carrito", carrito);
    }

    String idProducto = request.getParameter("id_pr");
    String cantidadStr = request.getParameter("cantidad");
    int cantidad = (cantidadStr != null && !cantidadStr.isEmpty()) ? Integer.parseInt(cantidadStr) : 1;

    if (idProducto != null) {
        Conexion con = new Conexion();
        ResultSet rs = con.Consulta("SELECT * FROM tb_producto WHERE id_pr = " + idProducto);
        if (rs.next()) {
            Map<String, Object> producto = new HashMap<>();
            producto.put("id_pr", rs.getInt("id_pr"));
            producto.put("nombre", rs.getString("nombre_pr"));
            producto.put("precio", rs.getDouble("precio_pr"));
            producto.put("cantidad", cantidad);

            boolean existe = false;
            for (Map<String, Object> p : carrito) {
                if (p.get("id_pr") != null && p.get("id_pr").equals(producto.get("id_pr"))) {
                    int cantidadActual = (int) p.get("cantidad");
                    int nuevaCantidad = cantidadActual + cantidad;

                    int stockDisponible = rs.getInt("cantidad_pr");
                    if (nuevaCantidad <= stockDisponible) {
                        p.put("cantidad", nuevaCantidad);
                        existe = true;
                    } else {
                        out.println("<p>No hay suficiente stock para agregar más unidades de: " + producto.get("nombre") + "</p>");
                    }
                    break;
                }
            }
            if (!existe) {
                carrito.add(producto);
            }
        }
        rs.close();
    }

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
    <title>Comprar Productos | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header class="bg-dark text-white text-center p-4">
        <a href="index.jsp"><img src="imagenes/jacko.jpg" alt="Logo" width="80"></a>
        <h1 class="mt-2">H&M Toque Final</h1>
        <p>Estilo y calidad en pisos y acabados</p>
        <h4 class="mt-3">Bienvenido <%= usuario %></h4>
        <a href="carrito.jsp" class="position-absolute top-0 end-0 m-3">
            <img src="iconos/carrito.png" alt="Carrito" style="width: 40px;">
        </a>
    </header>

    <nav class="bg-secondary text-white p-2">
        <ul class="nav justify-content-center">
            <li class="nav-item"><a class="nav-link text-white" href="menu.jsp">Regresar</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="cerrarSesion.jsp">Cerrar Sesión</a></li>
        </ul>
    </nav>

    <main class="container my-5">
        <h2 class="mb-4">Productos disponibles</h2>
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Agregar</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Conexion con = new Conexion();
                    ResultSet rs = con.Consulta("SELECT * FROM tb_producto");
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id_pr") %></td>
                    <td><%= rs.getString("nombre_pr") %></td>
                    <td>$<%= String.format("%.2f", rs.getDouble("precio_pr")) %></td>
                    <td>
                        <form action="comprar.jsp" method="get" class="d-flex align-items-center">
                            <input type="number" name="cantidad" value="1" min="1" max="<%= rs.getInt("cantidad_pr") %>" class="form-control me-2" style="width: 80px;">
                            <input type="hidden" name="id_pr" value="<%= rs.getInt("id_pr") %>">
                            <input type="submit" value="Agregar" class="btn btn-primary btn-sm">
                        </form>
                    </td>
                </tr>
                <% } rs.close(); %>
            </tbody>
        </table>
    </main>

    <footer class="text-center p-3 bg-light">
        <p>Síguenos en nuestras redes sociales</p>
        <div class="social mb-2">
            <a href="https://www.facebook.com/"><img src="iconos/facebook.png" alt="Facebook" width="30"></a>
            <a href="https://www.instagram.com/"><img src="iconos/instagram.png" alt="Instagram" width="30"></a>
            <a href="https://www.tiktok.com/"><img src="iconos/tiktok.png" alt="TikTok" width="30"></a>
        </div>
        <p>&copy; 2025 H&M Toque Final - Todos los derechos reservados.</p>
    </footer>
</body>
</html>
