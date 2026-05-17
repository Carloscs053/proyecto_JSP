package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.recuperacion_jsp.DAO.DAOManager;
import org.example.recuperacion_jsp.DAO.DaoReservaSQL;
import org.example.recuperacion_jsp.models.Reserva;
import org.example.recuperacion_jsp.models.Usuario;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "PanelControlServlet", value = "/PanelControlServlet")
public class PanelControlServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recuperamos la sesión actual
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuario");

        // Control de seguridad por si el filtro no estuviera activo
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Instanciamos el gestor de la base de datos y el DAO de reservas
        DAOManager dao = DAOManager.getSingletonInstance();
        DaoReservaSQL daoRes = new DaoReservaSQL();

        // Buscamos todas las reservas que pertenecen al usuario logueado
        ArrayList<Reserva> misReservas = daoRes.readByUsuario(user.getId(), dao);

        // Almacenamos la lista en el request para que el JSP pueda leerla
        request.setAttribute("reservasUser", misReservas);

        // Enrutamos la petición hacia la vista privada manteniendo los datos cargados
        request.getRequestDispatcher("panelControl.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirigimos las peticiones POST al doGet para que se procesen por igual
        doGet(request, response);
    }
}