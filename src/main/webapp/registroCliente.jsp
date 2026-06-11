<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Cliente - Sistema Clientes FISE</title>
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

        .mensaje {
            background: #dcfce7;
            color: #166534;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
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
            <h1>Registrar Cliente</h1>
            <p>Complete los datos del potencial cliente FISE.</p>

            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="mensaje"><%= request.getAttribute("mensaje") %></div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="cliente" method="post">
                <div class="form-grid">
                    <div>
                        <label>DNI</label>
                        <input type="text" name="dni" maxlength="8" required>
                    </div>

                    <div>
                        <label>Teléfono</label>
                        <input type="text" name="telefono">
                    </div>

                    <div>
                        <label>Nombres</label>
                        <input type="text" name="nombres" required>
                    </div>

                    <div>
                        <label>Apellidos</label>
                        <input type="text" name="apellidos" required>
                    </div>

                    <div class="full">
                        <label>Dirección</label>
                        <input type="text" name="direccion" required>
                    </div>

                    <div>
                        <label>Correo</label>
                        <input type="email" name="correo">
                    </div>

                    <div>
                        <label>Estado</label>
                        <select name="estado" required>
                            <option value="Pendiente">Pendiente</option>
                            <option value="Evaluado">Evaluado</option>
                            <option value="Aprobado">Aprobado</option>
                            <option value="Observado">Observado</option>
                        </select>
                    </div>
                </div>

                <button type="submit">Registrar Cliente</button>
            </form>
        </div>
    </div>

</body>
</html>