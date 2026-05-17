package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.recuperacion_jsp.DAO.DAOManager;
import org.example.recuperacion_jsp.DAO.DaoReservaSQL;
import org.example.recuperacion_jsp.models.Reserva;
import org.example.recuperacion_jsp.models.Usuario;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet(name = "ReservarServlet", value = "/ReservarServlet")
public class ReservarServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuario");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int idPista = Integer.parseInt(request.getParameter("idPista"));
            Date fecha = Date.valueOf(request.getParameter("fecha"));
            String horaStr = request.getParameter("hora") + ":00:00";
            Time hora = Time.valueOf(horaStr);

            Reserva nuevaReserva = new Reserva(0, user.getId(), idPista, fecha, hora);
            DAOManager dao = DAOManager.getSingletonInstance();
            DaoReservaSQL daoRes = new DaoReservaSQL();

            if (daoRes.insert(nuevaReserva, dao)) {
                response.sendRedirect("index.jsp?fecha=" + fecha + "&msg=reservaOk");
            } else {
                response.sendRedirect("index.jsp?fecha=" + fecha + "&msg=errorReserva");
            }
        } catch (Exception e) {
            response.sendRedirect("index.jsp?msg=errorReserva");
        }
    }
}