<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://jsdelivr.net" rel="stylesheet">
    <style>
        body {
            background-color: #f3f4f6; /* Gris claro moderno */
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background-color: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 2.5rem;
        }
        .form-label {
            font-weight: 500;
            color: #4b5563;
        }
        .form-control {
            border-radius: 8px;
            padding: 10px 14px;
            border: 1px solid #d1d5db;
        }
        .form-control:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }
        .btn-login {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-weight: 500;
            transition: opacity 0.2s;
        }
        .btn-login:hover {
            opacity: 0.95;
            box-shadow: 0 4px 6px -1px rgba(29, 78, 216, 0.2);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-sm-10 col-md-7 col-lg-5 col-xl-4">
                <div class="card login-card">

                    <h3 class="text-center fw-semibold mb-4 text-dark">Inicio de sesion</h3>

                    <form action="LoginServlet" method="POST">

                        <!-- Campo: Usuario -->
                        <div class="mb-3">
                            <label for="username" class="form-label small">Nombre de usuario</label>
                            <input type="text" class="form-control" id="username" name="txtUsuario" placeholder="   " required autocomplete="username">
                        </div>

                        <!-- Campo: Contraseña -->
                        <div class="mb-4">
                            <label for="password" class="form-label small">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="txtPassword" placeholder="   " required autocomplete="current-password">
                        </div>

                        <!-- Botón Iniciar sesión -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-login text-white">Iniciar sesión</button>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://jsdelivr.net"></script>
</body>
</html>
