package org.example.recuperacion_jsp.DAO;

import org.example.recuperacion_jsp.models.Reserva;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DaoReservaSQL {

    public boolean insert(Reserva r, DAOManager dao) {
        String sql = "INSERT INTO reservas (id_usuario, id_instalacion, fecha, hora) VALUES (?, ?, ?, ?)";
        try {
            dao.open();
            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ps.setInt(1, r.getIdUsuario());
            ps.setInt(2, r.getIdInstalacion());
            ps.setDate(3, r.getFecha());
            ps.setTime(4, r.getHora());
            int filas = ps.executeUpdate();
            dao.close();
            return filas > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public ArrayList<Reserva> readByFecha(Date fecha, DAOManager dao) {
        ArrayList<Reserva> lista = new ArrayList<>();
        String sql = "SELECT * FROM reservas WHERE fecha = ?";
        try {
            dao.open();
            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ps.setDate(1, fecha);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(new Reserva(rs.getInt("id"), rs.getInt("id_usuario"), rs.getInt("id_instalacion"), rs.getDate("fecha"), rs.getTime("hora")));
            }
            dao.close();
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public ArrayList<Reserva> readByUsuario(int idUsuario, DAOManager dao) {
        ArrayList<Reserva> lista = new ArrayList<>();
        String sql = "SELECT r.*, i.nombre AS nombre_pista FROM reservas r INNER JOIN instalaciones i ON r.id_instalacion = i.id WHERE r.id_usuario = ? ORDER BY r.fecha DESC, r.hora DESC";
        try {
            dao.open();
            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reserva res = new Reserva(rs.getInt("id"), rs.getInt("id_usuario"), rs.getInt("id_instalacion"), rs.getDate("fecha"), rs.getTime("hora"));
                res.setNombreInstalacion(rs.getString("nombre_pista"));
                lista.add(res);
            }
            dao.close();
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public boolean delete(int idReserva, DAOManager dao) {
        String sql = "DELETE FROM reservas WHERE id = ?";
        try {
            dao.open();
            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ps.setInt(1, idReserva);
            int filas = ps.executeUpdate();
            dao.close();
            return filas > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}