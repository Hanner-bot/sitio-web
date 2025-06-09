<%@ page import="java.sql.*, com.productos.datos.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id_us"));
    String nombre = request.getParameter("nombre_us");
    String cedula = request.getParameter("cedula_us");
    String correo = request.getParameter("correo_us");
    String clave = request.getParameter("txtClave");
    int perfil = Integer.parseInt(request.getParameter("id_per"));
    int estadoCivil = Integer.parseInt(request.getParameter("id_est"));

    Conexion con = new Conexion();
    String sql = "UPDATE tb_usuario SET nombre_us=?, cedula_us=?, correo_us=?, clave_us=?, id_per=?, id_est=? WHERE id_us=?";
    PreparedStatement ps = con.getConexion().prepareStatement(sql);
    ps.setString(1, nombre);
    ps.setString(2, cedula);
    ps.setString(3, correo);
    ps.setString(4, clave);
    ps.setInt(5, perfil);
    ps.setInt(6, estadoCivil);
    ps.setInt(7, id);

    int filas = ps.executeUpdate();
    if (filas > 0) {
        response.sendRedirect("usuarios.jsp");
    } else {
        out.println("Error al actualizar el usuario.");
    }

    ps.close();
%>
