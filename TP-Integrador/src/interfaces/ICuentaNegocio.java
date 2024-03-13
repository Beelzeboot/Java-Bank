package interfaces;

import java.util.ArrayList;

import entidades.Cuenta;
import entidades.Usuario;

public interface ICuentaNegocio {
	public String altaCuenta(String numCuenta, String tipoCuenta, String nroCbu);
	public boolean existe(Cuenta cuenta);
	public int bajaCuenta(String numCuenta);
	public int actualizarCuenta(String numCuenta, String tipoCuenta, String nuevoSaldo);
	public ArrayList<Cuenta> obtenerCuentas();
	public ArrayList<Cuenta> obtenerCuentasUsuario(Usuario usuario);
	public int asignarCuenta(String numCuenta, String nroDni);
	
}
