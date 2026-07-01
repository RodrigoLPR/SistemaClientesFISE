<%-- sidebar.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="col-md-3 col-lg-2 d-md-block sidebar py-4 px-3" style="min-height: 100vh; background-color: #1e3a8a;">
    <div class="text-center mb-4 text-white">
        <i class="fas fa-fire fa-3x mb-2 text-warning"></i>
        <h5 class="fw-bold m-0">FISE - A&F</h5>
        <small class="text-white-50">Gestión de Clientes</small>
    </div>
    <ul class="nav flex-column gap-2 mt-4">
        <li class="nav-item">
            <a class="nav-link text-white" href="dashboard.jsp"><i class="fas fa-home me-2"></i> Dashboard</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="registroCliente.jsp"><i class="fas fa-user-plus me-2"></i> Registrar Cliente</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="gestionClientes.jsp"><i class="fas fa-users me-2"></i> Gestión de Clientes</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="reportes.jsp"><i class="fas fa-chart-bar me-2"></i> Reportes</a>
        </li>
        <li class="nav-item mt-4">
            <a class="nav-link text-danger fw-bold" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a>
        </li>
    </ul>
</nav>