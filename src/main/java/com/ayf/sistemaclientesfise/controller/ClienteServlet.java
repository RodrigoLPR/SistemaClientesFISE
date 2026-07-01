package com.ayf.sistemaclientesfise.controller;

import com.ayf.sistemaclientesfise.dao.ClienteDAO;
import com.ayf.sistemaclientesfise.model.Cliente;
import com.ayf.sistemaclientesfise.model.Usuario;
import com.ayf.sistemaclientesfise.util.ValidadorCliente;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            try {
                int idCliente = Integer.parseInt(request.getParameter("id"));
                clienteDAO.eliminarCliente(idCliente);
                logger.info("Cliente eliminado correctamente. ID: {}", idCliente);
            } catch (Exception e) {
                logger.error("Error al eliminar cliente: {}", e.getMessage());
            }
            response.sendRedirect("gestionClientes.jsp");
            return;
        }

        response.sendRedirect("gestionClientes.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        String dni = request.getParameter("dni");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String estado = request.getParameter("estado");
        String observacion = request.getParameter("observacion");

        try {
            ValidadorCliente.validarDatosCliente(dni, nombres, apellidos, direccion);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            if ("actualizar".equals(accion)) {
                request.getRequestDispatcher("editarCliente.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("registroCliente.jsp").forward(request, response);
            }
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
        cliente.setObservacion(observacion);
        
        // LÍNEA CORREGIDA: Se envía el ID del usuario activo para cumplir con la restricción de la BD
        cliente.setIdUsuario(usuario.getIdUsuario()); 

        try {
            if ("actualizar".equals(accion)) {
                int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                cliente.setIdCliente(idCliente);
                clienteDAO.actualizarCliente(cliente);
                logger.info("Cliente actualizado correctamente. ID: {}", idCliente);
                response.sendRedirect("gestionClientes.jsp");

            } else {
                clienteDAO.registrarCliente(cliente);
                logger.info("Cliente registrado correctamente con DNI: {}", dni);
                request.setAttribute("mensaje", "Cliente registrado correctamente");
                request.getRequestDispatcher("registroCliente.jsp").forward(request, response);
            }
        } catch (Exception e) {
            logger.error("Error en la operación del cliente: {}", e.getMessage());
            request.setAttribute("error", "Error al procesar la operación");
            if ("actualizar".equals(accion)) {
                request.getRequestDispatcher("editarCliente.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("registroCliente.jsp").forward(request, response);
            }
        }
    }
}