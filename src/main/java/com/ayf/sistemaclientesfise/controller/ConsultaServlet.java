package com.ayf.sistemaclientesfise.controller;

import com.ayf.sistemaclientesfise.dao.ClienteDAO;
import com.ayf.sistemaclientesfise.model.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ConsultaServlet", urlPatterns = {"/consultatramite"})
public class ConsultaServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // El método GET simplemente limpia cualquier rastro de búsqueda y muestra la pantalla inicial limpia
        request.getRequestDispatcher("consultaStatus.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String dni = request.getParameter("dni");

        // Validación básica en el servidor para asegurar que venga un parámetro válido
        if (dni == null || dni.trim().length() != 8) {
            request.setAttribute("error", "Por favor, ingrese un número de DNI válido de 8 dígitos.");
            request.getRequestDispatcher("consultaStatus.jsp").forward(request, response);
            return;
        }

        try {
            // Buscamos al cliente en la base de datos usando el método exacto
            Cliente cliente = clienteDAO.obtenerClientePorDni(dni.trim());

            if (cliente != null) {
                // Almacenamos el objeto cliente encontrado para pintarlo en la vista amena
                request.setAttribute("clienteEncontrado", cliente);
            } else {
                // Enviamos una alerta clara si el DNI no figura en los registros de la empresa
                request.setAttribute("noEncontrado", "El DNI ingresado no se encuentra registrado en nuestro sistema de instalaciones FISE.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error interno al procesar la consulta. Inténtelo más tarde.");
        }

        // Devolvemos el control a la misma pantalla para pintar los resultados de forma dinámica
        request.getRequestDispatcher("consultaStatus.jsp").forward(request, response);
    }
}