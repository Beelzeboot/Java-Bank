package interfaces;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import entidades.Cuenta;
import entidades.Prestamo;
import entidades.Usuario;


public interface IPrestamoNegocio {
	public Integer solicitarPrestamo(String cuotas, String monto, HttpSession session);
	public Integer aprobarPrestamo(String codPrestamo);
	public Integer rechazarPrestamo(String codPrestamo);
	public ArrayList<Prestamo> obtenerPrestamosUsuario(Usuario usuario);
	public ArrayList<Prestamo> obtenerPrestamosSinAprobar();
	public ArrayList<Prestamo> obtenerPrestamosAprobadosUsuario(Usuario usuario, Cuenta cuentaUsuario);
	public ArrayList<Prestamo> prestamosEntreFechas(String fechaInicio, String fechaFin);
	public Integer validarPrestamosEntreFechas(String fechaInicio, String fechaFin);
	public Integer validarPrestamosEntreMontos(String min, String max);
	public ArrayList<Prestamo> prestamosEntreMontos(String min, String max);
	public Integer pagarCuotasPrestamo(String codPrestamo, String cantidadCuotasAPagar, HttpSession session);
	
	
}
