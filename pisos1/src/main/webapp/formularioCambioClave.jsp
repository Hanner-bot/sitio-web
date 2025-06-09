<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cambiar Contraseña | H&M Toque Final</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header style="background-color: #2c3e50; color: white; padding: 20px; text-align: center;">
        <a href="index.jsp"><img src="imagenes/jacko.jpg" alt="Logo" style="width: 80px;"></a>
        <h1>H&M Toque Final</h1>
        <p>Estilo y calidad en pisos y acabados</p>
    </header>

    <nav class="bg-dark text-white p-2">
        <ul class="nav justify-content-center">
            <li class="nav-item"><a class="nav-link text-white" href="menu.jsp">Regresar</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="cerrarSesion.jsp">Cerrar Sesión</a></li>
        </ul>
    </nav>

    <main class="container mt-5">
        <div class="card p-4">
            <h2 class="mb-4">Cambiar Contraseña</h2>
            <form action="cambioClave.jsp" method="post" onsubmit="return validarContrasena();">
                <div class="mb-3">
                    <label for="correo_us" class="form-label">Correo electrónico:</label>
                    <input type="email" class="form-control" id="correo_us" name="correo_us" required>
                </div>

                <div class="mb-3">
                    <label for="clave_nueva1" class="form-label">Nueva contraseña:</label>
                    <input type="password" class="form-control" id="clave_nueva1" name="clave_nueva1" required>
                    <div class="form-check mt-1">
                        <input type="checkbox" class="form-check-input" id="mostrarClave1" onclick="togglePassword()">
                        <label class="form-check-label" for="mostrarClave1">Mostrar clave</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="clave_nueva2" class="form-label">Confirmar nueva contraseña:</label>
                    <input type="password" class="form-control" id="clave_nueva2" name="clave_nueva2" required>
                    <div class="form-check mt-1">
                        <input type="checkbox" class="form-check-input" id="mostrarClave2" onclick="togglePassword()">
                        <label class="form-check-label" for="mostrarClave2">Mostrar clave</label>
                    </div>
                </div>

                <button type="submit" class="btn btn-success">Cambiar contraseña</button>
                <a href="menu.jsp" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>
    </main>

    <footer class="text-center mt-5 p-3 bg-light">
        <p>Síguenos en nuestras redes sociales</p>
        <div class="social">
            <a href="https://www.facebook.com/"><img src="iconos/facebook.png" alt="Facebook" width="30"></a>
            <a href="https://www.instagram.com/"><img src="iconos/instagram.png" alt="Instagram" width="30"></a>
            <a href="https://www.tiktok.com/"><img src="iconos/tiktok.png" alt="TikTok" width="30"></a>
        </div>
        <p class="mt-2">&copy; 2025 H&M Toque Final - Todos los derechos reservados.</p>
    </footer>

    <script>
        function validarContrasena() {
            var clave1 = document.getElementById("clave_nueva1").value;
            var clave2 = document.getElementById("clave_nueva2").value;

            if (clave1 !== clave2) {
                alert("Las contraseñas no coinciden. Por favor, intenta de nuevo.");
                return false;
            }

            if (clave1.length < 8) {
                alert("La contraseña debe tener al menos 8 caracteres.");
                return false;
            }

            return true;
        }

        function togglePassword() {
            var clave1 = document.getElementById("clave_nueva1");
            var clave2 = document.getElementById("clave_nueva2");

            clave1.type = document.getElementById("mostrarClave1").checked ? "text" : "password";
            clave2.type = document.getElementById("mostrarClave2").checked ? "text" : "password";
        }
    </script>
</body>
</html>
