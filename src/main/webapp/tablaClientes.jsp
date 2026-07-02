<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.ayf.sistemaclientesfise.model.Cliente"%>
<%@page import="com.ayf.sistemaclientesfise.model.Usuario"%>
<%@page import="java.util.List"%>
<%
    // Recuperamos el usuario de la sesión para validar los permisos en la búsqueda AJAX
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");

    List<Cliente> lista = (List<Cliente>) request.getAttribute("listaClientes");
    if (lista != null && !lista.isEmpty()) {
        for(Cliente c : lista) {
%>
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
        
        <% if (usuarioLogueado != null && "Administrador".equals(usuarioLogueado.getRol())) { %>
            <a href="cliente?accion=eliminar&id=<%= c.getIdCliente() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar cliente?');"><i class="fas fa-trash"></i></a>
        <% } %>
    </td>
</tr>
<% 
        }
    } else {
%>
<tr><td colspan="11" class="text-center">No se encontraron resultados.</td></tr>
<% } %>