package org.example.recuperacion_jsp.DAO;

import org.example.recuperacion_jsp.models.Instalacion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DaoInstalacionSQL {
    public ArrayList<Instalacion> readAll(DAOManager dao) {
        ArrayList<Instalacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM instalaciones";
        try {
            dao.open();
            PreparedStatement ps = dao.getConn().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(new Instalacion(rs.getInt("id"), rs.getString("nombre"), rs.getString("tipo")));
            }
            dao.close();
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
