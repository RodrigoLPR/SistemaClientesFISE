<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%@page import="com.ayf.sistemaclientesfise.model.Cliente"%>
<%@page import="java.util.List"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Leemos las variables enviadas desde el ClienteServlet
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    Integer paginaActual = (Integer) request.getAttribute("paginaActual");
    Integer totalPaginas = (Integer) request.getAttribute("totalPaginas");

    // Control por si se accede directamente al JSP sin pasar por el Servlet
    if (clientes == null) {
        response.sendRedirect("cliente");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Clientes - FISE A&F</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #1e3a8a; }
        .sidebar a { color: #cfd8dc; transition: 0.3s; }
        .sidebar a:hover, .sidebar a.active { color: #ffffff; background-color: rgba(255,255,255,0.1); border-radius: 5px;}
        .table-container { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
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
                <li class="nav-item"><a class="nav-link active text-white fw-bold" href="cliente"><i class="fas fa-users me-2"></i> Gestión de Clientes</a></li>
                
                <% if (usuario != null && "Administrador".equals(usuario.getRol())) { %>
                    <li class="nav-item"><a class="nav-link" href="usuario"><i class="fas fa-user-gear me-2"></i> Registrar Gestor</a></li>
                <% } %>
                
                <li class="nav-item"><a class="nav-link" href="reportes.jsp"><i class="fas fa-chart-bar me-2"></i> Reportes</a></li>
                <li class="nav-item mt-4"><a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between pb-2 mb-4 border-bottom">
                <h1 class="h2 text-dark fw-bold">Listado de Clientes</h1>
            </div>

            <div class="mb-4">
                <input type="text" id="buscador" class="form-control" placeholder="Buscar por DNI, nombres o apellidos...">
            </div>

            <div class="table-container table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th><th>DNI</th><th>Nombres</th><th>Apellidos</th>
                            <th>Dirección</th><th>Distrito</th><th>Teléfono</th><th>Estado</th><th>Observación</th><th>Fecha</th><th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="cuerpoTabla">
                        <% if (clientes.isEmpty()) { %>
                            <tr><td colspan="11" class="text-center">No existen clientes registrados.</td></tr>
                        <% } else { %>
                            <% for (Cliente c : clientes) { %>
                            <tr>
                                <td><%= c.getIdCliente() %></td>
                                <td><%= c.getDni() %></td>
                                <td class="fw-bold"><%= c.getNombres() %></td>
                                <td><%= c.getApellidos() %></td>
                                <td><%= c.getDireccion() %></td>
                                <td><%= c.getDistrito() != null ? c.getDistrito() : "-" %></td>
                                <td><%= c.getTelefono() %></td>
                                <td>
                                    <span class="badge <%= c.getEstado().equals("Aprobado") ? "bg-success" : (c.getEstado().equals("Observado") ? "bg-danger" : "bg-warning") %>">
                                        <%= c.getEstado() %>
                                    </span>
                                </td>
                                <td class="text-muted small"><%= c.getObservacion() != null ? c.getObservacion() : "-" %></td>
                                <td class="text-muted small"><%= c.getFechaRegistro() != null ? c.getFechaRegistro() : "-" %></td>
                                <td>
                                    <a href="editarCliente.jsp?id=<%= c.getIdCliente() %>" class="btn btn-sm btn-primary"><i class="fas fa-edit"></i></a>
                                    
                                    <% if (usuario != null && "Administrador".equals(usuario.getRol())) { %>
                                        <a href="cliente?accion=eliminar&id=<%= c.getIdCliente() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar cliente?');"><i class="fas fa-trash"></i></a>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        <% } %>
                    </tbody>
                </table>

                <% if (totalPaginas > 1) { %>
                    <nav class="d-flex justify-content-center mt-4">
                        <ul class="pagination shadow-sm mb-0">
                            <li class="page-item <%= (paginaActual == 1) ? "disabled" : "" %>">
                                <a class="page-link" href="cliente?page=<%= paginaActual - 1 %>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo; Anterior</span>
                                </a>
                            </li>

                            <% for (int i = 1; i <= totalPaginas; i++) { %>
                                <li class="page-item <%= (i == paginaActual) ? "active" : "" %>">
                                    <a class="page-link" href="cliente?page=<%= i %>"><%= i %></a>
                                </li>
                            <% } %>

                            <li class="page-item <%= (paginaActual.equals(totalPaginas)) ? "disabled" : "" %>">
                                <a class="page-link" href="cliente?page=<%= paginaActual + 1 %>" aria-label="Next">
                                    <span aria-hidden="true">Siguiente &raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                <% } %>
            </div>
        </main>
    </div>
</div>

<script>
    document.getElementById('buscador').addEventListener('keyup', function() {
        let query = this.value;
        fetch('cliente?accion=buscar&query=' + encodeURIComponent(query))
            .then(response => response.text())
            .then(data => {
                document.getElementById('cuerpoTabla').innerHTML = data;
            });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>