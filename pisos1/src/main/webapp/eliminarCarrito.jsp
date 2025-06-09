<%@ page import="java.util.*" %> 
<%
    // Obtener el parámetro id_pr de la solicitud
    String idProducto = request.getParameter("id_pr");
    
    if (idProducto != null) {
        List<Map<String, Object>> carrito = (List<Map<String, Object>>) session.getAttribute("carrito");

        if (carrito != null) {
            carrito.removeIf(producto -> {
                // Obtener el valor de id_pr de cada producto y asegurarse de que no sea null
                Object idPr = producto.get("id_pr");
                
                // Verificar que id_pr no sea null y que coincida con el id del producto
                return idPr != null && idPr.toString().equals(idProducto);
            });
        }
    }
    
    // Redirigir de vuelta al carrito
    response.sendRedirect("carrito.jsp");
%>
