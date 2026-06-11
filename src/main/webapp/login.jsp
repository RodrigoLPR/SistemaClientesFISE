<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Sistema Clientes FISE</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-box {
            width: 400px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 10px;
            color: #1f2937;
        }

        p {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 25px;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 6px;
            color: #374151;
            font-weight: bold;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
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

        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .footer {
            margin-top: 25px;
            font-size: 12px;
            color: #9ca3af;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>Sistema de Gestión de Clientes</h2>
        <p>FISE - A&F</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="post">
            <label>Usuario</label>
            <input type="text" name="username" placeholder="Ingrese su usuario" required>

            <label>Contraseña</label>
            <input type="password" name="password" placeholder="Ingrese su contraseña" required>

            <button type="submit">Iniciar Sesión</button>
        </form>

        <div class="footer">
            © 2026 A&F Gas Natural Construcción y Desarrollo E.I.R.L.
        </div>
    </div>

</body>
</html>