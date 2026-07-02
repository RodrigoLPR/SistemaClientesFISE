<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema Clientes FISE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        :root {
            --bg-color: #0f172a; /* Slate 900 */
            --card-bg: #1e293b; /* Slate 800 */
            --text-muted: #94a3b8; /* Slate 400 */
            --border-color: #334155; /* Slate 700 */
        }

        body {
            background-color: var(--bg-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .login-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.2);
            padding: 40px 30px;
            width: 100%;
            max-width: 420px;
        }

        .brand-icon {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .form-label {
            color: #f1f5f9;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .input-group-text {
            background-color: #1e293b;
            border-color: var(--border-color);
            color: var(--text-muted);
        }

        .form-control {
            background-color: #0f172a;
            border-color: var(--border-color);
            color: #f8fafc;
        }

        .form-control:focus {
            background-color: #0f172a;
            border-color: #3b82f6;
            color: #f8fafc;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.25);
        }

        .form-control::placeholder {
            color: #475569;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            border: none;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        /* Botón secundario estilizado para la consulta ciudadana */
        .btn-consult {
            background-color: transparent;
            border: 1px solid #475569;
            color: #e2e8f0;
            padding: 11px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-consult:hover {
            background-color: #334155;
            border-color: #64748b;
            color: #ffffff;
        }

        .alert-danger {
            background-color: rgba(239, 68, 68, 0.2);
            border-color: rgba(239, 68, 68, 0.4);
            color: #fca5a5;
            font-size: 0.9rem;
            border-radius: 8px;
        }

        .footer {
            margin-top: 25px;
            font-size: 11px;
            color: #64748b;
            text-align: center;
            line-height: 1.4;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="text-center mb-4">
            <div class="mb-2">
                <i class="fas fa-fire-flame-curved fa-3x brand-icon"></i>
            </div>
            <h4 class="fw-bold text-white mb-1">Sistema de Gestión de Clientes</h4>
            <p style="color: var(--text-muted); font-size: 0.95rem; font-weight: 500;">FISE - A&F</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger d-flex align-items-center mb-3" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <div>
                    <%= request.getAttribute("error") %>
                </div>
            </div>
        <% } %>

        <form action="login" method="post">
            
            <div class="mb-3">
                <label for="username" class="form-label">Usuario</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control" id="username" name="username" 
                           placeholder="Ingrese su usuario" required autocomplete="username">
                </div>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label">Contraseña</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Ingrese su contraseña" required autocomplete="current-password">
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-sign-in-alt me-2"></i> Iniciar Sesión
                </button>
            </div>
            
        </form>

        <div class="d-flex align-items-center my-3 opacity-20">
            <hr class="flex-grow-1 text-secondary">
            <span class="mx-2 text-muted small font-monospace">O</span>
            <hr class="flex-grow-1 text-secondary">
        </div>

        <div class="d-grid">
            <a href="consultatramite" class="btn btn-consult text-decoration-none text-center rounded">
                <i class="fas fa-magnifying-glass text-warning me-2"></i> Consultar Estado de Trámite
            </a>
        </div>

        <div class="footer">
            © 2026 A&F Gas Natural Construcción y Desarrollo E.I.R.L.
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>