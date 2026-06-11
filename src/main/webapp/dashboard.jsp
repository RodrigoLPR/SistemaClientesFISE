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
    <title>Dashboard - Sistema Clientes FISE</title>
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

        .topbar {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .cards {
            display: flex;
            gap: 20px;
        }

        .card {
            background: white;
            width: 220px;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .card h3 {
            margin: 0;
            color: #111827;
            font-size: 18px;
        }

        .card p {
            font-size: 28px;
            font-weight: bold;
            color: #2563eb;
            margin-bottom: 0;
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
        <div class="topbar">
            <h1>Dashboard</h1>
            <p>Usuario conectado: <strong><%= usuario.getUsername() %></strong> | Rol: <strong><%= usuario.getRol() %></strong></p>
        </div>

        <div class="cards">
            <div class="card">
                <h3>Clientes Registrados</h3>
                <p>0</p>
            </div>

            <div class="card">
                <h3>Reportes Generados</h3>
                <p>0</p>
            </div>

            <div class="card">
                <h3>Usuarios Activos</h3>
                <p>1</p>
            </div>
        </div>
    </div>

</body>
</html>