package com.ayf.sistemaclientesfise.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL = "jdbc:mysql://localhost:3306/bd_clientes_fise";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver de MySQL", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}