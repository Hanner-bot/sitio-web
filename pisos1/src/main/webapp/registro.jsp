<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 30px;
            margin: 0;
            color: #333;
        }

        h3 {
            text-align: center;
            color: #2c3e50;
            font-weight: normal;
        }

        form {
            background-color: #ffffff;
            width: 500px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
        }

        fieldset {
            border: none;
            padding: 0;
            margin: 0;
        }

        legend {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        label {
            display: block;
            margin-top: 12px;
            font-size: 14px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="month"],
        input[type="color"],
        select,
        input[type="file"] {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            margin-top: 5px;
        }

        .radio-group {
            margin-top: 8px;
        }

        .radio-group label {
            margin-right: 15px;
            font-size: 14px;
        }

        .button-group {
            margin-top: 20px;
            text-align: center;
        }

        input[type="submit"],
        input[type="reset"],
        button {
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 8px 14px;
            margin: 5px 10px;
            font-size: 14px;
            cursor: pointer;
        }

        input[type="reset"] {
            background-color: #7f8c8d;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover,
        button:hover {
            background-color: #34495e;
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

<h3>Registro nuevo cliente</h3>

<form action="respuesta.jsp" method="post">
    <fieldset>
        <legend>Datos personales</legend>

        <label for="nombre">Nombre y apellidos:</label>
        <input id="nombre" type="text" name="txtNombre" required/>

        <label for="cedula">Cédula:</label>
        <input type="text" id="cedula" name="txtCedula" maxlength="10" required/>

        <label for="estadoCivil">Estado civil:</label>
        <select id="estadoCivil" name="cmbECivil">  
            <option value="1">Soltero</option> 
            <option value="2">Casado</option> 
            <option value="3">Divorciado</option> 
            <option value="4">Viudo</option>
        </select>

        <label>Lugar de residencia:</label>
        <div class="radio-group">
            <label><input type="radio" name="rdResidencia" value="Sur" required/> Sur</label>
            <label><input type="radio" name="rdResidencia" value="Norte"/> Norte</label>
            <label><input type="radio" name="rdResidencia" value="Centro"/> Centro</label>
        </div>

        <label for="foto">Foto:</label>
        <input type="file" name="fileFoto" id="foto" accept=".jpg, .jpeg, .png"/>

        <label for="fecha">Fecha de nacimiento:</label>
        <input type="month" name="fecha" id="fecha"/>

        <label for="color">Color favorito:</label>  
        <input type="color" id="color" name="cColor"/>

        <label for="email">Correo:</label>
        <input type="email" id="email" name="txtEmail" required/>	

        <label for="clave">Contraseña:</label>
        <input type="password" id="clave" name="txtClave" required/>

        <div class="button-group">
            <input type="submit" value="Registrar"/>
            <input type="reset" value="Limpiar"/>
        	<a href="index.jsp">Inicio</a>
        </div>
        
    </fieldset>
</form>

</body>
</html>
