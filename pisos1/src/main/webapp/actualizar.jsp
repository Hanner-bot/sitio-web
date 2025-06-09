<%@ page import="java.sql.*, com.productos.negocio.*, com.productos.datos.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String id = request.getParameter("id");
    product pr = new product();
    Connection con = new Conexion().getConexion();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM tb_producto WHERE id_pr = ?");
    ps.setInt(1, Integer.parseInt(id));
    ResultSet rs = ps.executeQuery();
    rs.next();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Actualizar Producto | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header style="background-color: #2c3e50; color: white; padding: 20px; text-align: center;">
        <a href="index.jsp"><img alt="Logo" src="imagenes/jacko.jpg" class="logo" style="width: 80px;"></a>
        <h1 style="margin: 10px 0;">H&M Toque Final</h1>
        <p>Estilo y calidad en pisos y acabados</p>
    </header>

    <nav class="bg-dark text-white p-2">
        <ul class="nav justify-content-center">
            <li class="nav-item"><a class="nav-link text-white" href="menu.jsp">Regresar</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="cerrarSesion.jsp">Cerrar Sesión</a></li>
        </ul>
    </nav>

    <main class="container mt-5">
        <h2>Actualizar Producto</h2>
        <form action="productoCRUD.jsp" method="post">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="id" value="<%= rs.getInt("id_pr") %>">

            <div class="mb-3">
                <label class="form-label">Nombre:</label>
                <input type="text" class="form-control" name="nombre" value="<%= rs.getString("nombre_pr") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Categoría:</label>
                <select class="form-select" name="cmbCategoria">
                    <%
                        categoria cat = new categoria();
                        ResultSet rsCat = con.createStatement().executeQuery("SELECT * FROM tb_categoria");
                        while (rsCat.next()) {
                            int catId = rsCat.getInt(1);
                            String selected = (catId == rs.getInt("id_cat")) ? "selected" : "";
                            out.print("<option value='" + catId + "' " + selected + ">" + rsCat.getString(2) + "</option>");
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Cantidad:</label>
                <input type="number" class="form-control" name="cantidad" value="<%= rs.getInt("cantidad_pr") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Precio:</label>
                <input type="text" class="form-control" name="precio" value="<%= rs.getDouble("precio_pr") %>" required>
            </div>

            <div class="mb-3">
                <button type="submit" class="btn btn-success me-2">Actualizar</button>
                <a href="productos.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
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
