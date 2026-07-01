<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%@page import="com.ayf.sistemaclientesfise.model.Cliente"%>
<%@page import="com.ayf.sistemaclientesfise.dao.ClienteDAO"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int idCliente = Integer.parseInt(request.getParameter("id"));
    ClienteDAO clienteDAO = new ClienteDAO();
    Cliente cliente = clienteDAO.obtenerClientePorId(idCliente);
    if (cliente == null) {
        response.sendRedirect("gestionClientes.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Cliente - Sistema Clientes FISE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #1e3a8a; }
        .sidebar a { color: #cfd8dc; transition: 0.3s; }
        .sidebar a:hover { color: #ffffff; background-color: rgba(255,255,255,0.1); border-radius: 5px;}
        .form-container { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
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
                    <a class="nav-link active text-white fw-bold" href="gestionClientes.jsp"><i class="fas fa-users me-2"></i> Gestión de Clientes</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="reportes.jsp"><i class="fas fa-chart-bar me-2"></i> Reportes</a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión</a>
                </li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between pb-2 mb-4 border-bottom">
                <h1 class="h2 text-dark fw-bold">Editar Datos del Cliente</h1>
            </div>

            <div class="form-container">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                <% } %>

                <form action="cliente" method="post">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="idCliente" value="<%= cliente.getIdCliente() %>">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">DNI</label>
                            <input type="text" class="form-control" name="dni" value="<%= cliente.getDni() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Teléfono</label>
                            <input type="text" class="form-control" name="telefono" value="<%= cliente.getTelefono() %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Nombres</label>
                            <input type="text" class="form-control" name="nombres" value="<%= cliente.getNombres() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Apellidos</label>
                            <input type="text" class="form-control" name="apellidos" value="<%= cliente.getApellidos() %>" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Dirección</label>
                            <input type="text" class="form-control" name="direccion" value="<%= cliente.getDireccion() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Correo</label>
                            <input type="email" class="form-control" name="correo" value="<%= cliente.getCorreo() %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Estado</label>
                            <select class="form-select" name="estado" required>
                                <option value="Pendiente" <%= "Pendiente".equals(cliente.getEstado()) ? "selected" : "" %>>Pendiente</option>
                                <option value="Evaluado" <%= "Evaluado".equals(cliente.getEstado()) ? "selected" : "" %>>Evaluado</option>
                                <option value="Aprobado" <%= "Aprobado".equals(cliente.getEstado()) ? "selected" : "" %>>Aprobado</option>
                                <option value="Observado" <%= "Observado".equals(cliente.getEstado()) ? "selected" : "" %>>Observado</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Observación</label>
                            <textarea class="form-control" name="observacion" rows="3"><%= cliente.getObservacion() != null ? cliente.getObservacion() : "" %></textarea>
                        </div>
                    </div>

                    <hr class="my-4">

                    <div class="d-flex justify-content-end gap-2">
                        <a href="gestionClientes.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left me-1"></i> Volver</a>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i> Actualizar Cliente</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>