<%@ page import="com.productos.datos.Conexion" %>
<%
    int id = Integer.parseInt(request.getParameter("id_us"));
    Conexion con = new Conexion();
    String sql = "DELETE FROM tb_usuario WHERE id_us = " + id;
    con.Ejecutar(sql);
    response.sendRedirect("usuarios.jsp");
%>
