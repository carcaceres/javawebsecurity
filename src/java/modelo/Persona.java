/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.logging.Level;
import java.util.logging.Logger;
import utilidad.Cifrar;

/**
 *
 * @author Carlos
 */
public class Persona {

    private String codigo;
    private String nombres;
    private String apellidos;
    private double sueldo;
    private String codCif;

    public Persona(String codigo, String nombres, String apellidos,
            double sueldo) {
        try {
            String key = "AAAE31A79FFFBFFF"; //llave
            String iv = "0000456789AAADEF"; // vector de inicialización
            
            this.codigo = codigo;
            this.nombres = nombres;
            this.apellidos = apellidos;
            this.sueldo = sueldo;
            this.codCif = Cifrar.encrypt(key, iv, codigo);
        } catch (Exception ex) {
            Logger.getLogger(Persona.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public double getSueldo() {
        return sueldo;
    }

    public void setSueldo(double sueldo) {
        this.sueldo = sueldo;
    }

    public String getCodCif() {
        return codCif;
    }

    public void setCodCif(String codCif) {
        this.codCif = codCif;
    }

}
