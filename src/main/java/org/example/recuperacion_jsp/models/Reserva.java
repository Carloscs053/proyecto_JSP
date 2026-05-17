package org.example.recuperacion_jsp.models;
import java.sql.Date;
import java.sql.Time;

public class Reserva {
    private int id;
    private int idUsuario;
    private int idInstalacion;
    private Date fecha;
    private Time hora;
    private String nombreInstalacion;

    public Reserva(int id, int idUsuario, int idInstalacion, Date fecha, Time hora) {
        this.id = id;
        this.idUsuario = idUsuario;
        this.idInstalacion = idInstalacion;
        this.fecha = fecha;
        this.hora = hora;
    }

    public int getId() { return id; }
    public int getIdUsuario() { return idUsuario; }
    public int getIdInstalacion() { return idInstalacion; }
    public Date getFecha() { return fecha; }
    public Time getHora() { return hora; }

    public String getNombreInstalacion() { return nombreInstalacion; }
    public void setNombreInstalacion(String nombreInstalacion) { this.nombreInstalacion = nombreInstalacion; }
}