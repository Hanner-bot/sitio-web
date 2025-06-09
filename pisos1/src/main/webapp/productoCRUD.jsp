<%@ page import="com.productos.negocio.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String accion = request.getParameter("accion");

    product pr = new product();

    if ("insertar".equals(accion)) {
        String nombre = request.getParameter("nombre");
        String id_cat = request.getParameter("cmbCategoria");
        String cantidad = request.getParameter("cantidad_pr");
        String precio = request.getParameter("precio");
		
        int id_pr=pr.numID();
        
        String sql = "INSERT INTO tb_producto (id_pr,id_cat, nombre_pr, cantidad_pr, precio_pr, foto_pr) VALUES (" +
                      id_pr+","+id_cat + ", '" + nombre + "', " + cantidad + ", " + precio + ", null)";
        
        out.println("<script>alert('" + pr.insertarProducto(sql) + "'); window.location.href='productos.jsp';</script>");
    }

    if ("eliminar".equals(accion)) {
        String id = request.getParameter("id");
        out.println("<script>alert('" + pr.eliminarProducto(id) + "'); window.location.href='productos.jsp';</script>");
    }

    if ("actualizar".equals(accion)) {
        String id = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String id_cat = request.getParameter("cmbCategoria");
        String cantidad = request.getParameter("cantidad");
        String precio = request.getParameter("precio");

        String sql = "UPDATE tb_producto SET id_cat = " + id_cat +
                     ", nombre_pr = '" + nombre +
                     "', cantidad_pr = " + cantidad +
                     ", precio_pr = " + precio +
                     " WHERE id_pr = " + id;

        out.println("<script>alert('" + pr.actualizarProducto(sql) + "'); window.location.href='productos.jsp';</script>");
    }

%>