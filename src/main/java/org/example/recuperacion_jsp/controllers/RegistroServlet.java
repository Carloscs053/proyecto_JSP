package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.recuperacion_jsp.DAO.DAOManager;
import org.example.recuperacion_jsp.DAO.DaoUsuarioSQL;
import org.example.recuperacion_jsp.models.Usuario;
import java.io.IOException;

@WebServlet(name = "RegistroServlet", value = "/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario nuevoUsuario = new Usuario(
                0,
                request.getParameter("txtUsername"),
                request.getParameter("txtPassword"),
                request.getParameter("txtNombre"),
                request.getParameter("txtEmail"),
                request.getParameter("txtMovil")
        );

        DAOManager dao = DAOManager.getSingletonInstance();
        DaoUsuarioSQL daoUser = new DaoUsuarioSQL();

        if (daoUser.insert(nuevoUsuario, dao)) {
            response.sendRedirect("login.jsp?registroExito=true");
        } else {
            request.setAttribute("error", "Error en el registro. El usuario podría existir ya.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }
}