package org.example.recuperacion_jsp.DAO;

import org.example.recuperacion_jsp.models.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DaoUsuarioSQL {

    public Usuario login(String username, String password, DAOManager dao) {
        String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
        try {
            dao.open();
            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario(rs.getInt("id"), rs.getString("username"), rs.getString("password"),
                        rs.getString("nombre"), rs.getString("email"), rs.getString("movil"));
                dao.close();
                return u;
            }
            dao.close();
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean insert(Usuario u, DAOManager dao) {
        String sql = "INSERT INTO usuarios (username, password, nombre, email, movil) VALUES (?, ?, ?, ?, ?)";
        try {
            dao.open();
            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getNombre());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getMovil());
            int filas = ps.executeUpdate();
            dao.close();
            return filas > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public boolean update(Usuario u, DAOManager dao) {
        String checkSql = "SELECT COUNT(*) FROM usuarios WHERE username = ? AND id != ?";
        String sql = "UPDATE usuarios SET username = ?, nombre = ?, email = ?, movil = ?, password = ? WHERE id = ?";
        try {
            dao.open();
            PreparedStatement psCheck = dao.getConn().prepareStatement(checkSql);
            psCheck.setString(1, u.getUsername()); psCheck.setInt(2, u.getId());
            ResultSet rs = psCheck.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) { dao.close(); return false; }

            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ps.setString(1, u.getUsername()); ps.setString(2, u.getNombre());
            ps.setString(3, u.getEmail()); ps.setString(4, u.getMovil());
            ps.setString(5, u.getPassword()); ps.setInt(6, u.getId());
            int filas = ps.executeUpdate();
            dao.close();
            return filas > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}