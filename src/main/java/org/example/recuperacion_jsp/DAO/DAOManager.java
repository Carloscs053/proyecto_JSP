package org.example.recuperacion_jsp.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAOManager {
    private Connection conn;
    private final String URL = "jdbc:mysql://localhost:3306/polideportivo";
    private final String USER = "root";
    private final String PASS = "admin";
    private static DAOManager singleton;

    private DAOManager() {}

    public static DAOManager getSingletonInstance() {
        if (singleton == null) {
            singleton = new DAOManager();
        }
        return singleton;
    }

    public void open() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, USER, PASS);
    }

    public void close() throws SQLException {
        if (conn != null) conn.close();
    }

    public Connection getConn() { return conn; }
}