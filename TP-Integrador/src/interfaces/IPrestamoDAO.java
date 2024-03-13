package interfaces;


import java.util.ArrayList;

import entidades.Cuenta;
import entidades.Prestamo;
import entidades.Usuario;

public interface IPrestamoDAO {
	public int solicitarPrestamo(Prestamo prestamo);
	public ArrayList<Prestamo> obtenerPrestamosUsuario(Usuario usuario);
	public ArrayList<Prestamo> obtenerPrestamosSinAprobar();
	public ArrayList<Prestamo> obtenerPrestamosAprobadosUsuario(Usuario usuario, Cuenta cuentaUsuario);
	public ArrayList<Prestamo> obtenerListaPrestamos(String q);
	public ArrayList<Prestamo> prestamosEntreFechas(String fechaInicio, String fechaFin);
	public Prestamo getPrestamo(Prestamo prestamo);
	public int cambiarEstadoPrestamo(Prestamo prestamo);
	public ArrayList<Prestamo> prestamosEntreMontos(int min, int max);
	public int actualizarCuotasPrestamo(Prestamo prestamo);
		
}
