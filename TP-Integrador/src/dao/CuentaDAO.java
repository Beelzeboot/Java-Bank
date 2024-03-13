package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import entidades.Cuenta;
import entidades.TipoCuenta;
import entidades.Usuario;
import interfaces.ICuentaDAO;

public class CuentaDAO implements ICuentaDAO {
	private String host = "jdbc:mysql://localhost:3306/";
	private String user = "root";
	private String pass = "root";
	private String dbName = "bd_banco";

	@Override
	public int altaCuenta(Cuenta cuenta) {
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

			String query = "INSERT INTO cuentas(NumCuenta_Cuenta, FechaCreacion_Cuenta, CodTipoCuenta_Cuenta, Cbu_Cuenta, Saldo_Cuenta, Estado_Cuenta) VALUES ('" 
					+ cuenta.getNumCuenta() + "', "
					+ "'" + cuenta.getFechaCreacion() + "', "
					+ "'" + cuenta.getTipoCuenta().getCodTipoCuenta() + "', "
					+ "'" + cuenta.getCbu() + "', "
					+ "'" + cuenta.getSaldo() + "', "
					+ cuenta.getEstado() + ")";
			filas = st.executeUpdate(query);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}
	
	@Override
	public boolean existe(Cuenta cuenta) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		boolean existe = false;
		Connection cn = null;
		try
		{
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();

			String query = "SELECT * FROM cuentas WHERE NumCuenta_Cuenta = '" + cuenta.getNumCuenta() 
			+ "' OR Cbu_Cuenta = '" + cuenta.getCbu() + "'";	
			ResultSet rs = st.executeQuery(query);
			
			existe = rs.next();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return existe;
	}
	
	@Override
	public int bajaCuenta(Cuenta cuenta) {
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

			String query = "UPDATE cuentas SET Estado_Cuenta = false WHERE NumCuenta_Cuenta = '" + cuenta.getNumCuenta() + "'";
			filas = st.executeUpdate(query);				
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}
	
	@Override
	public Cuenta getCuenta(Cuenta cuenta) {
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
			String query = "SELECT * FROM cuentas WHERE NumCuenta_Cuenta = '" + cuenta.getNumCuenta() + "'";
			
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			cuenta.setNumCuenta(rs.getString("NumCuenta_Cuenta"));
			cuenta.setDni(rs.getString("Dni_Cuenta"));
			cuenta.setFechaCreacion(rs.getDate("FechaCreacion_Cuenta").toLocalDate());
			TipoCuenta tipoCuenta = new TipoCuenta();
			tipoCuenta.setCodTipoCuenta(rs.getInt("CodTipoCuenta_Cuenta"));
			cuenta.setTipoCuenta(tipoCuenta);
			cuenta.setCbu(rs.getString("Cbu_Cuenta"));
			cuenta.setSaldo(rs.getFloat("Saldo_Cuenta"));
			cuenta.setEstado(rs.getBoolean("Estado_Cuenta"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return cuenta;
	}
	
	@Override
	public int actualizarCuenta(Cuenta cuenta) {
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

			String query = "UPDATE cuentas SET Saldo_Cuenta = " + cuenta.getSaldo() + ", CodTipoCuenta_Cuenta = '" 
			        + cuenta.getTipoCuenta().getCodTipoCuenta() + "' WHERE NumCuenta_Cuenta = '" + cuenta.getNumCuenta() + "'";
			filas = st.executeUpdate(query);			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}
	
	@Override
	public ArrayList<Cuenta> obtenerCuentas() {
		String query = "SELECT * FROM cuentas WHERE Estado_Cuenta = '1' ORDER BY Dni_Cuenta ASC";
		
		return obtenerListaCuentas(query);
	}
	
	private ArrayList<Cuenta> obtenerListaCuentas(String query) {
		ArrayList<Cuenta> lista = new ArrayList<Cuenta>();
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
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next()){
				Cuenta cuenta = new Cuenta();
				cuenta.setNumCuenta(rs.getString("NumCuenta_Cuenta"));
				cuenta.setDni(rs.getString("Dni_Cuenta"));
				cuenta.setFechaCreacion(rs.getDate("FechaCreacion_Cuenta").toLocalDate());
				TipoCuenta tipoCuenta = new TipoCuenta();
				tipoCuenta.setCodTipoCuenta(rs.getInt("CodTipoCuenta_Cuenta"));
				cuenta.setTipoCuenta(tipoCuenta);
				cuenta.setCbu(rs.getString("Cbu_Cuenta"));
				cuenta.setSaldo(rs.getFloat("Saldo_Cuenta"));
				cuenta.setEstado(rs.getBoolean("Estado_Cuenta"));
				
				lista.add(cuenta);
			}
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
		
		}
		
		return lista;
	}
	
	@Override
	public int asignarCuenta(Cuenta cuenta) {
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

			String query = "UPDATE cuentas SET Dni_Cuenta = '" + cuenta.getDni() + "' " 
					+ "WHERE NumCuenta_Cuenta = '" + cuenta.getNumCuenta() + "';";
			filas = st.executeUpdate(query);				
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}
	
	@Override
	public int cantidadCuentasUsuario(Usuario usuario) {
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
			String query = "SELECT COUNT(*) AS CantidadCuentas FROM cuentas WHERE Dni_Cuenta = " + usuario.getDni() + " AND Estado_Cuenta = 1";
			
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			return rs.getInt("CantidadCuentas");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return 0;
	}
	
	@Override
	public int actualizarSaldo(Cuenta cuenta) {
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

			String query = "UPDATE cuentas SET Saldo_Cuenta = " + cuenta.getSaldo() + " WHERE NumCuenta_Cuenta = '" + cuenta.getNumCuenta() + "'";
			filas = st.executeUpdate(query);			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}
	
	@Override
	public ArrayList<Cuenta> obtenerCuentasUsuario(Usuario usuario) {
		String query = "SELECT * FROM cuentas WHERE Dni_Cuenta = " + usuario.getDni() + " AND Estado_Cuenta = true";
		
		return obtenerListaCuentas(query);
	}
	
	@Override
	public Cuenta getCuenta(Usuario usuario) {
		Cuenta cuenta = new Cuenta();
		
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
			String query = "SELECT * FROM cuentas WHERE Dni_Cuenta = '" + usuario.getDni() + "'";
			
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			cuenta.setNumCuenta(rs.getString("NumCuenta_Cuenta"));
			cuenta.setDni(rs.getString("Dni_Cuenta"));
			cuenta.setFechaCreacion(rs.getDate("FechaCreacion_Cuenta").toLocalDate());
			TipoCuenta tipoCuenta = new TipoCuenta();
			tipoCuenta.setCodTipoCuenta(rs.getInt("CodTipoCuenta_Cuenta"));
			cuenta.setTipoCuenta(tipoCuenta);
			cuenta.setCbu(rs.getString("Cbu_Cuenta"));
			cuenta.setSaldo(rs.getFloat("Saldo_Cuenta"));
			cuenta.setEstado(rs.getBoolean("Estado_Cuenta"));
		}
		catch(Exception e)
		{
			return null;
		}		
		return cuenta;
	}
	
	@Override
	public Cuenta obtenerCuentaPorCbu(String cbu) {
		Cuenta cuenta = new Cuenta();
		
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
			String query = "SELECT * FROM cuentas WHERE Cbu_Cuenta = '" + cbu + "'";
			
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			cuenta.setNumCuenta(rs.getString("NumCuenta_Cuenta"));
			cuenta.setDni(rs.getString("Dni_Cuenta"));
			cuenta.setFechaCreacion(rs.getDate("FechaCreacion_Cuenta").toLocalDate());
			TipoCuenta tipoCuenta = new TipoCuenta();
			tipoCuenta.setCodTipoCuenta(rs.getInt("CodTipoCuenta_Cuenta"));
			cuenta.setTipoCuenta(tipoCuenta);
			cuenta.setCbu(rs.getString("Cbu_Cuenta"));
			cuenta.setSaldo(rs.getFloat("Saldo_Cuenta"));
			cuenta.setEstado(rs.getBoolean("Estado_Cuenta"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("La cuenta no existe");
			
			return null;
		}
		
		return cuenta;
	}
	
	@Override
	public Boolean cbuExiste(String cbu) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		boolean existe = false;
		Connection cn = null;
		try
		{
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();

			String query = "SELECT * FROM cuentas WHERE Cbu_Cuenta = '" + cbu + "'";	
			ResultSet rs = st.executeQuery(query);
			
			existe = rs.next();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return existe;
	}
	
	

}
