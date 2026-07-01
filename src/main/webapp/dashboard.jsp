<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%@page import="com.ayf.sistemaclientesfise.dao.ClienteDAO"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    ClienteDAO clienteDAO = new ClienteDAO();
    int totalClientes = clienteDAO.contarClientes();
    // Inyectamos las variables dinámicas de la Fase 1
    int totalAprobados = clienteDAO.contarPorEstado("Aprobado");
    int totalPendientesYObs = clienteDAO.contarPorEstado("Pendiente") + clienteDAO.contarPorEstado("Observado");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Sistema Clientes FISE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        /* Pequeños ajustes para la barra lateral */
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #1e3a8a; }
        .sidebar a { color: #cfd8dc; transition: 0.3s; }
        .sidebar a:hover { color: #ffffff; background-color: rgba(255,255,255,0.1); border-radius: 5px;}
        .card-stats { border-left: 4px solid #2563eb; transition: transform 0.2s;}
        .card-stats:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1);}
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
                <li class="nav-item">
                    <a class="nav-link active text-white fw-bold" href="dashboard.jsp">
                        <i class="fas fa-home me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="registroCliente.jsp">
                        <i class="fas fa-user-plus me-2"></i> Registrar Cliente
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="gestionClientes.jsp">
                        <i class="fas fa-users me-2"></i> Gestión de Clientes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="reportes.jsp">
                        <i class="fas fa-chart-bar me-2"></i> Reportes
                    </a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link text-danger" href="logout">
                        <i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión
                    </a>
                </li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-4 border-bottom">
                <h1 class="h2 text-dark fw-bold">Panel de Control</h1>
                <div class="d-flex align-items-center">
                    <span class="badge bg-primary fs-6 me-2"><i class="fas fa-user-circle"></i> <%= usuario.getUsername() %></span>
                    <span class="badge bg-secondary fs-6"><%= usuario.getRol() %></span>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card card-stats shadow-sm border-0 h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted text-uppercase mb-2">Clientes Registrados</h6>
                                    <h2 class="mb-0 fw-bold text-dark"><%= totalClientes %></h2>
                                </div>
                                <div class="bg-primary bg-opacity-10 p-3 rounded">
                                    <i class="fas fa-users fa-2x text-primary"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-stats shadow-sm border-0 h-100" style="border-left-color: #10b981;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted text-uppercase mb-2">Clientes Aprobados</h6>
                                    <h2 class="mb-0 fw-bold text-dark"><%= totalAprobados %></h2>
                                </div>
                                <div class="bg-success bg-opacity-10 p-3 rounded">
                                    <i class="fas fa-check-circle fa-2x text-success"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-stats shadow-sm border-0 h-100" style="border-left-color: #8b5cf6;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted text-uppercase mb-2">Pendientes / Obs.</h6>
                                    <h2 class="mb-0 fw-bold text-dark"><%= totalPendientesYObs %></h2>
                                </div>
                                <div class="bg-info bg-opacity-10 p-3 rounded">
                                    <i class="fas fa-exclamation-triangle fa-2x text-info"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>