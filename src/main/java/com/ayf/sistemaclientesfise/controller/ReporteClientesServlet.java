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
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Obtención de todos los registros desde la base de datos incluyendo los nuevos campos
        List<Cliente> clientes = clienteDAO.listarClientes();

        Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("Clientes FISE");

        // 1. Crear encabezados completos del Reporte Operativo Global
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("DNI");
        header.createCell(2).setCellValue("Nombres");
        header.createCell(3).setCellValue("Apellidos");
        header.createCell(4).setCellValue("Dirección");
        header.createCell(5).setCellValue("Distrito");     // <--- Recuperada para segmentación operativa
        header.createCell(6).setCellValue("Teléfono");
        header.createCell(7).setCellValue("Correo");
        header.createCell(8).setCellValue("Estado");
        header.createCell(9).setCellValue("Observación");
        header.createCell(10).setCellValue("Fecha Registro"); // <--- Añadida para trazabilidad gerencial

        int fila = 1;

        // 2. Llenar la matriz de datos iterando la lista completa
        for (Cliente cliente : clientes) {
            Row row = sheet.createRow(fila++);

            row.createCell(0).setCellValue(cliente.getIdCliente());
            row.createCell(1).setCellValue(cliente.getDni());
            row.createCell(2).setCellValue(cliente.getNombres());
            row.createCell(3).setCellValue(cliente.getApellidos());
            row.createCell(4).setCellValue(cliente.getDireccion());
            row.createCell(5).setCellValue(cliente.getDistrito() != null ? cliente.getDistrito() : "-");
            row.createCell(6).setCellValue(cliente.getTelefono());
            row.createCell(7).setCellValue(cliente.getCorreo());
            row.createCell(8).setCellValue(cliente.getEstado());
            row.createCell(9).setCellValue(cliente.getObservacion() != null ? cliente.getObservacion() : "");
            row.createCell(10).setCellValue(cliente.getFechaRegistro() != null ? cliente.getFechaRegistro() : "-");
        }

        // 3. Ajustar tamaño automático de todas las columnas (Índices del 0 al 10)
        for (int i = 0; i <= 10; i++) {
            sheet.autoSizeColumn(i);
        }

        // 4. Configurar las cabeceras HTTP binarias para forzar la descarga en el navegador
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=reporte_clientes_fise.xls");

        workbook.write(response.getOutputStream());
        workbook.close();
    }
}