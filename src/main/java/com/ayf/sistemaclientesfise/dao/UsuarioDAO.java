package com.ayf.sistemaclientesfise.dao;

import com.ayf.sistemaclientesfise.model.Usuario;
import com.ayf.sistemaclientesfise.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    public Usuario validarLogin(String username, String password) {
        Usuario usuario = null;

        String sql = "SELECT id_usuario, username, password, rol FROM usuario WHERE username = ? AND password = ?";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setUsername(rs.getString("username"));
                    usuario.setPassword(rs.getString("password"));
                    usuario.setRol(rs.getString("rol"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }
    
    public boolean registrarUsuario(Usuario user) {
    String sql = "INSERT INTO usuario (username, password, rol) VALUES (?, ?, ?)";
    try (Connection conn = ConexionBD.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());
        ps.setString(3, "Asesor"); // Todos los creados por esta pantalla serán Gestores/Asesores

        int filasAfectadas = ps.executeUpdate();
        return filasAfectadas > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    
}