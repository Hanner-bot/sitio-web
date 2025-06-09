<%@ page import="java.util.*, java.sql.*, com.productos.seguridad.*" %>
<%@ page session="true" %>
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
    <title>Carrito de Compras | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header style="background-color: #2c3e50; color: white; padding: 20px; text-align: center;">
        <a href="index.jsp"><img src="imagenes/jacko.jpg" alt="Logo" style="width: 80px;"></a>
        <h1>H&M Toque Final</h1>
        <p>Estilo y calidad en pisos y acabados</p>
        <h4 class="mt-3">Bienvenido <%= usuario %></h4>
    </header>

    <nav class="bg-dark text-white p-2">
        <ul class="nav justify-content-center">
            <li class="nav-item"><a class="nav-link text-white" href="menu.jsp">Regresar</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="cerrarSesion.jsp">Cerrar Sesión</a></li>
        </ul>
    </nav>

    <main class="container mt-5">
        <%
            List<Map<String, Object>> carrito = (List<Map<String, Object>>) session.getAttribute("carrito");

            if (carrito == null || carrito.isEmpty()) {
        %>
            <div class="alert alert-warning">El carrito está vacío.</div>
            <a href="comprar.jsp" class="btn btn-primary">Regresar a la tienda</a>
        <%
                return;
            }

            double total = 0;
        %>

        <h2 class="mb-4">Carrito de Compras</h2>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Subtotal</th>
                    <th>Eliminar</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Map<String, Object> producto : carrito) {
                    Integer cantidad = (Integer) producto.get("cantidad");
                    Double precio = (Double) producto.get("precio");

                    if (cantidad == null || precio == null) continue;

                    double subtotal = precio * cantidad;
                    total += subtotal;
            %>
                <tr>
                    <td><%= producto.get("nombre") %></td>
                    <td>$<%= String.format("%.2f", precio) %></td>
                    <td><%= cantidad %></td>
                    <td>$<%= String.format("%.2f", subtotal) %></td>
                    <td><a href="eliminarCarrito.jsp?id_pr=<%= producto.get("id_pr") %>" class="btn btn-danger btn-sm">Eliminar</a></td>
                </tr>
            <% } %>
                <tr class="table-secondary">
                    <td colspan="3" class="text-end"><strong>Total</strong></td>
                    <td colspan="2"><strong>$<%= String.format("%.2f", total) %></strong></td>
                </tr>
            </tbody>
        </table>

        <!-- Botón que abre el modal -->
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalPago">
            Proceder al Pago
        </button>
        <a href="comprar.jsp" class="btn btn-secondary">Seguir Comprando</a>
    </main>

    <!-- Modal para ingresar tarjeta -->
    <div class="modal fade" id="modalPago" tabindex="-1" aria-labelledby="modalPagoLabel" aria-hidden="true">
      <div class="modal-dialog">
        <form class="modal-content" action="pago.jsp" method="post" onsubmit="return validarPago();">
          <div class="modal-header">
            <h5 class="modal-title" id="modalPagoLabel">Información de Pago</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="numero" class="form-label">Número de Tarjeta</label>
              <input type="text" class="form-control" name="numero" id="numero" maxlength="16" required>
            </div>
            <div class="mb-3">
              <label for="titular" class="form-label">Nombre del Titular</label>
              <input type="text" class="form-control" name="titular" id="titular" required>
            </div>
            <div class="mb-3">
              <label for="fecha" class="form-label">Fecha de Expiración (MM/AA)</label>
              <input type="text" class="form-control" name="fecha" id="fecha" placeholder="MM/AA" required>
            </div>
            <div class="mb-3">
              <label for="cvv" class="form-label">CVV</label>
              <input type="text" class="form-control" name="cvv" id="cvv" maxlength="4" required>
            </div>
          </div>
          <div class="modal-footer">
            <input type="submit" class="btn btn-primary" value="Confirmar Pago">
          </div>
        </form>
      </div>
    </div>

    <footer class="text-center mt-5 p-3 bg-light">
        <p>Síguenos en nuestras redes sociales</p>
        <div class="social">
            <a href="https://www.facebook.com/"><img src="iconos/facebook.png" alt="Facebook" width="30"></a>
            <a href="https://www.instagram.com/"><img src="iconos/instagram.png" alt="Instagram" width="30"></a>
            <a href="https://www.tiktok.com/"><img src="iconos/tiktok.png" alt="TikTok" width="30"></a>
        </div>
        <p class="mt-2">&copy; 2025 H&M Toque Final - Todos los derechos reservados.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function validarPago() {
        const numero = document.getElementById("numero").value.trim();
        const titular = document.getElementById("titular").value.trim();
        const fecha = document.getElementById("fecha").value.trim();
        const cvv = document.getElementById("cvv").value.trim();

        const errores = [];

        if (!/^\d{16}$/.test(numero)) errores.push("Número de tarjeta inválido (deben ser 16 dígitos).");
        if (titular.length < 5) errores.push("Nombre del titular demasiado corto.");
        if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(fecha)) errores.push("Fecha inválida (formato MM/AA).");
        if (!/^\d{3,4}$/.test(cvv)) errores.push("CVV inválido.");

        if (errores.length > 0) {
            alert("Error en el pago:\n" + errores.join("\n"));
            return false;
        }

        return true;
    }
    </script>
</body>
</html>
