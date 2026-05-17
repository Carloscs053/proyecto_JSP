<%@page import="org.example.recuperacion_jsp.models.*" %>
<%@page import="java.util.ArrayList" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    ArrayList<Reserva> reservasUser = (ArrayList<Reserva>) request.getAttribute("reservasUser");

    if (usuario == null || reservasUser == null) {
        response.sendRedirect("PanelControlServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Panel - ProArena Manager</title>
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
          rel="stylesheet">
    <style>
        :root {
            --bg-main: #f8f9ff;
            --text-main: #0b1c30;
            --text-muted: #45464d;
            --brand-dark: #0b1c30;
            --accent-green: #006e2f;
            --border-color: #e2e8f0;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Lexend', sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        .navbar {
            background-color: var(--brand-dark);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .navbar .logo {
            color: white;
            font-size: 1.25rem;
            font-weight: 800;
            text-transform: uppercase;
        }

        .navbar-links a {
            color: #cbd5e1;
            text-decoration: none;
            margin-left: 1.5rem;
            font-weight: 500;
            transition: 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .navbar-links a:hover {
            color: white;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .panel-header {
            margin-bottom: 2rem;
        }

        .panel-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-main);
        }

        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-success {
            background-color: #e6f4ea;
            color: #137333;
            border: 1px solid #c6e1cd;
        }

        .alert-error {
            background-color: #fce8e6;
            color: #c5221f;
            border: 1px solid #f5c2c7;
        }

        .res-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .res-table th {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-muted);
            font-size: 0.75rem;
            text-transform: uppercase;
        }

        .res-table td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            color: var(--text-muted);
        }

        .res-table td:first-child {
            font-weight: 600;
            color: var(--text-main);
        }

        .badge-libre {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
            background-color: #e6f4ea;
            color: #137333;
        }

        .btn-danger-text {
            color: #dc2626;
            font-weight: 700;
            font-size: 0.875rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            transition: 0.2s;
        }

        .btn-danger-text:hover {
            color: #991b1b;
            text-decoration: underline;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.25rem;
        }

        .form-group label {
            display: block;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-main);
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            font-family: 'Lexend', sans-serif;
            outline: none;
        }

        .form-control:focus {
            border-color: var(--brand-dark);
            box-shadow: 0 0 0 2px rgba(11, 28, 48, 0.1);
        }

        .btn-primary {
            background-color: var(--brand-dark);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-family: 'Lexend', sans-serif;
        }

        @media (min-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr 1fr;
            }

            .form-grid .full-width {
                grid-column: span 2;
                margin-top: 1rem;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">Polideportivo Martos</div>
    <div class="navbar-links">
        <a href="index.jsp"><span class="material-symbols-outlined">home</span> Inicio</a>
        <a href="LogoutServlet" style="color: #ffb3ad; font-weight: 600;">Cerrar Sesión</a>
    </div>
</nav>

<main class="container">
    <div class="panel-header">
        <h1>Panel de Control</h1>
        <p>Gestiona tus reservas, datos personales y seguridad de tu cuenta.</p>
    </div>

    <% if ("updateOk".equals(request.getParameter("msg"))) { %>
    <div class="alert alert-success"><span class="material-symbols-outlined">check_circle</span> Datos actualizados.
    </div>
    <% } else if ("errorUpdate".equals(request.getParameter("msg"))) { %>
    <div class="alert alert-error"><span class="material-symbols-outlined">error</span> Error al actualizar.</div>
    <% } else if ("cancelOk".equals(request.getParameter("msg"))) { %>
    <div class="alert alert-success"><span class="material-symbols-outlined">check_circle</span> Reserva cancelada.
    </div>
    <% } %>

    <div class="card" style="padding: 0; overflow: hidden; margin-bottom: 3rem;">
        <div style="padding: 1.5rem; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; background: #fff;">
            <h2 style="font-size: 1.25rem; display: flex; align-items: center; gap: 0.5rem;"><span
                    class="material-symbols-outlined" style="color: var(--accent-green);">event_available</span> Mis
                Reservas</h2>
            <span class="badge-libre"><%= reservasUser.size() %> Activas</span>
        </div>
        <div style="overflow-x: auto;">
            <table class="res-table">
                <thead>
                <tr>
                    <th>Instalación</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th style="text-align: right;">Acciones</th>
                </tr>
                </thead>
                <tbody>
                <% if (reservasUser.isEmpty()) { %>
                <tr>
                    <td colspan="4" style="text-align: center; padding: 3rem; color: var(--text-muted);">Aún no tienes
                        reservas programadas.
                    </td>
                </tr>
                <% } else {
                    for (Reserva r : reservasUser) { %>
                <tr>
                    <td><%= r.getNombreInstalacion() %>
                    </td>
                    <td><%= r.getFecha() %>
                    </td>
                    <td><%= r.getHora().toString().substring(0, 5) %>
                    </td>
                    <td style="text-align: right;"><a href="CancelarReservaServlet?id=<%= r.getId() %>"
                                                      onclick="return confirm('¿Seguro?')" class="btn-danger-text">Cancelar</a>
                    </td>
                </tr>
                <% }
                } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="card">
        <h2 style="font-size: 1.25rem; margin-bottom: 1.5rem; border-bottom: 1px solid var(--border-color); padding-bottom: 1rem;">
            <span class="material-symbols-outlined" style="color: var(--accent-green); vertical-align: bottom;">person_edit</span>
            Datos Personales</h2>
        <form action="ActualizarUsuarioServlet" method="POST" class="form-grid">
            <div class="form-group"><label>Nombre de Usuario</label><input type="text" name="username"
                                                                           value="<%= usuario.getUsername() %>"
                                                                           class="form-control" required></div>
            <div class="form-group"><label>Nombre Completo</label><input type="text" name="nombre"
                                                                         value="<%= usuario.getNombre() %>"
                                                                         class="form-control" required></div>
            <div class="form-group"><label>Correo Electrónico</label><input type="email" name="email"
                                                                            value="<%= usuario.getEmail() %>"
                                                                            class="form-control" required></div>
            <div class="form-group"><label>Teléfono</label><input type="text" name="movil"
                                                                  value="<%= usuario.getMovil() %>"
                                                                  class="form-control"></div>
            <div class="form-group full-width" style="padding-top: 1.5rem; border-top: 1px dashed var(--border-color);">
                <label style="color: #dc2626;"><span class="material-symbols-outlined" style="font-size: 1rem;">lock_reset</span>
                    Cambiar Contraseña</label>
                <input type="password" name="password" placeholder="Solo si deseas cambiarla" class="form-control">
            </div>
            <div class="full-width">
                <button type="submit" class="btn-primary"><span class="material-symbols-outlined">save</span> Guardar
                    Cambios
                </button>
            </div>
        </form>
    </div>
</main>
</body>
</html>