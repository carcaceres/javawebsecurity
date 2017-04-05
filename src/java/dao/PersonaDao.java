/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import conexion.DbConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Persona;

/**
 *
 * @author Carlos
 */
public class PersonaDao {

    private DbConnection conn;

    /**
     * 
     * @param codigo parametro del codigo de la persona
     * @return int valor de 0 o 1
     */
    
    public int eliminarPersona(String codigo) {
        try {
            String sql = "delete from persona where codigo=?";
            PreparedStatement preparedStatement = conn.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, codigo);
            int rows = preparedStatement.executeUpdate();
            return rows;

        } catch (SQLException e) {
            System.out.println("Error PersonaDao.eliminarPersona: " + e.getMessage());
            return 0;
        }
    }

/**
 * el metodo muestra todos los registros de la tabla persona
 * @return  de Tipo Persona - Retorna la lista de Persona
 */
    
    public List<Persona> personaList() {
        List<Persona> lista = new ArrayList<Persona>();
        try {

            String sql = "select codigo,nombres,apellidos,sueldo from persona";

            PreparedStatement preparedStatement = conn.getConnection().prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Persona persona = new Persona(rs.getString(1),
                        rs.getString(2), rs.getString(3),
                        rs.getDouble(4));
                lista.add(persona);
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            System.out.println("Error NivelDao.getAll: " + e.getMessage());
            return null;
        }

        return lista;
    }
/**
 * 
 * @param codigo - codigo de la persona
 * @param nombres - nombres de la persona
 * @param apellidos - apellidos de la persona
 * @param sueldo - sueldo de la persona
 * @return int - retorna el valor 0 o 1
 */
    public int actualizarPersona(String codigo, String nombres,
            String apellidos, double sueldo) {
        Persona persona=new Persona(codigo,nombres,apellidos,sueldo);
        try {
            String sql = "update persona set nombres=?"
                    + ",apellidos=?,sueldo=?"
                    + "where codigo=?";

            PreparedStatement preparedStatement = conn.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, persona.getNombres());
            preparedStatement.setString(2, persona.getApellidos());
            preparedStatement.setDouble(3, persona.getSueldo());
            preparedStatement.setString(4, persona.getCodigo());

            int rows = preparedStatement.executeUpdate();
            return rows;

        } catch (SQLException e) {
            System.out.println("Error PersonaDao.actualizarPersona: " + e.getMessage());
            return 0;
        }
    }

    /**
     * 
     * @return DbConnection 
     */
    
   public DbConnection getConn() {
        return conn;
    }
   
  /**
   * metodo para inyectar conexion de la base de datos
   * @param conn // parametro de tipo DbConnection 
   */
    public void setConn(DbConnection conn) {
        this.conn = conn;
    }
}
