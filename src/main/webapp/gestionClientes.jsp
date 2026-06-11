<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%@page import="com.ayf.sistemaclientesfise.model.Cliente"%>
<%@page import="com.ayf.sistemaclientesfise.dao.ClienteDAO"%>
<%@page import="java.util.List"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ClienteDAO clienteDAO = new ClienteDAO();
    List<Cliente> clientes = clienteDAO.listarClientes();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Clientes - Sistema Clientes FISE</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background: #f5f7fa;
            }

            .sidebar {
                width: 260px;
                height: 100vh;
                background: #1e3a8a;
                color: white;
                position: fixed;
                padding: 25px;
                box-sizing: border-box;
            }

            .sidebar h2 {
                font-size: 22px;
                margin-bottom: 40px;
            }

            .sidebar a {
                display: block;
                color: white;
                text-decoration: none;
                margin: 18px 0;
                font-size: 16px;
            }

            .content {
                margin-left: 260px;
                padding: 35px;
            }

            .box {
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }

            h1 {
                margin-top: 0;
                color: #111827;
            }

            p {
                color: #4b5563;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 25px;
                font-size: 14px;
            }

            th {
                background: #1e3a8a;
                color: white;
                padding: 12px;
                text-align: left;
            }

            td {
                padding: 11px;
                border-bottom: 1px solid #e5e7eb;
            }

            tr:hover {
                background: #f9fafb;
            }

            .estado {
                font-weight: bold;
                color: #2563eb;
            }

            .btn-editar {
                padding: 7px 12px;
                background: #2563eb;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-size: 13px;
                margin-right: 6px;
            }

            .btn-eliminar {
                padding: 7px 12px;
                background: #dc2626;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-size: 13px;
            }

            .sin-datos {
                margin-top: 25px;
                padding: 15px;
                background: #fef3c7;
                color: #92400e;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>

        <div class="sidebar">
            <h2>Sistema Clientes<br>FISE - A&F</h2>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="registroCliente.jsp">Registrar Cliente</a>
            <a href="gestionClientes.jsp">Gestión de Clientes</a>
            <a href="reportes.jsp">Reportes</a>
            <a href="logout">Cerrar Sesión</a>
        </div>

        <div class="content">
            <div class="box">
                <h1>Gestión de Clientes</h1>
                <p>Listado de potenciales clientes FISE registrados en el sistema.</p>

                <% if (clientes == null || clientes.isEmpty()) { %>

                <div class="sin-datos">
                    No existen clientes registrados.
                </div>

                <% } else { %>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>DNI</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Cliente cliente : clientes) {%>
                        <tr>
                            <td><%= cliente.getIdCliente()%></td>
                            <td><%= cliente.getDni()%></td>
                            <td><%= cliente.getNombres()%></td>
                            <td><%= cliente.getApellidos()%></td>
                            <td><%= cliente.getDireccion()%></td>
                            <td><%= cliente.getTelefono()%></td>
                            <td><%= cliente.getCorreo()%></td>
                            <td class="estado"><%= cliente.getEstado()%></td>

                            <td>
                                <a class="btn-editar" href="editarCliente.jsp?id=<%= cliente.getIdCliente()%>">Editar</a>
                                <a class="btn-eliminar" href="cliente?accion=eliminar&id=<%= cliente.getIdCliente()%>"
                                   onclick="return confirm('¿Está seguro de eliminar este cliente?');">Eliminar</a>
                            </td>

                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <% }%>
            </div>
        </div>

    </body>
</html>