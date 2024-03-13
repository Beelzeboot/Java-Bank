package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import entidades.Cuenta;
import entidades.Movimiento;
import entidades.TipoMovimiento;
import interfaces.IMovimientoDAO;

public class MovimientoDAO implements IMovimientoDAO {
	private String host = "jdbc:mysql://localhost:3306/";
	private String user = "root";
	private String pass = "root";
	private String dbName = "bd_banco";

	@Override
	public int crearMovimiento(Movimiento movimiento) {
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
			String query = "INSERT INTO movimientos(Fecha_Movimiento, Detalle_Movimiento, Importe_Movimiento, CodTipoMovimiento_Movimiento, NumCuenta_Movimiento) VALUES ("
					+ "'" + movimiento.getFechaMovimiento() + "', "
					+ "'" + movimiento.getDetalle() + "', "
					+ movimiento.getImporte() + ", "
					+ movimiento.getTipoMoviento().getCodTipoMovimiento() + ", "
					+ "'" + movimiento.getNumeroCuenta() + "')";
			filas = st.executeUpdate(query);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return filas;
	}

	@Override
	public ArrayList<Movimiento> obtenerMovimientosCuenta(Cuenta cuenta) {
		ArrayList<Movimiento> lista = new ArrayList<Movimiento>();
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
			String query = "SELECT * FROM movimientos WHERE NumCuenta_Movimiento = " + cuenta.getNumCuenta();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next()){
				Movimiento movimiento = new Movimiento();
				
				movimiento.setCodMovimiento(rs.getInt("Cod_Movimiento"));
				movimiento.setFechaMovimiento(rs.getDate("Fecha_Movimiento").toLocalDate());
				movimiento.setDetalle(rs.getString("Detalle_Movimiento"));
				movimiento.setImporte(rs.getFloat("Importe_Movimiento"));
				TipoMovimiento tipoMovimiento = new TipoMovimiento();
				tipoMovimiento.setCodTipoMovimiento(rs.getInt("CodTipoMovimiento_Movimiento"));
				movimiento.setNumeroCuenta(rs.getString("NumCuenta_Movimiento"));
				
				
				lista.add(movimiento);
			}
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
		
		}
		
		return lista;
	}
	
}
