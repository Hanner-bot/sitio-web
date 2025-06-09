<%@ page import="java.sql.*, com.productos.datos.* , com.productos.seguridad.*" %>
<%
    String nombre = request.getParameter("nombre_us");
    String cedula = request.getParameter("cedula_us");
    String correo = request.getParameter("correo_us");
    String clave = request.getParameter("clave_us");
    int id_per = Integer.parseInt(request.getParameter("id_per"));
    int id_est = Integer.parseInt(request.getParameter("id_est"));

    Conexion conexion = new Conexion();
    Connection con = conexion.getConexion();
	usuario us=new usuario();
    String mensaje = "";

    try {
        String sql = "INSERT INTO tb_usuario (id_us,id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) VALUES (?,?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, us.numID());
        ps.setInt(2, id_per);
        ps.setInt(3, id_est);
        ps.setString(4, nombre);
        ps.setString(5, cedula);
        ps.setString(6, correo);
        ps.setString(7, clave);

        int filas = ps.executeUpdate();
        if (filas > 0) {
            mensaje = "Usuario registrado exitosamente.";
        } else {
            mensaje = "Error al registrar el usuario.";
        }
        ps.close();
    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (con != null) con.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro Usuario</title>
</head>
<body>
    <h3><%= mensaje %></h3>
    <a href="usuarios.jsp">Volver</a>
</body>
</html>
S