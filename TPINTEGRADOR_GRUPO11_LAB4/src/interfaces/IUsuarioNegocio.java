package interfaces;

import javax.servlet.http.HttpSession;

import entidades.Usuario;
import excepciones.UsuarioSinCuenta;



public interface IUsuarioNegocio {
	public Integer login(String nombreUsuario, String contrasena, HttpSession session);
	public Integer altaUsuario(String dni, String cuil, String nombre, String apellido, String sexo, String nacionalidad, 
			String fechaNacimiento, String direccion, String localidad, String provincia, String correoElectronico, 
			String telefono, String nombreUsuario, String contrasena, String confirmarContrasena);
	public Integer bajaUsuario(String dni);
	public Integer actualizarUsuario(String dni, String nuevaContrasena);
	public Boolean verificarCuentaUsuario(Usuario usuario) throws UsuarioSinCuenta;
	
}
