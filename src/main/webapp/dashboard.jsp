<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%@page import="com.ayf.sistemaclientesfise.dao.ClienteDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    ClienteDAO clienteDAO = new ClienteDAO();
    int totalClientes = clienteDAO.contarClientes();
    int totalAprobados = clienteDAO.contarPorEstado("Aprobado");
    int totalPendientes = clienteDAO.contarPorEstado("Pendiente");
    int totalObservados = clienteDAO.contarPorEstado("Observado");
    
    // Carga de mapas estadísticos desde el DAO
    Map<String, Integer> datosFecha = clienteDAO.obtenerRegistrosPorFecha();
    Map<String, Integer> datosDistrito = clienteDAO.obtenerPublicoPorDistrito();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Sistema Clientes FISE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #1e3a8a; }
        .sidebar a { color: #cfd8dc; transition: 0.3s; }
        .sidebar a:hover, .sidebar a.active { color: #ffffff; background-color: rgba(255,255,255,0.1); border-radius: 5px;}
        .card-stats { border-left: 4px solid #2563eb; transition: transform 0.2s;}
        .card-stats:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05);}
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
                <li><a class="nav-link active text-white fw-bold" href="dashboard.jsp"><i class="fas fa-home me-2"></i> Dashboard</a></li>
                <li><a class="nav-link" href="registroCliente.jsp"><i class="fas fa-user-plus me-2"></i> Registrar Cliente</a></li>
                <li><a class="nav-link" href="cliente"><i class="fas fa-users me-2"></i> Gestión de Clientes</a></li>
                
                <% if (usuario != null && "Administrador".equals(usuario.getRol())) { %>
                    <li><a class="nav-link" href="usuario"><i class="fas fa-user-gear me-2"></i> Registrar Gestor</a></li>
                <% } %>
                
                <li><a class="nav-link" href="reportes.jsp"><i class="fas fa-chart-bar me-2"></i> Reportes</a></li>
                <li><a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between pb-2 mb-4 border-bottom">
                <h1 class="h2 text-dark fw-bold">Panel de Control</h1>
                <div class="d-flex align-items-center gap-2">
                    <span class="badge bg-primary fs-6"><i class="fas fa-user-circle me-1"></i> <%= usuario.getUsername() %></span>
                    
                    <% if (usuario != null && "Administrador".equals(usuario.getRol())) { %>
                        <span class="badge bg-danger fs-6 fw-bold"><i class="fas fa-user-shield me-1"></i> Administrador</span>
                    <% } else { %>
                        <span class="badge bg-success fs-6 fw-bold"><i class="fas fa-user-tag me-1"></i> Gestor</span>
                    <% } %>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="card card-stats shadow-sm border-0 p-3" style="border-left-color: #2563eb;">
                        <div class="d-flex justify-content-between align-items-center">
                            <div><h6 class="text-muted small text-uppercase fw-bold">Total</h6><h2 class="fw-bold mb-0 text-dark"><%= totalClientes %></h2></div>
                            <div class="bg-primary bg-opacity-10 p-3 rounded text-primary"><i class="fas fa-users fa-xl"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-stats shadow-sm border-0 p-3" style="border-left-color: #10b981;">
                        <div class="d-flex justify-content-between align-items-center">
                            <div><h6 class="text-muted small text-uppercase fw-bold">Aprobados</h6><h2 class="fw-bold mb-0 text-dark"><%= totalAprobados %></h2></div>
                            <div class="bg-success bg-opacity-10 p-3 rounded text-success"><i class="fas fa-check-circle fa-xl"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-stats shadow-sm border-0 p-3" style="border-left-color: #ffc107;">
                        <div class="d-flex justify-content-between align-items-center">
                            <div><h6 class="text-muted small text-uppercase fw-bold">Pendientes</h6><h2 class="fw-bold mb-0 text-dark"><%= totalPendientes %></h2></div>
                            <div class="bg-warning bg-opacity-10 p-3 rounded text-warning"><i class="fas fa-clock fa-xl"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-stats shadow-sm border-0 p-3" style="border-left-color: #dc3545;">
                        <div class="d-flex justify-content-between align-items-center">
                            <div><h6 class="text-muted small text-uppercase fw-bold">Observados</h6><h2 class="fw-bold mb-0 text-dark"><%= totalObservados %></h2></div>
                            <div class="bg-danger bg-opacity-10 p-3 rounded text-danger"><i class="fas fa-exclamation-triangle fa-xl"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-lg-6">
                    <div class="card shadow-sm border-0 p-4 mb-4">
                        <h6 class="text-muted fw-bold mb-3"><i class="fas fa-chart-pie me-2 text-primary"></i>Distribución de Estados</h6>
                        <div class="d-flex justify-content-center">
                            <canvas id="graficoEstados" style="max-height: 230px;"></canvas>
                        </div>
                    </div>
                    <div class="card shadow-sm border-0 p-4">
                        <h6 class="text-muted fw-bold mb-3"><i class="fas fa-calendar-day me-2 text-info"></i>Picos de Registro Diario</h6>
                        <canvas id="graficoFechas" style="max-height: 200px;"></canvas>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="card shadow-sm border-0 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3"><i class="fas fa-map-location-dot me-2 text-success"></i>Público Objetivo por Distrito (GAS)</h6>
                        <canvas id="graficoDistritos"></canvas>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    // 1. Gráfico de Dona: Estados Separados
    const ctxEst = document.getElementById('graficoEstados').getContext('2d');
    new Chart(ctxEst, {
        type: 'doughnut',
        data: {
            labels: ['Aprobados', 'Pendientes', 'Observados'],
            datasets: [{
                data: [<%= totalAprobados %>, <%= totalPendientes %>, <%= totalObservados %>],
                backgroundColor: ['#10b981', '#ffc107', '#dc3545'],
                hoverOffset: 8
            }]
        },
        options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
    });

    // 2. Gráfico de Líneas: Registros por Fecha
    const ctxFech = document.getElementById('graficoFechas').getContext('2d');
    new Chart(ctxFech, {
        type: 'line',
        data: {
            labels: [<%= datosFecha.keySet().stream().map(f -> "'" + f + "'").collect(Collectors.joining(",")) %>],
            datasets: [{
                label: 'Altas de Clientes',
                data: [<%= datosFecha.values().stream().map(String::valueOf).collect(Collectors.joining(",")) %>],
                borderColor: '#0284c7',
                backgroundColor: 'rgba(2, 132, 199, 0.1)',
                fill: true,
                tension: 0.3
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });

    // 3. Gráfico de Barras Horizontales: Nicho por Distritos
    const ctxDist = document.getElementById('graficoDistritos').getContext('2d');
    new Chart(ctxDist, {
        type: 'bar',
        data: {
            labels: [<%= datosDistrito.keySet().stream().map(d -> "'" + d + "'").collect(Collectors.joining(",")) %>],
            datasets: [{
                label: 'Cantidad de Clientes',
                data: [<%= datosDistrito.values().stream().map(String::valueOf).collect(Collectors.joining(",")) %>],
                backgroundColor: '#1e3a8a',
                borderRadius: 5
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            plugins: { legend: { display: false } }
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>