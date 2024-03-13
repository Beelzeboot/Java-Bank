package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import entidades.Cuenta;
import entidades.Prestamo;
import entidades.Usuario;
import interfaces.IPrestamoDAO;

public class PrestamoDAO implements IPrestamoDAO {
	private String host = "jdbc:mysql://localhost:3306/";
	private String user = "root";
	private String pass = "root";
	private String dbName = "bd_banco";
	
	@Override
	public int solicitarPrestamo(Prestamo prestamo) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int filas = 0;
		Connection cn = null;
		try
		{
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();
			String query = "INSERT INTO prestamos(NumCuenta_Prestamo, Fecha_Prestamo, ImportePagar_Prestamo, ImportePedido_Prestamo, PlazoDePago_Prestamo, Cuotas_Prestamo) VALUES ('" 
					+ prestamo.getCuenta().getNumCuenta() + "', "
					+ "'" + prestamo.getFecha() + "', "
					+ prestamo.getImporteAPagar() + ", "
					+ prestamo.getImportePedido() + ", "
					+ "'" + prestamo.getPlazoDePago() + "', "
					+ prestamo.getCuotas() + ")";
			filas = st.executeUpdate(query);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}
	
	@Override
	public ArrayList<Prestamo> obtenerPrestamosSinAprobar() {
		// Estado_Prestamo = 0 -> prestamos pendientes de revision por el admin
		String query = "SELECT * FROM prestamos WHERE Estado_Prestamo = 0 ORDER BY Cod_Prestamo ASC";
		
		return obtenerListaPrestamos(query);
	}
	
	@Override
	public ArrayList<Prestamo> obtenerPrestamosAprobadosUsuario(Usuario usuario, Cuenta cuentaUsuario) {
		String query = "SELECT * FROM usuarios INNER JOIN cuentas" 
				+ " ON usuarios.Dni_Usuario = cuentas.Dni_Cuenta INNER JOIN prestamos ON usuarios.Dni_Usuario = cuentas.Dni_Cuenta" 
				+ " AND cuentas.NumCuenta_Cuenta = prestamos.NumCuenta_Prestamo"
				+ " WHERE usuarios.Dni_Usuario = '" + usuario.getDni() + "'"
			    + " AND cuentas.NumCuenta_Cuenta = '" + cuentaUsuario.getNumCuenta() + "'"
				// Estado_Prestamo = 1 -> prestamos aprobados
				+ " AND Estado_Prestamo = 1";
		
		return obtenerListaPrestamos(query);
	}
	
	@Override
	public ArrayList<Prestamo> obtenerPrestamosUsuario(Usuario usuario) {
		String query = "SELECT * FROM usuarios INNER JOIN cuentas" 
				+ " ON usuarios.Dni_Usuario = cuentas.Dni_Cuenta INNER JOIN prestamos ON usuarios.Dni_Usuario = cuentas.Dni_Cuenta" 
				+ " AND cuentas.NumCuenta_Cuenta = prestamos.NumCuenta_Prestamo"
				+ " WHERE usuarios.Dni_Usuario = '" + usuario.getDni() + "'";
		
		return obtenerListaPrestamos(query);
	}

	
	@Override
	public ArrayList<Prestamo> obtenerListaPrestamos(String q) {
		ArrayList<Prestamo> lista = new ArrayList<Prestamo>();
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			conn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = conn.createStatement();	
			ResultSet rs = st.executeQuery(q);
			
			while(rs.next()){
				Prestamo prestamo = new Prestamo();
				prestamo.setCodPrestamo(rs.getInt("Cod_Prestamo"));
				Cuenta cuenta = new Cuenta();
				cuenta.setNumCuenta(rs.getString("NumCuenta_Prestamo"));
				prestamo.setCuenta(cuenta);
				prestamo.setFecha(rs.getDate("Fecha_Prestamo").toLocalDate());
				prestamo.setImporteAPagar(rs.getFloat("ImportePagar_Prestamo"));
				prestamo.setImportePedido(rs.getFloat("ImportePedido_Prestamo"));
				prestamo.setPlazoDePago(rs.getDate("PlazoDePago_Prestamo").toLocalDate());
				prestamo.setCuotas(rs.getInt("Cuotas_Prestamo"));
				prestamo.setCuotasPagadas(rs.getInt("CuotasPagadas_Prestamo"));
				prestamo.setEstado(rs.getInt("Estado_Prestamo"));
				
				lista.add(prestamo);
			}
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
		return lista;
	}
	
	@Override
	public ArrayList<Prestamo> prestamosEntreFechas(String fechaInicio, String fechaFin) {
		String query = "SELECT * FROM prestamos WHERE Fecha_Prestamo BETWEEN '" + fechaInicio + "' AND '" + fechaFin + "'";
		
		return obtenerListaPrestamos(query);
	}
	
	@Override
	public ArrayList<Prestamo> prestamosEntreMontos(int min, int max) {
		String query = "SELECT * FROM prestamos WHERE ImportePedido_Prestamo BETWEEN '" + min + "' AND '" + max + "'";
		
		return obtenerListaPrestamos(query);
	}
	
	@Override
	public Prestamo getPrestamo(Prestamo prestamo) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Connection cn = null;
		
		try
		{
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();
			String query = "SELECT * FROM prestamos WHERE Cod_Prestamo = " + prestamo.getCodPrestamo();
			
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			prestamo.setCodPrestamo(rs.getInt("Cod_Prestamo"));
			Cuenta cuenta = new Cuenta();
			cuenta.setNumCuenta(rs.getString("NumCuenta_Prestamo"));
			prestamo.setCuenta(cuenta);
			prestamo.setFecha(rs.getDate("Fecha_Prestamo").toLocalDate());
			prestamo.setImporteAPagar(rs.getFloat("ImportePagar_Prestamo"));
			prestamo.setImportePedido(rs.getFloat("ImportePedido_Prestamo"));
			prestamo.setPlazoDePago(rs.getDate("PlazoDePago_Prestamo").toLocalDate());
			prestamo.setCuotas(rs.getInt("Cuotas_Prestamo"));
			prestamo.setCuotasPagadas(rs.getInt("CuotasPagadas_Prestamo"));
			prestamo.setEstado(rs.getInt("Estado_Prestamo"));
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return prestamo;
	}
	
	@Override
	public int cambiarEstadoPrestamo(Prestamo prestamo) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int filas = 0;
		Connection cn = null;
		try
		{
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();

			String query = "UPDATE prestamos SET Estado_Prestamo = " + prestamo.getEstado() + " WHERE Cod_Prestamo = " + prestamo.getCodPrestamo();
			filas = st.executeUpdate(query);													
		}
		catch(Exception e){
			e.printStackTrace();
		}		
		return filas;
	}
	
	@Override
	public int actualizarCuotasPrestamo(Prestamo prestamo) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int filas = 0;
		Connection cn = null;
		try
		{
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();

			String query = "UPDATE prestamos SET CuotasPagadas_Prestamo = " + prestamo.getCuotasPagadas() + " WHERE Cod_Prestamo = " + prestamo.getCodPrestamo() + ";";
			filas = st.executeUpdate(query);
														
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}
	
}
