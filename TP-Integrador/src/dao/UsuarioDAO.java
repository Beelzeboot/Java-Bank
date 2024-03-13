package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import entidades.Usuario;
import interfaces.IUsuarioDAO;

public class UsuarioDAO implements IUsuarioDAO {
	private String host = "jdbc:mysql://localhost:3306/";
	private String user = "root";
	private String pass = "root";
	private String dbName = "bd_banco";

	@Override
	public Boolean login(Usuario usuario) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		boolean accesso = false;
		Connection cn = null;
		try {
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();

			String query = "SELECT * FROM usuarios WHERE Contrasena_Usuario = '" + usuario.getContrasena()
					+ "' AND NombreUsuario_Usuario = '" + usuario.getNombreUsuario() + "'";
			ResultSet rs = st.executeQuery(query);

			accesso = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return accesso;
	}

	@Override
	public Usuario getUsuario(Usuario usuario) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Connection cn = null;

		try {
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();
			String query = "SELECT * FROM usuarios WHERE Dni_Usuario = '" + usuario.getDni() + "'"
					+ " OR NombreUsuario_Usuario = '" + usuario.getNombreUsuario() + "'";

			ResultSet rs = st.executeQuery(query);
			rs.next();

			usuario.setDni(rs.getString("Dni_Usuario"));
			usuario.setCuil(rs.getString("Cuil_Usuario"));
			usuario.setNombre(rs.getString("Nombre_Usuario"));
			usuario.setApellido(rs.getString("Apellido_Usuario"));
			usuario.setSexo(rs.getString("Sexo_Usuario"));
			usuario.setNacionalidad(rs.getString("Nacionalidad_Usuario"));
			usuario.setFechaNacimiento(rs.getString("FechaNacimiento_Usuario"));
			usuario.setDireccion(rs.getString("Direccion_Usuario"));
			usuario.setLocalidad(rs.getString("Localidad_Usuario"));
			usuario.setProvincia(rs.getString("Provincia_Usuario"));
			usuario.setCorreoElectronico(rs.getString("CorreoElectronico_Usuario"));
			usuario.setTelefono(rs.getString("Telefono_Usuario"));
			usuario.setNombreUsuario(rs.getString("NombreUsuario_Usuario"));
			usuario.setContrasena(rs.getString("Contrasena_Usuario"));
			usuario.setTipoUsuario(rs.getBoolean("TipoUsuario_Usuario"));
			usuario.setEstado(rs.getBoolean("Estado_Usuario"));

		} catch (Exception e) {
			return null;
		}

		return usuario;
	}

	@Override
	public Integer altaUsuario(Usuario usuario) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int filas = 0;
		Connection cn = null;
		try {
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();
			String query = "INSERT INTO usuarios(Dni_Usuario, Cuil_Usuario, Nombre_Usuario, Apellido_Usuario, Sexo_Usuario, "
					+ "Nacionalidad_Usuario, FechaNacimiento_Usuario, Direccion_Usuario, Localidad_Usuario, Provincia_Usuario, "
					+ "CorreoElectronico_Usuario, Telefono_Usuario, NombreUsuario_Usuario, Contrasena_Usuario) VALUES ("
					+ "'" + usuario.getDni() + "', " + "'" + usuario.getCuil() + "', " + "'" + usuario.getNombre()
					+ "', " + "'" + usuario.getApellido() + "', " + "'" + usuario.getSexo() + "', " + "'"
					+ usuario.getNacionalidad() + "', " + "'" + usuario.getFechaNacimiento() + "', " + "'"
					+ usuario.getDireccion() + "', " + "'" + usuario.getLocalidad() + "', " + "'"
					+ usuario.getProvincia() + "', " + "'" + usuario.getCorreoElectronico() + "', " + "'"
					+ usuario.getTelefono() + "', " + "'" + usuario.getNombreUsuario() + "', " + "'"
					+ usuario.getContrasena() + "')";
			filas = st.executeUpdate(query);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return filas;
	}

	@Override
	public Integer bajaUsuario(Usuario usuario) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int filas = 0;
		Connection cn = null;
		try {
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();

			String query = "UPDATE usuarios SET Estado_Usuario = '0' WHERE Dni_Usuario = '" + usuario.getDni()
					+ "';";
			filas = st.executeUpdate(query);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return filas;
	}

	@Override
	public Boolean existe(Usuario usuario) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		boolean existe = false;
		Connection cn = null;
		try {
			cn = DriverManager.getConnection(host + dbName, user, pass);
			Statement st = cn.createStatement();

			String query = "SELECT * FROM usuarios WHERE Dni_Usuario = '" + usuario.getDni() + "'";
			ResultSet rs = st.executeQuery(query);

			existe = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return existe;
	}
	
	@Override
	public Integer actualizarUsuario(Usuario usuario) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		  Connection con = null;
		    try {
		        con = DriverManager.getConnection(host + dbName, user, pass);
		        String query = "UPDATE usuarios SET Contrasena_Usuario = ? WHERE Dni_Usuario = ?";
		        
		        PreparedStatement ps = con.prepareStatement(query);
		        ps.setString(1, usuario.getContrasena());
		        ps.setString(2, usuario.getDni());

		        int filasActualizadas = ps.executeUpdate();
		        return filasActualizadas;
		    } catch (Exception e) {
		        e.printStackTrace();
		        return 0; // en caso de error
		    } finally {
		        // cierre de recursos
		        try {
		            if (con != null) {
		                con.close();
		            }
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
	}


	@Override
	public ArrayList<Usuario> obtenerUsuarios() {
		String q = "SELECT * FROM usuarios ORDER BY Dni_Usuario ASC";

		return obtenerListaUsuarios(q);
	}

	private ArrayList<Usuario> obtenerListaUsuarios(String q) {
		ArrayList<Usuario> lista = new ArrayList<Usuario>();
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

			while (rs.next()) {
				Usuario usuario = new Usuario();
				usuario.setDni(rs.getString("Dni_Usuario"));
				usuario.setCuil(rs.getString("Cuil_Usuario"));
				usuario.setNombre(rs.getString("Nombre_Usuario"));
				usuario.setApellido(rs.getString("Apellido_Usuario"));
				usuario.setSexo(rs.getString("Sexo_Usuario"));
				usuario.setNacionalidad(rs.getString("Nacionalidad_Usuario"));
				usuario.setFechaNacimiento(rs.getString("FechaNacimiento_Usuario"));
				usuario.setDireccion(rs.getString("Direccion_Usuario"));
				usuario.setLocalidad(rs.getString("Localidad_Usuario"));
				usuario.setProvincia(rs.getString("Provincia_Usuario"));
				usuario.setCorreoElectronico(rs.getString("CorreoElectronico_Usuario"));
				usuario.setTelefono(rs.getString("Telefono_Usuario"));
				usuario.setNombreUsuario(rs.getString("NombreUsuario_Usuario"));
				usuario.setContrasena(rs.getString("Contrasena_Usuario"));
				usuario.setTipoUsuario(rs.getBoolean("TipoUsuario_Usuario"));
				usuario.setEstado(rs.getBoolean("Estado_Usuario"));

				lista.add(usuario);
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 

		return lista;
	}
}
