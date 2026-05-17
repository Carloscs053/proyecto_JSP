package org.example.recuperacion_jsp.controllers;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// Aquí definimos exactamente qué rutas están protegidas por el filtro
@WebFilter(urlPatterns = {
        "/panelControl.jsp",
        "/PanelControlServlet",
        "/ActualizarUsuarioServlet",
        "/CancelarReservaServlet",
        "/ReservarServlet"
})
public class FiltroSeguridad implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        // Hacemos un cast a HttpServletRequest y HttpServletResponse para poder manejar sesiones y redirecciones
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Obtenemos la sesión actual, pero pasando 'false' para que no cree una nueva si no existe
        HttpSession session = req.getSession(false);

        // Comprobamos si la sesión existe y si tiene el atributo "usuario" guardado
        if (session != null && session.getAttribute("usuario") != null) {
            // El usuario está autenticado, le dejamos pasar a su destino original
            chain.doFilter(request, response);
        } else {
            // No hay sesión o no está logueado, lo mandamos al login con un parámetro de error
            res.sendRedirect("login.jsp?error=Debes iniciar sesión para acceder");
        }
    }
}