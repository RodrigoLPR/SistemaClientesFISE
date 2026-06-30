package com.ayf.sistemaclientesfise.dao;

import com.ayf.sistemaclientesfise.model.Cliente;
import com.ayf.sistemaclientesfise.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public boolean registrarCliente(Cliente cliente) {

        String sql = "INSERT INTO cliente (dni, nombres, apellidos, direccion, telefono, correo, estado, observacion, id_usuario) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cliente.getDni());
            ps.setString(2, cliente.getNombres());
            ps.setString(3, cliente.getApellidos());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getCorreo());
            ps.setString(7, cliente.getEstado());
            ps.setString(8, cliente.getObservacion());
            ps.setInt(9, cliente.getIdUsuario());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Cliente> listarClientes() {

        List<Cliente> lista = new ArrayList<>();

        String sql = "SELECT id_cliente, dni, nombres, apellidos, direccion, telefono, correo, estado, observacion, id_usuario "
                + "FROM cliente ORDER BY id_cliente DESC";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Cliente cliente = new Cliente();

                cliente.setIdCliente(rs.getInt("id_cliente"));
                cliente.setDni(rs.getString("dni"));
                cliente.setNombres(rs.getString("nombres"));
                cliente.setApellidos(rs.getString("apellidos"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setCorreo(rs.getString("correo"));
                cliente.setEstado(rs.getString("estado"));
                cliente.setObservacion(rs.getString("observacion"));
                cliente.setIdUsuario(rs.getInt("id_usuario"));

                lista.add(cliente);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public int contarClientes() {

        int total = 0;

        String sql = "SELECT COUNT(*) AS total FROM cliente";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public Cliente obtenerClientePorId(int idCliente) {

        Cliente cliente = null;

        String sql = "SELECT id_cliente, dni, nombres, apellidos, direccion, telefono, correo, estado, observacion, id_usuario "
                + "FROM cliente WHERE id_cliente = ?";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCliente);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    cliente = new Cliente();

                    cliente.setIdCliente(rs.getInt("id_cliente"));
                    cliente.setDni(rs.getString("dni"));
                    cliente.setNombres(rs.getString("nombres"));
                    cliente.setApellidos(rs.getString("apellidos"));
                    cliente.setDireccion(rs.getString("direccion"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setCorreo(rs.getString("correo"));
                    cliente.setEstado(rs.getString("estado"));
                    cliente.setObservacion(rs.getString("observacion"));
                    cliente.setIdUsuario(rs.getInt("id_usuario"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cliente;
    }

    public boolean actualizarCliente(Cliente cliente) {

        String sql = "UPDATE cliente SET dni = ?, nombres = ?, apellidos = ?, direccion = ?, "
                + "telefono = ?, correo = ?, estado = ?, observacion = ? "
                + "WHERE id_cliente = ?";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cliente.getDni());
            ps.setString(2, cliente.getNombres());
            ps.setString(3, cliente.getApellidos());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getCorreo());
            ps.setString(7, cliente.getEstado());
            ps.setString(8, cliente.getObservacion());
            ps.setInt(9, cliente.getIdCliente());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarCliente(int idCliente) {

        String sql = "DELETE FROM cliente WHERE id_cliente = ?";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCliente);

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}