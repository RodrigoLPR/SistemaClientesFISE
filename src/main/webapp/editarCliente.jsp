<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%@page import="com.ayf.sistemaclientesfise.model.Cliente"%>
<%@page import="com.ayf.sistemaclientesfise.dao.ClienteDAO"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idCliente = Integer.parseInt(request.getParameter("id"));

    ClienteDAO clienteDAO = new ClienteDAO();
    Cliente cliente = clienteDAO.obtenerClientePorId(idCliente);

    if (cliente == null) {
        response.sendRedirect("gestionClientes.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Cliente - Sistema Clientes FISE</title>
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
            max-width: 850px;
        }

        h1 {
            margin-top: 0;
            color: #111827;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #374151;
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 11px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .full {
            grid-column: 1 / 3;
        }

        button {
            margin-top: 25px;
            padding: 12px 25px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .volver {
            display: inline-block;
            margin-top: 25px;
            margin-left: 10px;
            padding: 12px 25px;
            background: #6b7280;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
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
            <h1>Editar Cliente</h1>
            <p>Actualice los datos del cliente seleccionado.</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="cliente" method="post">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idCliente" value="<%= cliente.getIdCliente() %>">

                <div class="form-grid">
                    <div>
                        <label>DNI</label>
                        <input type="text" name="dni" maxlength="8" value="<%= cliente.getDni() %>" required>
                    </div>

                    <div>
                        <label>Teléfono</label>
                        <input type="text" name="telefono" value="<%= cliente.getTelefono() %>">
                    </div>

                    <div>
                        <label>Nombres</label>
                        <input type="text" name="nombres" value="<%= cliente.getNombres() %>" required>
                    </div>

                    <div>
                        <label>Apellidos</label>
                        <input type="text" name="apellidos" value="<%= cliente.getApellidos() %>" required>
                    </div>

                    <div class="full">
                        <label>Dirección</label>
                        <input type="text" name="direccion" value="<%= cliente.getDireccion() %>" required>
                    </div>

                    <div>
                        <label>Correo</label>
                        <input type="email" name="correo" value="<%= cliente.getCorreo() %>">
                    </div>

                    <div>
                        <label>Estado</label>
                        <select name="estado" required>
                            <option value="Pendiente" <%= "Pendiente".equals(cliente.getEstado()) ? "selected" : "" %>>Pendiente</option>
                            <option value="Evaluado" <%= "Evaluado".equals(cliente.getEstado()) ? "selected" : "" %>>Evaluado</option>
                            <option value="Aprobado" <%= "Aprobado".equals(cliente.getEstado()) ? "selected" : "" %>>Aprobado</option>
                            <option value="Observado" <%= "Observado".equals(cliente.getEstado()) ? "selected" : "" %>>Observado</option>
                        </select>
                    </div>
                </div>

                <button type="submit">Actualizar Cliente</button>
                <a class="volver" href="gestionClientes.jsp">Volver</a>
            </form>
        </div>
    </div>

</body>
</html>