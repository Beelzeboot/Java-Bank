package interfaces;

import java.util.ArrayList;
import entidades.Usuario;

public interface IUsuarioDAO {
	
	public Boolean login(Usuario usuario);
	public Usuario getUsuario(Usuario usuario);
	public Integer altaUsuario(Usuario usuario);
	public Integer bajaUsuario(Usuario usuario);
	public Boolean existe(Usuario usuario);
	public Integer actualizarUsuario(Usuario usuario);
	public ArrayList<Usuario> obtenerUsuarios();
	
	
}
