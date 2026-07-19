package com.ayf.sistemaclientesfise.controller;

import com.ayf.sistemaclientesfise.model.Cliente;
import com.ayf.sistemaclientesfise.util.ConexionBD;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ConsultaServlet", urlPatterns = {"/consultatramite"})
public class ConsultaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Limpia el rastro de búsqueda y muestra la pantalla inicial limpia
        request.getRequestDispatcher("consultaStatus.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String dni = request.getParameter("dni");

        // Validación básica en el servidor para asegurar que venga un parámetro válido de 8 dígitos
        if (dni == null || dni.trim().length() != 8) {
            request.setAttribute("error", "Por favor, ingrese un número de DNI válido de 8 dígitos.");
            request.getRequestDispatcher("consultaStatus.jsp").forward(request, response);
            return;
        }

        List<Cliente> clientesEncontrados = new ArrayList<>();
        String sql = "SELECT id_cliente, dni, nombres, apellidos, direccion, distrito, telefono, correo, estado, observacion, fecha_registro FROM cliente WHERE dni = ?";

        // Bloque con recursos robusto utilizando el método real de tu arquitectura
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, dni.trim());
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setDni(rs.getString("dni"));
                    c.setNombres(rs.getString("nombres"));
                    c.setApellidos(rs.getString("apellidos"));
                    c.setDireccion(rs.getString("direccion"));
                    c.setDistrito(rs.getString("distrito"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setCorreo(rs.getString("correo"));
                    c.setEstado(rs.getString("estado"));
                    c.setObservacion(rs.getString("observacion"));
                    
                    // Extraído como String compatible con el tipo declarado en tu entidad
                    c.setFechaRegistro(rs.getString("fecha_registro"));
                    
                    clientesEncontrados.add(c);
                }
            }

            // Envío y control estructurado de resultados hacia la vista consultaStatus.jsp
            if (!clientesEncontrados.isEmpty()) {
                if (clientesEncontrados.size() == 1) {
                    // Flujo clásico para un único predio registrado
                    request.setAttribute("clienteEncontrado", clientesEncontrados.get(0));
                } else {
                    // Flujo multi-predio secuencial y numerado
                    request.setAttribute("listaClientesEncontrados", clientesEncontrados);
                }
            } else {
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