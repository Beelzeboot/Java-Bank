package negocio;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import entidades.Cuenta;
import entidades.Usuario;
import excepciones.UsuarioSinCuenta;
import interfaces.ICuentaDAO;
import interfaces.IUsuarioDAO;
import interfaces.IUsuarioNegocio;
import dao.CuentaDAO;
import dao.UsuarioDAO;

public class UsuarioNegocio implements IUsuarioNegocio {
	IUsuarioDAO uDao = new UsuarioDAO();
	ICuentaDAO cDao = new CuentaDAO();
	Usuario usuario = new Usuario();

	@Override
	public Integer login(String nombreUsuario, String contrasena, HttpSession session) {
		if(nombreUsuario.isEmpty() || contrasena.isEmpty()) return 2;
		
		usuario.setNombreUsuario(nombreUsuario);
		usuario.setContrasena(contrasena);
		if(!uDao.login(usuario)) return 3;		
		
		usuario = uDao.getUsuario(usuario);
		
		if(!usuario.getEstado()) return 4;		
				
		if (!usuario.getTipoUsuario()) {
		    try {    
		        if (!verificarCuentaUsuario(usuario)) {
		            ArrayList<Cuenta> cuentasUsuario = cDao.obtenerCuentasUsuario(usuario);

		            session.setAttribute("indiceCuentaActual", 0);
		            session.setAttribute("cuentaActual", cuentasUsuario.get(0));
		            session.setAttribute("cuentasUsuario", cuentasUsuario);
		        }
		    } catch (UsuarioSinCuenta ex) {
		        System.out.println(ex.getMessage() + "\n");
		        return 0;
		    }
		}
		
		session.setAttribute("usuario", usuario);		
		return 1;	
	}
	
	//true si el usuario no tiene cuenta
	@Override
	public Boolean verificarCuentaUsuario(Usuario usuario) throws UsuarioSinCuenta {
		Boolean usuarioSinCuenta = false;

		if (cDao.getCuenta(usuario) == null) {
		    usuarioSinCuenta = true;
		}
		if(usuarioSinCuenta) {
			UsuarioSinCuenta exc = new UsuarioSinCuenta(usuario);
			
			throw exc;
		}
		
		return usuarioSinCuenta;
	}
	
	@Override
	public Integer altaUsuario(String dni, String cuil, String nombre, String apellido,  String sexo, String nacionalidad, 
			String fechaNacimiento, String direccion, String localidad, String provincia, String correoElectronico, 
			String telefono, String nombreUsuario, String contrasena, String confirmarContrasena) {
		if(dni.isEmpty()
			|| cuil.isEmpty()			 
			|| nombre.isEmpty()
			|| apellido.isEmpty() 
			|| sexo.isEmpty() 
			|| nacionalidad.isEmpty()
			|| fechaNacimiento.isEmpty()
			|| direccion.isEmpty()
			|| localidad.isEmpty()
			|| provincia.isEmpty()
			|| correoElectronico.isEmpty()
			|| telefono.isEmpty()
			|| nombreUsuario.isEmpty()
			|| contrasena.isEmpty()
			|| confirmarContrasena.isEmpty()) return 3;
		
		if(contrasena != null && confirmarContrasena != null && contrasena.equals(confirmarContrasena)) {
			usuario = new Usuario(dni, cuil, nombre, apellido, sexo, nacionalidad,
					fechaNacimiento, direccion, localidad, provincia, correoElectronico, 
					telefono, nombreUsuario, contrasena);
		
		if(uDao.existe(usuario)) return 2;
		
		return uDao.altaUsuario(usuario);
		} return -1;
	}
	
	@Override
	public Integer bajaUsuario(String dni) {
		if(dni.isEmpty()) return 3;

		usuario.setDni(dni);
		
		if(!uDao.existe(usuario)) return 4;
	
		return uDao.bajaUsuario(usuario);
	}
	
	@Override
	public Integer actualizarUsuario(String dni, String nuevaContrasena) {
		if(dni.isEmpty() || nuevaContrasena.isEmpty()) {
			return 2;
		}
		
		Usuario usuario = new Usuario();
		usuario.setDni(dni);
		
		if(!uDao.existe(usuario)) return 0;		
		uDao.getUsuario(usuario);//traigo al usuario si existe
		
		if(!usuario.getEstado()) return 0;//reviso que el usuario este activo
		
		usuario.setContrasena(nuevaContrasena);
		int filasActualizadas = uDao.actualizarUsuario(usuario);
		if(filasActualizadas > 0) {
			return 1;
		}else {
			return -1;
		}
	}
}
