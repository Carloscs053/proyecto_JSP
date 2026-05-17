package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Buscamos la sesión actual del usuario.
        // Pasamos 'false' para que, si no hay sesión activa, no cree una nueva en blanco.
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidamos la sesión
            session.invalidate();
        }

        // Redirigimos al usuario a la página principal pública de reservas
        response.sendRedirect("index.jsp");
    }
}