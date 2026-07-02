package com.ayf.sistemaclientesfise.controller;

import com.ayf.sistemaclientesfise.dao.ClienteDAO;
import com.ayf.sistemaclientesfise.model.Cliente;
import com.ayf.sistemaclientesfise.model.Usuario;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Color;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ReportePdfServlet", urlPatterns = {"/reportePdf"})
public class ReportePdfServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Control de acceso administrativo estrictamente igual al Excel
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Configurar cabeceras de respuesta HTTP para PDF inalterable
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=reporte_gerencial_fise.pdf");

        // 3. Crear el documento en orientación HORIZONTAL (Landscape) con márgenes limpios
        Document document = new Document(PageSize.A4.rotate(), 30, 30, 30, 30);

        try {
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // --- ESTILOS DE FUENTES ---
            Font fontEmpresa = new Font(Font.HELVETICA, 14, Font.BOLD, new Color(245, 158, 11)); // Ámbar/Naranja
            Font fontTitulo = new Font(Font.HELVETICA, 16, Font.BOLD, new Color(15, 23, 42));    // Slate 900
            Font fontSub = new Font(Font.HELVETICA, 10, Font.ITALIC, new Color(100, 116, 139)); // Slate 500
            Font fontHeader = new Font(Font.HELVETICA, 9, Font.BOLD, Color.WHITE);
            Font fontBody = new Font(Font.HELVETICA, 8, Font.NORMAL, new Color(51, 65, 85));

            // --- 4. MEMBRETADO FORMAL E INSTITUCIONAL ---
            Paragraph pEmpresa = new Paragraph("A&F GAS NATURAL CONSTRUCCIÓN Y DESARROLLO E.I.R.L.", fontEmpresa);
            pEmpresa.setAlignment(Element.ALIGN_LEFT);
            document.add(pEmpresa);

            Paragraph pTitulo = new Paragraph("SISTEMA DE GESTIÓN DE CLIENTES FISE - REPORTE GERENCIAL CONSOLIDADO", fontTitulo);
            pTitulo.setSpacingBefore(10);
            pTitulo.setAlignment(Element.ALIGN_CENTER);
            document.add(pTitulo);

            // Marca de tiempo de generación para auditoría gerencial utilizando getUsername()
            String fechaActual = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());
            Paragraph pMeta = new Paragraph("Generado por: " + usuario.getUsername() + "  |  Fecha de impresión: " + fechaActual, fontSub);
            pMeta.setSpacingAfter(20);
            pMeta.setAlignment(Element.ALIGN_CENTER);
            document.add(pMeta);

            // --- 5. ESTRUCTURA DE LA TABLA MATRIZ (11 Columnas Exactas) ---
            float[] columnWidths = {2.5f, 4.5f, 7.0f, 7.0f, 9.5f, 5.5f, 4.5f, 8.5f, 5.0f, 10.0f, 6.0f};
            PdfPTable table = new PdfPTable(11);
            table.setWidthPercentage(100);
            table.setWidths(columnWidths);

            // Cabeceras de la Tabla (Estilo Blue-Slate corporativo)
            String[] headers = {"ID", "DNI", "NOMBRES", "APELLIDOS", "DIRECCIÓN", "DISTRITO", "TELÉFONO", "CORREO", "ESTADO", "OBSERVACIÓN", "F. REGISTRO"};
            Color colorHeaderBg = new Color(30, 41, 59); // Slate 800

            for (String columnHeader : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(columnHeader, fontHeader));
                cell.setBackgroundColor(colorHeaderBg);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setPadding(6);
                table.addCell(cell);
            }

            // --- 6. EXTRACCIÓN E INYECCIÓN DE LOS DATOS COMPLETOS ---
            List<Cliente> clientes = clienteDAO.listarClientes();
            boolean alternaColor = false;
            Color colorFilaPar = new Color(248, 250, 252);

            for (Cliente c : clientes) {
                table.addCell(crearCelda(String.valueOf(c.getIdCliente()), fontBody, alternaColor, colorFilaPar, Element.ALIGN_CENTER));
                table.addCell(crearCelda(c.getDni(), fontBody, alternaColor, colorFilaPar, Element.ALIGN_CENTER));
                table.addCell(crearCelda(c.getNombres(), fontBody, alternaColor, colorFilaPar, Element.ALIGN_LEFT));
                table.addCell(crearCelda(c.getApellidos(), fontBody, alternaColor, colorFilaPar, Element.ALIGN_LEFT));
                table.addCell(crearCelda(c.getDireccion(), fontBody, alternaColor, colorFilaPar, Element.ALIGN_LEFT));
                table.addCell(crearCelda(c.getDistrito() != null ? c.getDistrito() : "-", fontBody, alternaColor, colorFilaPar, Element.ALIGN_LEFT));
                table.addCell(crearCelda(c.getTelefono(), fontBody, alternaColor, colorFilaPar, Element.ALIGN_CENTER));
                table.addCell(crearCelda(c.getCorreo(), fontBody, alternaColor, colorFilaPar, Element.ALIGN_LEFT));
                table.addCell(crearCelda(c.getEstado(), fontBody, alternaColor, colorFilaPar, Element.ALIGN_CENTER));
                table.addCell(crearCelda(c.getObservacion() != null ? c.getObservacion() : "", fontBody, alternaColor, colorFilaPar, Element.ALIGN_LEFT));
                table.addCell(crearCelda(c.getFechaRegistro() != null ? c.getFechaRegistro() : "-", fontBody, alternaColor, colorFilaPar, Element.ALIGN_CENTER));

                alternaColor = !alternaColor;
            }

            document.add(table);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error crítico generando el documento PDF institucional", e);
        } finally {
            if (document.isOpen()) {
                document.close();
            }
        }
    }

    private PdfPCell crearCelda(String texto, Font fuente, boolean alternaColor, Color colorFondo, int alineacion) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setHorizontalAlignment(alineacion);
        celda.setVerticalAlignment(Element.ALIGN_MIDDLE);
        celda.setPadding(5);
        if (alternaColor) {
            celda.setBackgroundColor(colorFondo);
        }
        return celda;
    }
}