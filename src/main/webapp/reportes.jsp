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
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes - Sistema Clientes FISE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #1e3a8a; }
        .sidebar a { color: #cfd8dc; transition: 0.3s; }
        .sidebar a:hover, .sidebar a.active { color: #ffffff; background-color: rgba(255,255,255,0.1); border-radius: 5px;}
        .card { border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; }
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
                    <a class="nav-link" href="dashboard.jsp"><i class="fas fa-home me-2"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="registroCliente.jsp"><i class="fas fa-user-plus me-2"></i> Registrar Cliente</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cliente"><i class="fas fa-users me-2"></i> Gestión de Clientes</a>
                </li>
                
                <% if (usuario != null && "Administrador".equals(usuario.getRol())) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="usuario"><i class="fas fa-user-gear me-2"></i> Registrar Gestor</a>
                    </li>
                <% } %>
                
                <li class="nav-item">
                    <a class="nav-link active text-white fw-bold" href="reportes.jsp"><i class="fas fa-chart-bar me-2"></i> Reportes</a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a>
                </li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between pb-2 mb-4 border-bottom">
                <h1 class="h2 text-dark fw-bold">Módulo de Exportación y Reportes</h1>
            </div>
            
            <p class="text-muted mb-4">Generación y descarga de documentos de control del padrón de potenciales beneficiarios del programa FISE.</p>

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card p-4 h-100">
                        <h4 class="fw-bold text-dark mb-3"><i class="fas fa-file-excel text-success me-2"></i> Formato Excel Operativo</h4>
                        <p class="text-muted">Exporta el listado plano completo de clientes con matrices de datos abiertas. Ideal para analistas de datos, filtros manuales y labores de digitación.</p>
                        <div class="mt-auto">
                            <a class="btn btn-success" href="reporteClientes"><i class="fas fa-download me-2"></i> Descargar Excel (.XLS)</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card p-4 h-100">
                        <h4 class="fw-bold text-dark mb-3"><i class="fas fa-file-pdf text-danger me-2"></i> Formato PDF Gerencial</h4>
                        <p class="text-muted">Genera un documento inalterable con membrete institucional, marcas de tiempo y diseño horizontal (Landscape). Ideal para auditorías o entrega directa a gerencia.</p>
                        <div class="mt-auto">
                            <a class="btn btn-danger" href="reportePdf"><i class="fas fa-file-download me-2"></i> Descargar PDF Formal</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-4 p-3 bg-light border">
                <h6 class="fw-bold text-secondary mb-2"><i class="fas fa-gears me-2"></i>Especificaciones Técnicas del Motor de Reportes:</h6>
                <ul class="text-muted small mb-0 ps-3">
                    <li>La descarga operativa procesa datos binarios de celdas mediante la librería **Apache POI**.</li>
                    <li>La exportación institucional utiliza flujos de documentos estructurados mediante el motor **OpenPDF** compatible con Jakarta EE.</li>
                </ul>
            </div>

        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>