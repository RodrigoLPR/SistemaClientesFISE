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
        Usuario usuario = null;

        if (session != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        }

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Cliente> clientes = clienteDAO.listarClientes();

        Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("Clientes FISE");

        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("DNI");
        header.createCell(2).setCellValue("Nombres");
        header.createCell(3).setCellValue("Apellidos");
        header.createCell(4).setCellValue("Direccion");
        header.createCell(5).setCellValue("Telefono");
        header.createCell(6).setCellValue("Correo");
        header.createCell(7).setCellValue("Estado");

        int fila = 1;

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
        }

        for (int i = 0; i <= 7; i++) {
            sheet.autoSizeColumn(i);
        }

        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=reporte_clientes_fise.xls");

        workbook.write(response.getOutputStream());
        workbook.close();
    }
}