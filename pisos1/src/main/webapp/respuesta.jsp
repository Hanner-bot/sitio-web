<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="com.productos.seguridad.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro Exitoso</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ecf0f1;
            padding: 30px;
            color: #2c3e50;
            text-align: center;
        }

        .mensaje {
            background-color: #dff0d8;
            border: 1px solid #3c763d;
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background-color: #2c3e50;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
        }

        a:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>

    <div class="mensaje">
        <h2>¡Registro exitoso!</h2>
        <p>Gracias por registrarte en H&M Toque Final.</p>
        <h3>Datos registrados:</h3>
        <p><strong>Nombre:</strong> <%= request.getParameter("txtNombre") %></p>
        <p><strong>Cédula:</strong> <%= request.getParameter("txtCedula") %></p>
        <p><strong>Estado Civil:</strong> <%= request.getParameter("cmbECivil") %></p>
        <p><strong>Lugar de Residencia:</strong> <%= request.getParameter("rdResidencia") %></p>
        <p><strong>Fecha de Nacimiento:</strong> <%= request.getParameter("fecha") %></p>
        <p><strong>Color Favorito:</strong> <%= request.getParameter("cColor") %></p>
        <p><strong>Correo:</strong> <%= request.getParameter("txtEmail") %></p>
        <p><strong>Clave:</strong> <%= request.getParameter("txtClave") %></p>
        	<%
        	
        	
        	usuario nuevo = new usuario();
         	nuevo.setNombre(request.getParameter("txtNombre"));
         	nuevo.setCedula(request.getParameter("txtCedula"));
         	nuevo.setCorreo(request.getParameter("txtEmail"));
         	nuevo.setClave(request.getParameter("txtClave"));
         	nuevo.setEstadoCivil( Integer.parseInt(request.getParameter("cmbECivil")) ); // por ejemplo: Soltero
         	String resultado = nuevo.ingresarCliente();
         	System.out.println(resultado);
        
         	%>
       	<a href="registro.jsp">Registrar otro cliente</a>
    	<a href="index.jsp">Inicio</a>
    </div>

</body>
</html>
