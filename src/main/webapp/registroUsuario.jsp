<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"Administrador".equals(usuario.getRol())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Gestor - FISE A&F</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #1e3a8a; }
        .sidebar a { color: #cfd8dc; transition: 0.3s; }
        .sidebar a:hover, .sidebar a.active { color: #ffffff; background-color: rgba(255,255,255,0.1); border-radius: 5px;}
        .form-container { background: white; padding: 35px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); max-width: 500px; }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-3 col-lg-2 d-md-block sidebar py-4 px-3">
            <div class="text-center mb-4 text-white">
                <i class="fas fa-fire-flame-curved fa-3x mb-2 text-warning"></i>
                <h5 class="fw-bold">FISE - A&F</h5>
            </div>
            <ul class="nav flex-column gap-2 mt-4">
                <li class="nav-item"><a class="nav-link" href="dashboard.jsp"><i class="fas fa-home me-2"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="registroCliente.jsp"><i class="fas fa-user-plus me-2"></i> Registrar Cliente</a></li>
                <li class="nav-item"><a class="nav-link" href="cliente"><i class="fas fa-users me-2"></i> Gestión de Clientes</a></li>
                <li class="nav-item"><a class="nav-link active text-white fw-bold" href="usuario"><i class="fas fa-user-gear me-2"></i> Registrar Gestor</a></li>
                <li class="nav-item"><a class="nav-link" href="reportes.jsp"><i class="fas fa-chart-bar me-2"></i> Reportes</a></li>
                <li class="nav-item mt-4"><a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 d-flex flex-column align-items-center">
            <div class="w-100 pb-2 mb-4 border-bottom text-start">
                <h1 class="h2 text-dark fw-bold">Configuración del Sistema</h1>
            </div>

            <div class="form-container w-100 mt-3">
                <div class="text-center mb-4">
                    <i class="fas fa-user-shield fa-2x text-primary mb-2"></i>
                    <h4 class="fw-bold">Registrar Nuevo Usuario Gestor</h4>
                    <p class="text-muted small">Los usuarios creados tendrán permisos de registro y edición, sin privilegios de eliminación.</p>
                </div>

                <% if (request.getAttribute("mensajeExito") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i> <%= request.getAttribute("mensajeExito") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <% if (request.getAttribute("mensajeError") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i> <%= request.getAttribute("mensajeError") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <form action="usuario" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-bold">Nombre de Usuario (Login)</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user-edit text-muted"></i></span>
                            <input type="text" class="form-control" id="username" name="username" placeholder="ej. juan.perez" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label fw-bold">Contraseña Asignada</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-key text-muted"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Defina una contraseña segura" required>
                        </div>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary py-2 fw-bold">
                            <i class="fas fa-save me-2"></i> Guardar Gestor
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>