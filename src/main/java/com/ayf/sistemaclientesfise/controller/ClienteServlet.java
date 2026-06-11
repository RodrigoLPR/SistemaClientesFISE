package com.ayf.sistemaclientesfise.controller;

import com.ayf.sistemaclientesfise.dao.ClienteDAO;
import com.ayf.sistemaclientesfise.model.Cliente;
import com.ayf.sistemaclientesfise.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/cliente"})
public class ClienteServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    private static final Logger logger = LoggerFactory.getLogger(ClienteServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = null;

        if (session != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        }

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String dni = request.getParameter("dni");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String estado = request.getParameter("estado");

        try {
            com.ayf.sistemaclientesfise.util.ValidadorCliente.validarDatosCliente(dni, nombres, apellidos, direccion);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("registroCliente.jsp").forward(request, response);
            return;
        }

        Cliente cliente = new Cliente();
        cliente.setDni(dni);
        cliente.setNombres(nombres);
        cliente.setApellidos(apellidos);
        cliente.setDireccion(direccion);
        cliente.setTelefono(telefono);
        cliente.setCorreo(correo);
        cliente.setEstado(estado);
        cliente.setIdUsuario(usuario.getIdUsuario());

        boolean registrado = clienteDAO.registrarCliente(cliente);

        if (registrado) {
            logger.info("Cliente registrado correctamente con DNI: {}", dni);
            request.setAttribute("mensaje", "Cliente registrado correctamente");
        } else {
            logger.error("No se pudo registrar el cliente con DNI: {}", dni);
            request.setAttribute("error", "No se pudo registrar el cliente");
        }

        request.getRequestDispatcher("registroCliente.jsp").forward(request, response);
    }
}
