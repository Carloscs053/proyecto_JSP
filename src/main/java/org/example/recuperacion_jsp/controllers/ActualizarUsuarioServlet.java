package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.recuperacion_jsp.DAO.DAOManager;
import org.example.recuperacion_jsp.DAO.DaoUsuarioSQL;
import org.example.recuperacion_jsp.models.Usuario;

import java.io.IOException;

@WebServlet(name = "ActualizarUsuarioServlet", value = "/ActualizarUsuarioServlet")
public class ActualizarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuario");

        // Si la sesión caducó o intentan entrar sin loguearse
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Recogemos los parámetros del formulario de panelControl.jsp
        String nuevoUsername = request.getParameter("username");
        String nuevoNombre = request.getParameter("nombre");
        String nuevoEmail = request.getParameter("email");
        String nuevoMovil = request.getParameter("movil");
        String nuevaPass = request.getParameter("password");

        // Actualizamos el objeto en memoria
        user.setUsername(nuevoUsername);
        user.setNombre(nuevoNombre);
        user.setEmail(nuevoEmail);
        user.setMovil(nuevoMovil);

        // Solo cambiamos la contraseña si el usuario escribió algo
        if (nuevaPass != null && !nuevaPass.trim().isEmpty()) {
            user.setPassword(nuevaPass);
        }

        // Instanciamos la conexión a la Base de Datos
        DAOManager dao = DAOManager.getSingletonInstance();
        DaoUsuarioSQL daoUser = new DaoUsuarioSQL();

        // Ejecutamos el Update
        if (daoUser.update(user, dao)) {
            // Si el DAO devuelve true, sincronizamos la sesión con los nuevos datos
            session.setAttribute("usuario", user);
            response.sendRedirect("PanelControlServlet?msg=updateOk");
        } else {
            // Si devuelve false
            response.sendRedirect("PanelControlServlet?msg=errorUpdate");
        }
    }
}