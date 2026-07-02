package com.ayf.sistemaclientesfise.servlet;

import com.ayf.sistemaclientesfise.dao.UsuarioDAO;
import com.ayf.sistemaclientesfise.model.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/usuario"})
public class UsuarioServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Validar sesión y rol de Administrador para ver el formulario
        HttpSession session = request.getSession(false);
        Usuario logueado = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (logueado == null || !"Administrador".equals(logueado.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Si es administrador, le mostramos el formulario
        request.getRequestDispatcher("registroUsuario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Usuario logueado = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (logueado == null || !"Administrador".equals(logueado.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = request.getParameter("username");
        String clave = request.getParameter("password");

        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setUsername(username);
        nuevoUsuario.setPassword(clave);

        boolean exito = usuarioDAO.registrarUsuario(nuevoUsuario);

        if (exito) {
            request.setAttribute("mensajeExito", "Usuario gestor registrado correctamente.");
        } else {
            request.setAttribute("mensajeError", "Error al registrar el usuario. El nombre podría estar duplicado.");
        }

        request.getRequestDispatcher("registroUsuario.jsp").forward(request, response);
    }
}