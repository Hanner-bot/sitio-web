<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, com.productos.negocio.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Productos | H&M Toque Final</title>
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
        <h2>Registrar Producto</h2>
        <form method="post" action="productoCRUD.jsp">
            <input type="hidden" name="accion" value="insertar">

            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del producto</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required placeholder="Ej. Porcelanato Gris">
            </div>

            <div class="mb-3">
                <label class="form-label">Categoría</label>
                <%
                    categoria cat = new categoria();
                    String categoriaSeleccionada = request.getParameter("cmbCategoria");
                %>
                <%= cat.mostrarCategoria() %>
            </div>

            <div class="mb-3">
                <label for="cantidad" class="form-label">Cantidad</label>
                <input type="number" class="form-control" name="cantidad_pr" required>
            </div>

            <div class="mb-3">
                <label for="precio" class="form-label">Precio</label>
                <input type="text" class="form-control" id="precio" name="precio" required placeholder="Ej. 29.99">
            </div>

            <div class="mb-3">
                <button type="submit" class="btn btn-success me-2">Guardar</button>
                <button type="reset" class="btn btn-secondary">Limpiar</button>
            </div>
        </form>

        <h3 class="mt-5">Productos Registrados</h3>
        <table class="table table-bordered table-hover mt-3">
            <!-- 
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Producto</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Foto</th>
                    <th>Actualizar</th>
                    <th>Eliminar</th>
                </tr>
            </thead>
             -->
           
            
            <tbody>
                <%
                    product pr = new product();
                    out.print(pr.reporteProducto());
                %>
            </tbody>
        </table>
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
