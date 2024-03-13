package excepciones;

import java.io.IOException;

import entidades.Usuario;

public class UsuarioSinCuenta extends IOException {
	
	private static final long serialVersionUID = 1L;
	Usuario obj;
	
	public UsuarioSinCuenta(Usuario obj) {
		this.obj = obj;
	}

	@Override
	public String getMessage() {
		return "¡Atención! El usuario con dni " + obj.getDni() + " aún no tiene cuenta asignada.";
	}
}
