package com.productos.negocio;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.productos.datos.Conexion;

public class product {
	
	public int numID() {
	    int Ids = 0;
	    String sentencia = "SELECT id_pr FROM tb_producto ORDER BY id_pr DESC LIMIT 1;\r\n"
	    		+ "";

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
	
	
	public String consultarTodo()
	{
	String sql="SELECT * FROM tb_producto ORDER BY id_pr";
	Conexion con=new Conexion();
	String tabla="<table border=2><th>ID</th><th>Producto</th><th>Cantidad</th><th>Precio</th>";
			ResultSet rs=null;
			rs=con.Consulta(sql);
			try {
				while(rs.next())
				{
					tabla+="<tr><td>"+rs.getInt(1)+"</td>"
							+ "<td>"+rs.getString(3)+"</td>"
							+ "<td>"+rs.getInt(4)+"</td>"
							+ "<td>"+rs.getDouble(5)+"</td>"
							+ "</td></tr>";
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.print(e.getMessage());
			}
			tabla+="</table>";
			return tabla;
	}
	
	public String buscarProductoCategoria(int cat)
	{
	String sentencia="SELECT nombre_pr, precio_pr FROM tb_producto WHERE id_cat="+cat;
	Conexion con=new Conexion();
	ResultSet rs=null;
	String resultado="<table border=3>";
	try
	{
	rs=con.Consulta(sentencia);
	while(rs.next())
	{
	resultado+="<tr><td>"+ rs.getString(1)+"</td>"
	+ "<td>"+rs.getDouble(2)+"</td></tr>";
	}
	resultado+="</table>";
	}
	catch(SQLException e)
	{
	System.out.print(e.getMessage());
	}
	System.out.print(resultado);
	return resultado;
	}
	
	public String reporteProducto() {
	    String sql = "SELECT pr.id_pr, pr.nombre_pr, cat.descripcion_cat, pr.cantidad_pr, pr.precio_pr " +
	                 "FROM tb_producto pr, tb_categoria cat " +
	                 "WHERE pr.id_cat = cat.id_cat " +
	                 "ORDER BY pr.id_pr ASC"; // 👈 AÑADIDO: ordena por ID

	    Conexion cn = new Conexion();
	    String tabla = "<table class='table'><thead><tr>" +
	                   "<th scope='col'>ID</th>" +
	                   "<th scope='col'>Descripción</th>" +
	                   "<th scope='col'>Categoria</th>" +
	                   "<th scope='col'>Cantidad</th>" +
	                   "<th scope='col'>Precio</th>" +
	                   "<th scope='col'>Modificar</th>" +
	                   "<th scope='col'>Eliminar</th>" +
	                   "</tr></thead><tbody>";
	    ResultSet rs = null;
	    rs = cn.Consulta(sql);

	    try {
	        while (rs.next()) {
	            tabla += "<tr><th scope='row'>" + rs.getInt(1) + "</th>";
	            tabla += "<td>" + rs.getString(2) + "</td>";
	            tabla += "<td>" + rs.getString(3) + "</td>";
	            tabla += "<td>" + rs.getInt(4) + "</td>";
	            tabla += "<td>" + rs.getDouble(5) + "</td>";
	            tabla += "<td><a href='actualizar.jsp?id=" + rs.getInt(1) + "'>" +
	                     "<img src='iconos/editar.png' alt='Actualizar' style='width: 30px; height: 30px;' />" +
	                     "</a></td>";
	            tabla += "<td><a href='productoCRUD.jsp?accion=eliminar&id=" + rs.getInt(1) + "'>" +
	                     "<img src='iconos/eliminar.png' alt='Eliminar' style='width: 30px; height: 30px;' />" +
	                     "</a></td></tr>";
	        }
	        tabla += "</tbody></table>";
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return tabla;
	}

	
	public String buscarProductoId(String id) {
		String sentencia="Select nombre_pr ,precio_pr from tb_producto where id_pr="+id;
		Conexion con=new Conexion();
		ResultSet rs=null;
		String resultado ="<table class=table table=info>";
		
		try {
			rs=con.Consulta(sentencia);
			while(rs.next()) {
				resultado+="<tr><td>"+rs.getString(1)+"</td>"
						+ "<td>"+rs.getDouble(2)+"</td></tr>";
			}
			resultado+="</table>";
		}catch(SQLException e) {
			System.out.println(e.getMessage());
		}
		
		return resultado;
	}
	
	
	public String eliminarProducto(String id) {
		String sql="delete from tb_producto where id_pr="+id;
		Conexion con=new Conexion();
		String msg=con.Ejecutar(sql);
		return msg;
	}
	
	public String insertarProducto(String sql) {
	    Conexion con = new Conexion();
	    String resultado = con.Ejecutar(sql);
	    return resultado;
	}
	
	public String actualizarProducto(String sql) {
	    Conexion con = new Conexion();
	    String resultado = "";
	    try {
	        Statement st = con.getConexion().createStatement();
	        int filas = st.executeUpdate(sql);
	        if (filas > 0) {
	            resultado = "Producto actualizado correctamente.";
	        } else {
	            resultado = "No se pudo actualizar el producto.";
	        }
	        st.close();
	    } catch (Exception e) {
	        resultado = "Error al actualizar: " + e.getMessage();
	    }
	    return resultado;
	}


	
}