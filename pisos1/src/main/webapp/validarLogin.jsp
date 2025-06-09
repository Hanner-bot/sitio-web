<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1" session="true" import="com.productos.datos.*,com.productos.seguridad.*,java.sql.ResultSet" %>

<%
String nlogin = request.getParameter("txtUser");
String nclave = request.getParameter("txtContra");
HttpSession sesion = request.getSession();

usuario u = usuario.verificarUsuario(nlogin, nclave);

if (u != null) {
    sesion.setAttribute("usuario", u.getNombre());
    sesion.setAttribute("perfil", u.getPerfil());
    response.sendRedirect("menu.jsp");
} else {
    // Verificamos si existe el correo pero el estado es 0
    Conexion con = new Conexion();
    String sql = "SELECT estado FROM tb_usuario WHERE correo_us='" + nlogin + "'";
    ResultSet rs = con.Consulta(sql);
    if (rs.next() && rs.getInt("estado") == 0) {
%>
        <jsp:forward page="sesion.jsp">
            <jsp:param name="error" value="Usuario bloqueado temporalmente."/>
        </jsp:forward>
<%
    } else {
%>
        <jsp:forward page="sesion.jsp">
            <jsp:param name="error" value="Datos incorrectos.<br/>Vuelva a intentarlo."/>
        </jsp:forward>
<%
    }
}
%>
