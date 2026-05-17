<%@ page import="org.example.recuperacion_jsp.models.*" %>
<%@ page import="org.example.recuperacion_jsp.DAO.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Usuario userSession = (Usuario) session.getAttribute("usuario");
    DAOManager dao = DAOManager.getSingletonInstance();

    String fechaParam = request.getParameter("fecha");
    java.sql.Date fechaSeleccionada;
    if (fechaParam != null && !fechaParam.isEmpty()) {
        fechaSeleccionada = java.sql.Date.valueOf(fechaParam);
    } else {
        fechaSeleccionada = new java.sql.Date(System.currentTimeMillis());
    }

    DaoInstalacionSQL daoInst = new DaoInstalacionSQL();
    DaoReservaSQL daoRes = new DaoReservaSQL();

    ArrayList<Instalacion> pistas = daoInst.readAll(dao);
    ArrayList<Reserva> reservasHoy = daoRes.readByFecha(fechaSeleccionada, dao);
    int[] horas = {9, 10, 11, 12, 13, 16, 17, 18, 19, 20, 21, 22};
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reserva de Instalaciones - ProArena Manager</title>
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=5">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?v=5">
</head>
<body>

<nav class="navbar">
    <div class="logo">Polideportivo Martos</div>
    <div class="navbar-links">
        <% if (userSession == null) { %>
        <a href="login.jsp" class="btn btn-success" style="padding: 0.5rem 1rem;">Login</a>
        <a href="registro.jsp" style="color: white;">Registro</a>
        <% } else { %>
        <span style="font-weight: 500;">Hola, <%= userSession.getNombre() %></span>
        <a href="PanelControlServlet">Mi Panel</a>
        <a href="LogoutServlet" style="color: #ffb3ad;">Cerrar Sesión</a>
        <% } %>
    </div>
</nav>

<main class="container">
    <div class="dashboard-header">
        <div>
            <h1 style="font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem;">Reserva de Instalaciones</h1>
            <p style="color: var(--text-muted); max-width: 600px;">Gestiona tus reservas de fútbol sala y tenis en el
                Polideportivo Municipal de Martos.</p>
        </div>
        <div class="date-selector-card">
            <label>Fecha de Reserva</label>
            <form action="index.jsp" method="GET" class="date-input-wrapper">
                <span class="material-symbols-outlined">calendar_today</span>
                <input type="date" name="fecha" value="<%= fechaSeleccionada %>"
                       min="<%= new java.sql.Date(System.currentTimeMillis()) %>"
                       max="<%= new java.sql.Date(System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000) %>"
                       onchange="this.form.submit()">
            </form>
        </div>
    </div>

    <% if ("reservaOk".equals(request.getParameter("msg"))) { %>
    <div class="alert alert-success"><span class="material-symbols-outlined">check_circle</span>¡Reserva realizada con
        éxito!
    </div>
    <% } %>
    <%
        LocalDate hoy = LocalDate.now();
        LocalDate fechaSel = fechaSeleccionada.toLocalDate();
        LocalTime ahora = LocalTime.now();
    %>

    <div class="reservation-table-container">
        <table class="res-table">
            <thead>
            <tr>
                <th>Hora</th>
                <% for (Instalacion p : pistas) { %>
                <th><%= p.getNombre() %>
                </th>
                <% } %>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < horas.length; i++) {
                int h = horas[i];

                if (h == 16) { %>
            <tr class="break-row">
                <td colspan="<%= pistas.size() + 1 %>"></td>
            </tr>
            <% }

                String horaStr = (h < 10 ? "0" + h : h) + ":00:00";

                boolean horaPasada = false;
                if (fechaSel.isBefore(hoy)) {
                    horaPasada = true;
                } else if (fechaSel.isEqual(hoy) && ahora.getHour() >= h) {
                    horaPasada = true;
                }
            %>
            <tr>
                <td><%= h %>:00</td>
                <% for (Instalacion p : pistas) {
                    boolean ocupada = false;
                    for (Reserva r : reservasHoy) {
                        if (r.getIdInstalacion() == p.getId() && r.getHora().toString().equals(horaStr)) {
                            ocupada = true;
                            break;
                        }
                    }
                %>
                <td>
                    <% if (ocupada) { %>
                    <span class="slot-link slot-occupied">Ocupado</span>
                    <% } else if (horaPasada) { %>
                    <span class="slot-link"
                          style="background-color: #f1f5f9; color: #94a3b8; cursor: not-allowed; border: 1px dashed #cbd5e1;">No Disponible</span>
                    <% } else if (userSession != null) { %>
                    <a href="ReservarServlet?idPista=<%= p.getId() %>&fecha=<%= fechaSeleccionada %>&hora=<%= h %>"
                       class="slot-link slot-free">Libre</a>
                    <% } else { %>
                    <div style="text-align:center;">
                        <span class="slot-link slot-free" style="opacity: 0.6; cursor: default;">Libre</span>
                        <p class="slot-login-required">Inicia sesión</p>
                    </div>
                    <% } %>
                </td>
                <% } %>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>