package com.ayf.sistemaclientesfise.controller;

import com.ayf.sistemaclientesfise.dao.ClienteDAO;
import com.ayf.sistemaclientesfise.model.Cliente;
import com.ayf.sistemaclientesfise.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

@WebServlet(name = "ReporteClientesServlet", urlPatterns = {"/reporteClientes"})
public class ReporteClientesServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null);

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Cliente> clientes = clienteDAO.listarClientes();

        Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("Clientes FISE");

        // 1. Crear encabezados
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("DNI");
        header.createCell(2).setCellValue("Nombres");
        header.createCell(3).setCellValue("Apellidos");
        header.createCell(4).setCellValue("Direccion");
        header.createCell(5).setCellValue("Telefono");
        header.createCell(6).setCellValue("Correo");
        header.createCell(7).setCellValue("Estado");
        header.createCell(8).setCellValue("Observación"); // <--- Nueva columna

        int fila = 1;

        // 2. Llenar datos
        for (Cliente cliente : clientes) {
            Row row = sheet.createRow(fila++);

            row.createCell(0).setCellValue(cliente.getIdCliente());
            row.createCell(1).setCellValue(cliente.getDni());
            row.createCell(2).setCellValue(cliente.getNombres());
            row.createCell(3).setCellValue(cliente.getApellidos());
            row.createCell(4).setCellValue(cliente.getDireccion());
            row.createCell(5).setCellValue(cliente.getTelefono());
            row.createCell(6).setCellValue(cliente.getCorreo());
            row.createCell(7).setCellValue(cliente.getEstado());
            row.createCell(8).setCellValue(cliente.getObservacion() != null ? cliente.getObservacion() : ""); // <--- Nuevo dato
        }

        // 3. Ajustar tamaño de todas las columnas (ahora hasta la 8)
        for (int i = 0; i <= 8; i++) {
            sheet.autoSizeColumn(i);
        }

        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=reporte_clientes_fise.xls");

        workbook.write(response.getOutputStream());
        workbook.close();
    }
}