<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Cliente"%>
<%@page import="java.util.List"%>
<%
    // Recuperamos los posibles resultados o errores enviados desde el ConsultaServlet
    Cliente cliente = (Cliente) request.getAttribute("clienteEncontrado");
    List<Cliente> listaMultiples = (List<Cliente>) request.getAttribute("listaClientesEncontrados");
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
            --text-muted: #cbd5e1; /* Slate 300 - Más claro para mayor contraste */
            --border-color: #475569; /* Slate 600 - Bordes más definidos */
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
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5);
            max-width: 650px;
            margin: 0 auto;
        }

        .sunat-tabs {
            border-bottom: 2px solid var(--border-color);
            background-color: #0f172a;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .sunat-tab-item {
            color: var(--text-muted);
            padding: 14px 20px;
            font-weight: 700;
            font-size: 0.95rem;
            display: inline-block;
            background: transparent;
            border: none;
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
            color: #ffffff;
            padding: 14px;
            font-size: 1.2rem;
            text-align: center;
            letter-spacing: 2px;
            font-weight: 600;
        }

        .form-control:focus {
            background-color: #0f172a;
            border-color: #3b82f6;
            color: #ffffff;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.4);
        }

        .btn-search {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            border: none;
            padding: 12px 30px;
            font-weight: 700;
            color: #ffffff;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.5);
        }

        .status-box {
            border-radius: 12px;
            padding: 24px;
            margin-top: 25px;
            border: 2px solid transparent;
        }

        /* Colores ultra legibles para los semáforos de estados */
        .status-Pendiente {
            background-color: rgba(251, 191, 36, 0.15);
            border-color: #f59e0b;
            color: #fef08a;
        }
        .status-Pendiente .state-title { color: #fbbf24 !important; }

        .status-Evaluado {
            background-color: rgba(56, 189, 248, 0.15);
            border-color: #0ea5e9;
            color: #e0f2fe;
        }
        .status-Evaluado .state-title { color: #38bdf8 !important; }

        .status-Aprobado {
            background-color: rgba(52, 211, 153, 0.15);
            border-color: #10b981;
            color: #ecfdf5;
        }
        .status-Aprobado .state-title { color: #34d399 !important; }

        .status-Observado {
            background-color: rgba(248, 113, 113, 0.15);
            border-color: #ef4444;
            color: #fef2f2;
        }
        .status-Observado .state-title { color: #f87171 !important; }

        .data-label {
            color: var(--text-muted);
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .data-value {
            color: #ffffff;
            font-weight: 600;
            font-size: 1.05rem;
        }

        .brand-icon {
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body>

    <div class="container text-center mb-4">
        <i class="fas fa-fire-flame-curved fa-3x brand-icon mb-2"></i>
        <h3 class="fw-bold text-white mb-1">A&F Gas Natural</h3>
        <p style="color: var(--text-muted); font-size: 1rem; font-weight: 500;">Consulta pública del estado de tu instalación FISE</p>
    </div>

    <div class="search-card">
        <div class="sunat-tabs">
            <span class="sunat-tab-item active"><i class="fas fa-id-card me-2"></i>Por Documento (DNI)</span>
        </div>

        <div class="p-4">
            <form action="consultatramite" method="post" autocomplete="off">
                <p class="text-start mb-2 text-white small fw-bold" style="font-size: 0.95rem;">Ingrese el número de DNI del titular:</p>
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
                <div class="alert alert-danger mt-4 bg-danger bg-opacity-30 border-danger text-white fw-bold" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> <%= error %>
                </div>
            <% } %>

            <% if (noEncontrado != null) { %>
                <div class="alert alert-warning mt-4 bg-warning bg-opacity-20 border-warning text-white fw-bold" role="alert">
                    <i class="fas fa-search-minus me-2"></i> <%= noEncontrado %>
                </div>
            <% } %>

            <%-- CASO 1: Múltiples registros detectados para un mismo DNI --%>
            <% if (listaMultiples != null && !listaMultiples.isEmpty()) { %>
                <div class="alert alert-info mt-4 bg-info bg-opacity-20 border-info text-white fw-bold" role="alert">
                    <i class="fas fa-circle-info me-2"></i> Se detectaron <strong><%= listaMultiples.size() %> solicitudes</strong> asociadas a este documento (Múltiples predios de instalación).
                </div>
                
                <% 
                    int contador = 1;
                    for (Cliente c : listaMultiples) { 
                        String est = c.getEstado();
                        String nomOculto = c.getNombres().substring(0, Math.min(c.getNombres().length(), 5)) + "*******************";
                        String dirOculta = c.getDireccion().substring(0, Math.min(c.getDireccion().length(), 6)) + "******************* - " + c.getDistrito();
                %>
                    <div class="status-box status-<%= est %> mt-3 text-start position-relative">
                        <span class="position-absolute top-0 end-0 badge bg-light text-dark fw-bold font-monospace m-3" style="font-size: 0.85rem;">PREDIO N° <%= contador++ %></span>
                        <div class="row g-3 mt-1">
                            <div class="col-md-6">
                                <div class="data-label">Titular del Beneficio:</div>
                                <div class="data-value text-uppercase text-white"><%= nomOculto %></div>
                            </div>
                            <div class="col-md-6">
                                <div class="data-label">Estado Técnico:</div>
                                <div class="data-value fw-bold text-uppercase state-title"><%= est %></div>
                            </div>
                            <div class="col-12">
                                <div class="data-label">Ubicación del Predio:</div>
                                <div class="data-value text-uppercase text-white"><%= dirOculta %></div>
                            </div>
                            <div class="col-12">
                                <div class="data-label mb-1">Detalle / Indicación de la Empresa:</div>
                                <div class="p-3 rounded bg-black bg-opacity-40 text-white font-monospace" style="font-size: 0.95rem; border-left: 3px solid currentColor;">
                                    <%= (c.getObservacion() != null && !c.getObservacion().trim().isEmpty()) ? c.getObservacion() : "Su trámite se encuentra siguiendo los canales regulares de evaluación técnica." %>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>

            <%-- CASO 2: Un único registro encontrado --%>
            <% } else if (cliente != null) { 
                String estado = cliente.getEstado();
                String nombreCompleto = cliente.getNombres() + " " + cliente.getApellidos();
                String nombreOculto = nombreCompleto.length() > 5 ? nombreCompleto.substring(0, 5) + "*******************" : nombreCompleto + "******";
                String direccionCompleta = cliente.getDireccion();
                String direccionOculta = direccionCompleta.length() > 6 ? direccionCompleta.substring(0, 6) + "******************* - " + cliente.getDistrito() : direccionCompleta + " - " + cliente.getDistrito();
            %>
                <div class="status-box status-<%= estado %>">
                    <div class="text-center mb-4 border-bottom border-secondary border-opacity-30 pb-3">
                        <p class="mb-1 text-uppercase small tracking-wider text-white opacity-80" style="font-weight: 600;">Estado del Trámite</p>
                        <% if ("Aprobado".equals(estado)) { %>
                            <h2 class="fw-bold mb-0 state-title"><i class="fas fa-circle-check me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } else if ("Observado".equals(estado)) { %>
                            <h2 class="fw-bold mb-0 state-title"><i class="fas fa-circle-exclamation me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } else if ("Evaluado".equals(estado)) { %>
                            <h2 class="fw-bold mb-0 state-title"><i class="fas fa-bars-progress me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } else { %>
                            <h2 class="fw-bold mb-0 state-title"><i class="fas fa-hourglass-half me-2"></i><%= estado.toUpperCase() %></h2>
                        <% } %>
                    </div>

                    <div class="row g-3 text-start">
                        <div class="col-md-6">
                            <div class="data-label">Titular del Beneficio:</div>
                            <div class="data-value text-uppercase text-white"><%= nombreOculto %></div>
                        </div>
                        <div class="col-md-6">
                            <div class="data-label">Documento Identidad:</div>
                            <div class="data-value text-white">DNI: ****<%= cliente.getDni().substring(4) %></div>
                        </div>
                        <div class="col-12">
                            <div class="data-label">Ubicación del Predio:</div>
                            <div class="data-value text-uppercase text-white"><%= direccionOculta %></div>
                        </div>
                        <div class="col-12 mt-3 pt-3 border-top border-secondary border-opacity-30">
                            <div class="data-label mb-1">Detalle / Indicación de la Empresa:</div>
                            <div class="p-3 rounded bg-black bg-opacity-40 text-white font-monospace" style="font-size: 0.95rem; border-left: 3px solid currentColor;">
                                <%= (cliente.getObservacion() != null && !cliente.getObservacion().trim().isEmpty()) ? cliente.getObservacion() : "Su trámite se encuentra siguiendo los canales regulares de evaluación técnica interna de FISE." %>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <div class="text-center mt-4">
        <a href="login.jsp" class="text-decoration-none text-white opacity-50 hover-opacity-100 small" style="font-weight: 500;"><i class="fas fa-lock me-1"></i>Acceso exclusivo personal autorizado</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>