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
    <title>Reportes - Sistema Clientes FISE</title>
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

        p {
            color: #4b5563;
        }

        .card {
            margin-top: 25px;
            padding: 25px;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background: #f9fafb;
        }

        .card h3 {
            margin-top: 0;
            color: #111827;
        }

        .button {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 22px;
            background: #16a34a;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .button:hover {
            background: #15803d;
        }

        .nota {
            margin-top: 20px;
            padding: 14px;
            background: #eff6ff;
            color: #1e40af;
            border-radius: 8px;
            font-size: 14px;
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
            <h1>Reportes</h1>
            <p>Generación de reportes del registro de potenciales clientes FISE.</p>

            <div class="card">
                <h3>Reporte de Clientes Registrados</h3>
                <p>Permite exportar en formato Excel la información de los clientes registrados en el sistema.</p>

                <a class="button" href="reporteClientes">Exportar a Excel</a>
            </div>

            <div class="nota">
                Esta funcionalidad utilizará la librería Apache POI para generar archivos Excel desde Java.
            </div>
        </div>
    </div>

</body>
</html>