/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador.Banco;

/**
 *
 * @author Proyecto Final - Sistema Bancario
 */
public class clsBanco {
    private int    idBanco;
    private String nombreBanco;
    private String direccion;
    private String telefono;
    private String correo;

    public clsBanco() {
    }

    public clsBanco(int idBanco, String nombreBanco, String direccion, String telefono, String correo) {
        this.idBanco     = idBanco;
        this.nombreBanco = nombreBanco;
        this.direccion   = direccion;
        this.telefono    = telefono;
        this.correo      = correo;
    }

    public int getIdBanco() { return idBanco; }
    public void setIdBanco(int idBanco) { this.idBanco = idBanco; }

    public String getNombreBanco() { return nombreBanco; }
    public void setNombreBanco(String nombreBanco) { this.nombreBanco = nombreBanco; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    @Override
    public String toString() {
        return "Banco{ idBanco=" + idBanco + ", nombreBanco=" + nombreBanco + " }";
    }
}

