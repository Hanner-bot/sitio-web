<%@ page import="com.productos.datos.Conexion" %>
<%
    int id = Integer.parseInt(request.getParameter("id_us"));
    int estadoActual = Integer.parseInt(request.getParameter("estado"));
    int nuevoEstado = (estadoActual == 1) ? 0 : 1;

    Conexion con = new Conexion();
    String sql = "UPDATE tb_usuario SET estado = " + nuevoEstado + " WHERE id_us = " + id;
    con.Ejecutar(sql);

    response.sendRedirect("usuarios.jsp");
%>
