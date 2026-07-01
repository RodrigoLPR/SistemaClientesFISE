package com.ayf.sistemaclientesfise.dao;

import com.ayf.sistemaclientesfise.model.Cliente;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/bd_clientes_fise", "root", "");
    }

    public List<Cliente> listarClientes() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente ORDER BY fecha_registro DESC";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setDni(rs.getString("dni"));
                c.setNombres(rs.getString("nombres"));
                c.setApellidos(rs.getString("apellidos"));
                c.setDireccion(rs.getString("direccion"));
                c.setTelefono(rs.getString("telefono"));
                c.setCorreo(rs.getString("correo"));
                c.setEstado(rs.getString("estado"));
                c.setObservacion(rs.getString("observacion"));
                c.setFechaRegistro(rs.getString("fecha_registro"));
                lista.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public List<Cliente> buscarClientes(String query) {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente WHERE nombres LIKE ? OR dni LIKE ? OR apellidos LIKE ? ORDER BY fecha_registro DESC";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            String parametro = "%" + query + "%";
            ps.setString(1, parametro);
            ps.setString(2, parametro);
            ps.setString(3, parametro);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setDni(rs.getString("dni"));
                    c.setNombres(rs.getString("nombres"));
                    c.setApellidos(rs.getString("apellidos"));
                    c.setDireccion(rs.getString("direccion"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setCorreo(rs.getString("correo"));
                    c.setEstado(rs.getString("estado"));
                    c.setObservacion(rs.getString("observacion"));
                    c.setFechaRegistro(rs.getString("fecha_registro"));
                    lista.add(c);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public int contarClientes() {
        String sql = "SELECT COUNT(*) FROM cliente";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int contarPorEstado(String estado) {
        String sql = "SELECT COUNT(*) FROM cliente WHERE estado = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public Cliente obtenerClientePorId(int id) {
        Cliente c = null;
        String sql = "SELECT * FROM cliente WHERE id_cliente = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    c = new Cliente();
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setDni(rs.getString("dni"));
                    c.setNombres(rs.getString("nombres"));
                    c.setApellidos(rs.getString("apellidos"));
                    c.setDireccion(rs.getString("direccion"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setCorreo(rs.getString("correo"));
                    c.setEstado(rs.getString("estado"));
                    c.setObservacion(rs.getString("observacion"));
                    c.setFechaRegistro(rs.getString("fecha_registro"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return c;
    }

    public void registrarCliente(Cliente c) {
        String sql = "INSERT INTO cliente (dni, nombres, apellidos, direccion, telefono, correo, estado, observacion, id_usuario) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getDni());
            ps.setString(2, c.getNombres());
            ps.setString(3, c.getApellidos());
            ps.setString(4, c.getDireccion());
            ps.setString(5, c.getTelefono());
            ps.setString(6, c.getCorreo());
            ps.setString(7, c.getEstado());
            ps.setString(8, c.getObservacion());
            ps.setInt(9, c.getIdUsuario());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void actualizarCliente(Cliente c) {
        String sql = "UPDATE cliente SET dni=?, nombres=?, apellidos=?, direccion=?, telefono=?, correo=?, estado=?, observacion=? WHERE id_cliente=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getDni());
            ps.setString(2, c.getNombres());
            ps.setString(3, c.getApellidos());
            ps.setString(4, c.getDireccion());
            ps.setString(5, c.getTelefono());
            ps.setString(6, c.getCorreo());
            ps.setString(7, c.getEstado());
            ps.setString(8, c.getObservacion());
            ps.setInt(9, c.getIdCliente());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void eliminarCliente(int id) {
        String sql = "DELETE FROM cliente WHERE id_cliente = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}