package com.productos.seguridad;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.productos.datos.Conexion;

public class usuario {

	
	private int id;
	private int perfil;
	private int estadoCivil;
	private String cedula;
	private String Nombre;
	private String Correo;
	private String clave;
	
	
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPerfil() {
		return perfil;
	}

	public void setPerfil(int perfil) {
		this.perfil = perfil;
	}

	public int getEstadoCivil() {
		return estadoCivil;
	}

	public void setEstadoCivil(int estadoCivil) {
		this.estadoCivil = estadoCivil;
	}

	public String getCedula() {
		return cedula;
	}

	public void setCedula(String cedula) {
		this.cedula = cedula;
	}

	public String getNombre() {
		return Nombre;
	}

	public void setNombre(String nombre) {
		Nombre = nombre;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public String getCorreo() {
		return Correo;
	}
	

	public void setCorreo(String correo) {
		Correo = correo;
	}
	
	public int numID() {
	    int Ids = 0;
	    String sentencia = "SELECT id_us FROM tb_usuario ORDER BY id_us DESC LIMIT 1;";

	    try {
	        ResultSet rs;
	        Conexion con = new Conexion();
	        rs = con.Consulta(sentencia);
	        if (rs.next()) {
	            Ids = rs.getInt(1)+1; // ✅ Aquí obtienes el valor de count(*)
	        }
	        rs.close();
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return Ids;
	}

	
	public static usuario verificarUsuario(String ncorreo, String nclave)
	{
	    usuario u = null;
	    String sentencia = "SELECT * FROM tb_usuario WHERE correo_us='" + ncorreo +
	                      "' AND clave_us='" + nclave + "';";
	    try {
	        ResultSet rs;
	        Conexion clsCon = new Conexion();
	        rs = clsCon.Consulta(sentencia);
	        if (rs.next()) {
	            int estado = rs.getInt("estado"); // 🔒 validamos el estado
	            if (estado == 0) {
	                return null; // el usuario está bloqueado
	            }

	            u = new usuario();
	            u.setCorreo(ncorreo);
	            u.setClave(nclave);
	            u.setPerfil(rs.getInt("id_per"));
	            u.setNombre(rs.getString("nombre_us"));
	        }
	        rs.close();
	    } catch (Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return u;
	}


	
	public String ingresarCliente()
	{
		String result="";
		Conexion con=new Conexion();
		PreparedStatement pr=null;
		String sql="INSERT INTO tb_usuario (id_us,id_per, id_est, nombre_us,"
				+ "cedula_us,correo_us,clave_us) "
				+ "VALUES(?,?,?,?,?,?,?)";
		try{
			pr=con.getConexion().prepareStatement(sql);
			pr.setInt(1, numID());
			pr.setInt(2,2);
			pr.setInt(3, this.getEstadoCivil());
			pr.setString(4, this.getNombre());
			pr.setString(5, this.getCedula());
			pr.setString(6, this.getCorreo());
			pr.setString(7, this.getClave());
			if(pr.executeUpdate()==1)
			{
				result="Insercion correcta";
			}
			else
			{
				result="Error en insercion";
			}
		}
		catch(Exception ex)
		{
			result=ex.getMessage();
			System.out.print(result);
		}
		finally
		{
			try
			{
				pr.close();
				con.getConexion().close();
			}
			catch(Exception ex)
			{
				System.out.print(ex.getMessage());
			}
		}
		return result;
	}
	
	
	
	
}