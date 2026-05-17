<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - ProArena Manager</title>
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
          rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Lexend', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #cbdbf5 0%, #f8f9ff 100%);
            padding: 2rem;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        .reg-container {
            display: flex;
            width: 100%;
            max-width: 900px;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }

        .reg-info {
            background: linear-gradient(135deg, #0b1c30 0%, #131b2e 100%);
            color: white;
            padding: 3rem;
            width: 40%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .reg-form {
            padding: 3rem;
            width: 60%;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-group label {
            display: block;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #0b1c30;
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            font-family: 'Lexend', sans-serif;
        }

        .form-control:focus {
            outline: none;
            border-color: #0b1c30;
        }

        .btn-primary {
            width: 100%;
            background-color: #0b1c30;
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }

        .alert-error {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background-color: #fce8e6;
            color: #c5221f;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid #f5c2c7;
            font-size: 0.875rem;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .reg-container {
                flex-direction: column;
            }

            .reg-info, .reg-form {
                width: 100%;
                padding: 2rem;
            }

            .reg-info {
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="reg-container">
    <div class="reg-info">
        <h1 style="font-size: 2rem; font-weight: 700; margin-bottom: 1rem;">ProArena Manager</h1>
        <div style="width: 3rem; height: 0.25rem; background-color: #006e2f; border-radius: 1rem; margin-bottom: 2rem;"></div>
        <p style="font-size: 1rem; color: #cbd5e1; line-height: 1.6; margin-bottom: 2rem;">Gestione su rendimiento y
            reserve instalaciones de primer nivel en el Polideportivo Martos.</p>
    </div>
    <div class="reg-form">
        <h2 style="font-size: 1.5rem; font-weight: 700; color: #0b1c30; margin-bottom: 0.5rem;">Crear cuenta</h2>
        <p style="font-size: 0.875rem; color: #45464d; margin-bottom: 2rem;">Únase a la comunidad de Polideportivo
            Martos.</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error"><span
                class="material-symbols-outlined">error</span><%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="RegistroServlet" method="POST">
            <div class="form-group">
                <label>Nombre de usuario</label>
                <div style="position: relative;">
                    <span class="material-symbols-outlined"
                          style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #45464d;">person</span>
                    <input type="text" name="txtUsername" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label>Contraseña</label>
                <div style="position: relative;">
                    <span class="material-symbols-outlined"
                          style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #45464d;">lock</span>
                    <input type="password" name="txtPassword" class="form-control" minlength="6" required>
                </div>
            </div>
            <div class="form-group">
                <label>Nombre completo</label>
                <div style="position: relative;">
                    <span class="material-symbols-outlined"
                          style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #45464d;">badge</span>
                    <input type="text" name="txtNombre" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label>Correo electrónico</label>
                <div style="position: relative;">
                    <span class="material-symbols-outlined"
                          style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #45464d;">mail</span>
                    <input type="email" name="txtEmail" class="form-control" required>
                </div>
            </div>
            <div class="form-group" style="margin-bottom: 2rem;">
                <label>Teléfono móvil</label>
                <div style="position: relative;">
                    <span class="material-symbols-outlined"
                          style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #45464d;">smartphone</span>
                    <input type="tel" name="txtMovil" class="form-control" pattern="[0-9]{9}" required>
                </div>
            </div>
            <button type="submit" class="btn-primary">Finalizar registro</button>
        </form>
        <div style="text-align: center; margin-top: 1.5rem; font-size: 0.875rem; color: #45464d;">
            ¿Ya tienes cuenta? <a href="login.jsp" style="color: #006e2f; font-weight: 600; text-decoration: none;">Inicia
            sesión</a>
        </div>
    </div>
</div>
</body>
</html>