<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión / Registro - H&M Toque Final</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f3f3f3;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background: #fff;
            padding: 40px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            border-radius: 10px;
            max-width: 500px;
            width: 100%;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input {
            margin-bottom: 15px;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 10px;
            font-size: 1rem;
            background-color: #3f51b5;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #303f9f;
        }
        .switch {
            margin-top: 20px;
            text-align: center;
            color: #666;
        }
        .switch a {
            color: #3f51b5;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
            <h2>Iniciar Sesión</h2>
            <form action="validarLogin.jsp" method="post" class="login-form">
                <input type="text" name="txtUser" placeholder="Nombre de usuario" required>
                <input type="password" name="txtContra" placeholder="Contraseña" required>
                <button type="submit">Ingresar</button>
          
            </form>            
            <div class="switch">
                ¿No tienes cuenta? <a href="registro.jsp">Create una aqui</a>
                </a></li><br>
                <a href="index.jsp">Inicio</a>
                </a></li>
                
            </div>
    </div>
</body>
</html>
