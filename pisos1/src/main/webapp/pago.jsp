<%@ page import="java.util.*, java.sql.*" %>
<%@ page session="true" %>
<%
    request.setCharacterEncoding("UTF-8");

    String numero = request.getParameter("numero");
    String titular = request.getParameter("titular");
    String fecha = request.getParameter("fecha");
    String cvv = request.getParameter("cvv");

    String mensaje = "";
    boolean exito = true;

    // Validaciones básicas de tarjeta
    if (numero == null || !numero.matches("\\d{16}")) {
        mensaje += "Número de tarjeta inválido.<br>";
        exito = false;
    }
    if (titular == null || titular.trim().length() < 5) {
        mensaje += "Nombre del titular inválido.<br>";
        exito = false;
    }
    if (fecha == null || !fecha.matches("(0[1-9]|1[0-2])/\\d{2}")) {
        mensaje += "Fecha de expiración inválida.<br>";
        exito = false;
    }
    if (cvv == null || !cvv.matches("\\d{3,4}")) {
        mensaje += "CVV inválido.<br>";
        exito = false;
    }

    String usuario = (String) session.getAttribute("usuario");
    if (usuario == null) {
        mensaje += "Debe iniciar sesión.<br>";
        exito = false;
    }

    List<Map<String, Object>> carrito = (List<Map<String, Object>>) session.getAttribute("carrito");
    if (carrito == null || carrito.isEmpty()) {
        mensaje += "El carrito está vacío.<br>";
        exito = false;
    }

    double total = 0;
    StringBuilder detallesTexto = new StringBuilder();

    if (carrito != null) {
        for (Map<String, Object> producto : carrito) {
            Integer cantidad = (Integer) producto.get("cantidad");
            Double precio = (Double) producto.get("precio");
            String nombre = (String) producto.get("nombre");
            if (cantidad != null && precio != null && nombre != null) {
                double subtotal = precio * cantidad;
                total += subtotal;
                detallesTexto.append(nombre)
                    .append(" x ")
                    .append(cantidad)
                    .append(" - $")
                    .append(String.format("%.2f", subtotal))
                    .append("\n");
            }
        }
    }

    if (exito) {
        Connection conn = null;
        PreparedStatement pst = null;
        PreparedStatement pstUpdate = null;
        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/pisos";
            String userDB = "postgres";
            String passDB = "1234";
            conn = DriverManager.getConnection(url, userDB, passDB);

            // Desactivar auto-commit para manejar la transacción
            conn.setAutoCommit(false);

            // Insertar venta
            String sql = "INSERT INTO tb_ventas (usuario, total, tarjeta, detalles) VALUES (?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setString(1, usuario);
            pst.setDouble(2, total);
            pst.setString(3, numero.substring(12)); // últimos 4 dígitos
            pst.setString(4, detallesTexto.toString());

            int filas = pst.executeUpdate();
            pst.close();

            if (filas > 0) {
                // Actualizar inventario
                String sqlUpdate = "UPDATE tb_producto SET cantidad_pr = cantidad_pr - ? WHERE id_pr = ?";
                for (Map<String, Object> producto : carrito) {
                    Integer cantidadComprada = (Integer) producto.get("cantidad");
                    Integer idProducto = (Integer) producto.get("id_pr");
                    if (cantidadComprada != null && idProducto != null) {
                        pstUpdate = conn.prepareStatement(sqlUpdate);
                        pstUpdate.setInt(1, cantidadComprada);
                        pstUpdate.setInt(2, idProducto);
                        pstUpdate.executeUpdate();
                        pstUpdate.close();
                    }
                }
                // Confirmar transacción
                conn.commit();
                // Limpiar carrito
                session.removeAttribute("carrito");
            } else {
                mensaje = "Error al guardar la venta.";
                exito = false;
                conn.rollback();
            }

        } catch (Exception e) {
            mensaje = "Error en la base de datos: " + e.getMessage();
            exito = false;
            try { if (conn != null) conn.rollback(); } catch(Exception ex) {}
        } finally {
            try { if (pst != null) pst.close(); } catch(Exception e) {}
            try { if (pstUpdate != null) pstUpdate.close(); } catch(Exception e) {}
            try { if (conn != null) conn.close(); } catch(Exception e) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= exito ? "Pago Exitoso" : "Error en el Pago" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
<%
    if (exito) {
%>
    <div class="alert alert-success">
        <h3>¡Compra realizada con éxito!</h3>
        <p>Gracias por tu compra, <%= usuario %>. Recibirás un correo de confirmación.</p>
        <a href="menu.jsp" class="btn btn-primary">Volver al Menú</a>
    </div>
<%
    } else {
%>
    <div class="alert alert-danger">
        <h3>Error en la compra</h3>
        <p><%= mensaje %></p>
        <a href="carrito.jsp" class="btn btn-warning">Volver al Carrito</a>
    </div>
<%
    }
%>
</body>
</html>
