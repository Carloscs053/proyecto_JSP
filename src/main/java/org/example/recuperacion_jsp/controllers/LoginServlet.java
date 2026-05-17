package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.recuperacion_jsp.DAO.DAOManager;
import org.example.recuperacion_jsp.DAO.DaoUsuarioSQL;
import org.example.recuperacion_jsp.models.Usuario;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("txtUsuario");
        String pass = request.getParameter("txtPassword");

        DAOManager dao = DAOManager.getSingletonInstance();
        DaoUsuarioSQL daoUser = new DaoUsuarioSQL();

        Usuario usuarioLogueado = daoUser.login(user, pass, dao);

        if (usuarioLogueado != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioLogueado);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}