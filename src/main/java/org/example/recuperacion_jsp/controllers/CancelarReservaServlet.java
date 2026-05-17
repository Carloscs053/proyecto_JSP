package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.recuperacion_jsp.DAO.DAOManager;
import org.example.recuperacion_jsp.DAO.DaoReservaSQL;
import org.example.recuperacion_jsp.models.Usuario;

import java.io.IOException;

@WebServlet(name = "CancelarReservaServlet", value = "/CancelarReservaServlet")
public class CancelarReservaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuario");

        // Recogemos el ID de la reserva que nos llega por la URL
        String idParam = request.getParameter("id");

        // Si el usuario está correctamente logueado y el ID no es nulo
        if (user != null && idParam != null) {
            try {
                int idReserva = Integer.parseInt(idParam);

                DAOManager dao = DAOManager.getSingletonInstance();
                DaoReservaSQL daoRes = new DaoReservaSQL();

                // Intentamos borrar la reserva
                if (daoRes.delete(idReserva, dao)) {
                    // Si va bien, volvemos al panel con el mensaje de éxito
                    response.sendRedirect("PanelControlServlet?msg=cancelOk");
                } else {
                    // Si falla el borrado en base de datos
                    response.sendRedirect("PanelControlServlet?msg=errorCancel");
                }
            } catch (NumberFormatException e) {
                // Medida extra de seguridad por si alguien modifica la URL a mano
                response.sendRedirect("PanelControlServlet?msg=errorCancel");
            }
        } else {
            // Si no hay sesión o no hay ID, lo echamos al inicio
            response.sendRedirect("index.jsp");
        }
    }
}