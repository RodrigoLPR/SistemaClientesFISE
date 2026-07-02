<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Cliente"%>
<%
    // Recuperamos los posibles resultados o errores enviados desde el ConsultaServlet
    Cliente cliente = (Cliente) request.getAttribute("clienteEncontrado");
    String noEncontrado = (String) request.getAttribute("noEncontrado");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta de Trámite FISE - A&F Gas</title>
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
            color: #f8fafc;
            padding: 40px 15px;
        }

        .search-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
            max-width: 650px;
            margin: 0 auto;
        }

        .sunat-tabs {
            border-bottom: 2px solid var(--border-color);
            background-color: #111827;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .sunat-tab-item {
            color: var(--text-muted);
            padding: 12px 20px;
            font-weight: 600;
            font-size: 0.9rem;
            border-right: 1px solid var(--border-color);
            display: inline-block;
            background: transparent;
            border-top: none;
            border-left: none;
            border-bottom: none;
        }

        .sunat-tab-item.active {
            color: #ffffff;
            background-color: var(--card-bg);
            position: relative;
        }

        .sunat-tab-item.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #3b82f6;
        }

        .form-control {
            background-color: #0f172a;
            border-color: var(--border-color);
            color: #f8fafc;
            padding: 14px;
            font-size: 1.1rem;
            text-align: center;
            letter-spacing: 2px;
        }

        .form-control:focus {
            background-color: #0f172a;
            border-color: #3b82f6;
            color: #f8fafc;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
        }

        .btn-search {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            border: none;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        /* Estilos amenos para los Semáforos de Estados */
        .status-box {
            border-radius: 12px;
            padding: 20px;
            margin-top: 25px;
            border: 1px solid transparent;
        }

        .status-Pendiente {
            background-color: rgba(234, 179, 8, 0.1);
            border-color: rgba(234, 179, 8, 0.3);
            color: #fef08a;
        }

        .status-Evaluado {
            background-color: rgba(59, 130, 246, 0.1);
            border-color: rgba(59, 130, 246, 0.3);
            color: #bfdbfe;
        }

        .status-Aprobado {
            background-color: rgba(16, 185, 129, 0.1);
            border-color: rgba(16, 185, 129, 0.3);
            color: #a7f3d0;
        }

        .status-Observado {
            background-color: rgba(239, 68, 68, 0.1);
            border-color: rgba(239, 68, 68, 0.3);
            color: #fecaca;
        }

        .data-label {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-uppercase: true;
            font-weight: 600;
        }

        .data-value {
            color: #f1f5f9;
            font-weight: 500;
        }

        .brand-icon {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body>

    <div class="container text-center mb-4">
        <i class="fas fa-fire-flame-curved fa-3x brand-icon mb-2"></i>
        <h3 class="fw-bold text-white mb-1">A&F Gas Natural</h3>
        <p style="color: var(--text-muted); font-size: 0.95rem;">Consulta pública del estado de tu instalación FISE</p>
    </div>

    <div class="search-card">
        <div class="sunat-tabs">
            <span class="sunat-tab-item active"><i class="fas fa-id-card me-2"></i>Por Documento (DNI)</span>
        </div>

        <div class="p-4">
            <form action="consultatramite" method="post" autocomplete="off">
                <p class="text-start mb-2 text-slate-300 small fw-bold">Ingrese el número de DNI del titular:</p>
                <div class="row g-2">
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="dni" maxlength="8" 
                               placeholder="00000000" required 
                               oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    </div>
                    <div class="col-sm-4 d-grid">
                        <button type="submit" class="btn btn-primary btn-search">
                            <i class="fas fa-search me-2"></i>Buscar
                        </button>
                    </div>
                </div>
            </form>

            <% if (error != null) { %>
                <div class="alert alert-danger mt-4 bg-danger bg-opacity-20 border-danger text-danger-subtitle border-opacity-40" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> <%= error %>
                </div>
            <% } %>

            <% if (noEncontrado != null) { %>
                <div class="alert alert-warning mt-4 bg-warning bg-opacity-10 border-warning text-warning border-opacity-30" role="alert">
                    <i class="fas fa-search-minus me-2"></i> <%= noEncontrado %>
                </div>
            <% } %>

            <% if (cliente != null) { 
                String estado = cliente.getEstado();
                
                // Lógica de Enmascaramiento de Privacidad
                String nombreCompleto = cliente.getNombres() + " " + cliente.getApellidos();
                String nombreOculto = "";
                if(nombreCompleto.length() > 5) {
                    nombreOculto = nombreCompleto.substring(0, 5) + "*******************";
                } else {
                    nombreOculto = nombreCompleto + "******";
                }

                String direccionCompleta = cliente.getDireccion();
                String direccionOculta = "";
                if(direccionCompleta.length() > 6) {
                    direccionOculta = direccionCompleta.substring(0, 6) + "******************* - " + cliente.getDistrito();
                } else {
                    direccionOculta = direccionCompleta + " - " + cliente.getDistrito();
                }
            %>
                <div class="status-box status-<%= estado %> animate__animated animate__fadeIn">
                    <div class="text-center mb-4 border-bottom border-secondary border-opacity-20 pb-3">
                        <p class="mb-1 text-uppercase small tracking-wider opacity-70">Estado del Trámite</p>
                        
                        <% if ("Aprobado".equals(estado)) { %>
                            <h2 class="fw-bold mb-0 text-success"><i class="fas fa-circle-check me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } else if ("Observado".equals(estado)) { %>
                            <h2 class="fw-bold mb-0 text-danger"><i class="fas fa-circle-exclamation me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } else if ("Evaluado".equals(estado)) { %>
                            <h2 class="fw-bold mb-0 text-info"><i class="fas fa-bars-progress me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } else { %>
                            <h2 class="fw-bold mb-0 text-warning"><i class="fas fa-hourglass-half me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } %>
                    </div>

                    <div class="row g-3 text-start small">
                        <div class="col-md-6">
                            <div class="data-label">Titular del Beneficio:</div>
                            <div class="data-value text-uppercase"><%= nombreOculto %></div>
                        </div>
                        <div class="col-md-6">
                            <div class="data-label">Documento Identidad:</div>
                            <div class="data-value">DNI: ****<%= cliente.getDni().substring(4) %></div>
                        </div>
                        <div class="col-12">
                            <div class="data-label">Ubicación del Predio:</div>
                            <div class="data-value text-uppercase"><%= direccionOculta %></div>
                        </div>
                        
                        <div class="col-12 mt-3 pt-3 border-top border-secondary border-opacity-20">
                            <div class="data-label mb-1">Detalle / Indicación de la Empresa:</div>
                            <div class="p-3 rounded bg-black bg-opacity-20 text-white font-monospace small">
                                <%= (cliente.getObservacion() != null && !cliente.getObservacion().trim().isEmpty()) 
                                    ? cliente.getObservacion() 
                                    : "Su trámite se encuentra siguiendo los canales regulares de evaluación técnica interna de FISE." %>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <div class="text-center mt-4">
        <a href="login.jsp" class="text-decoration-none text-muted small hover-white"><i class="fas fa-lock me-1"></i>Acceso exclusivo personal autorizado</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>