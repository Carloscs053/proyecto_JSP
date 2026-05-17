<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ProArena Manager</title>
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
          rel="stylesheet">
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #cbdbf5 0%, #f8f9ff 100%);
            font-family: 'Lexend', sans-serif;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        .card {
            width: 100%;
            max-width: 400px;
            margin: auto;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            background: white;
            padding: 2rem;
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            box-sizing: border-box;
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
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
        }
    </style>
</head>
<body>
<div class="card">
    <div style="text-align: center; margin-bottom: 2rem;">
        <div style="display: inline-flex; align-items: center; justify-content: center; width: 4rem; height: 4rem; background-color: #0b1c30; color: white; border-radius: 1rem; margin-bottom: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <span class="material-symbols-outlined" style="font-size: 2rem;">sports_score</span>
        </div>
        <h1 style="font-size: 1.5rem; font-weight: 700; color: #0b1c30; margin-bottom: 0.5rem; letter-spacing: -0.02em;">
            Polideportivo Martos</h1>
        <p style="font-size: 0.875rem; color: #45464d;">Acceso a gestión de alto rendimiento</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div style="display: flex; align-items: center; gap: 0.5rem; background-color: #fce8e6; color: #c5221f; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; border: 1px solid #f5c2c7; font-size: 0.875rem;">
        <span class="material-symbols-outlined">error</span>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <% if (request.getParameter("registroExito") != null) { %>
    <div style="display: flex; align-items: center; gap: 0.5rem; background-color: #e6f4ea; color: #137333; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; border: 1px solid #c6e1cd; font-size: 0.875rem;">
        <span class="material-symbols-outlined">check_circle</span>
        ¡Registro completado! Ya puedes iniciar sesión.
    </div>
    <% } %>

    <form action="LoginServlet" method="POST">
        <div style="margin-bottom: 1.5rem;">
            <label for="username"
                   style="display: block; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; color: #0b1c30; margin-bottom: 0.5rem;">Nombre
                de Usuario</label>
            <div style="position: relative;">
                <span class="material-symbols-outlined"
                      style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #45464d;">person</span>
                <input type="text" id="username" name="txtUsuario" class="form-control"
                       placeholder="Introduce tu usuario" required>
            </div>
        </div>
        <div style="margin-bottom: 1.5rem;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                <label for="password"
                       style="font-size: 0.75rem; font-weight: 700; text-transform: uppercase; color: #0b1c30; margin: 0;">Contraseña</label>
            </div>
            <div style="position: relative;">
                <span class="material-symbols-outlined"
                      style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #45464d;">lock</span>
                <input type="password" id="password" name="txtPassword" class="form-control" placeholder="••••••••"
                       required>
            </div>
        </div>
        <div style="margin-top: 2rem;">
            <button type="submit" class="btn-primary">
                Iniciar Sesión
                <span class="material-symbols-outlined">arrow_forward</span>
            </button>
        </div>
    </form>
    <div style="text-align: center; margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid #e2e8f0; font-size: 0.875rem; color: #45464d;">
        ¿No tienes una cuenta? <a href="registro.jsp" style="color: #006e2f; font-weight: 600; text-decoration: none;">Regístrate
        aquí</a>
    </div>
</div>
</body>
</html>