package org.example.recuperacion_jsp.models;

public class Instalacion {
    private int id;
    private String nombre;
    private String tipo;

    public Instalacion(int id, String nombre, String tipo) {
        this.id = id;
        this.nombre = nombre;
        this.tipo = tipo;
    }

    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public String getTipo() { return tipo; }
}