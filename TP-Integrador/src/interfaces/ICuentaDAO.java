package interfaces;

import java.util.ArrayList;

import entidades.Cuenta;
import entidades.Usuario;


public interface ICuentaDAO {
	public int altaCuenta(Cuenta cuenta);
	public boolean existe(Cuenta cuenta);
	public int bajaCuenta(Cuenta cuenta);
	public Cuenta getCuenta(Cuenta cuenta);
	public Cuenta getCuenta(Usuario usuario);
	public int actualizarCuenta(Cuenta cuenta);
	public ArrayList<Cuenta> obtenerCuentas();
	public ArrayList<Cuenta> obtenerCuentasUsuario(Usuario usuario);
	public int asignarCuenta(Cuenta cuenta);
	public int cantidadCuentasUsuario(Usuario usuario);
	public int actualizarSaldo(Cuenta cuenta);
	public Cuenta obtenerCuentaPorCbu(String cbu);
	public Boolean cbuExiste(String cbu);
}
