package negocio;

import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import dao.CuentaDAO;
import dao.PrestamoDAO;
import entidades.Cuenta;
import entidades.Prestamo;
import entidades.Usuario;
import interfaces.IPrestamoNegocio;

public class PrestamoNegocio implements IPrestamoNegocio {
	PrestamoDAO pDao = new PrestamoDAO();
	CuentaDAO cDao = new CuentaDAO();
	Prestamo prestamo = new Prestamo();
	Cuenta cuenta = new Cuenta();
	
	@Override
	public Integer solicitarPrestamo(String cuotas, String monto, HttpSession session) {
		if(cuotas.isEmpty() || monto.isEmpty()) return 3;
		if(Float.parseFloat(monto) < 0) return 4;
		
		cuenta = (Cuenta)session.getAttribute("cuentaActual");
		prestamo = new Prestamo(cuenta, Float.parseFloat(monto), Integer.parseInt(cuotas));
		
		return pDao.solicitarPrestamo(prestamo);
	}
		
	
	@Override
	public ArrayList<Prestamo> obtenerPrestamosSinAprobar() {
		return pDao.obtenerPrestamosSinAprobar();
	}
	
	@Override
	public ArrayList<Prestamo> obtenerPrestamosAprobadosUsuario(Usuario usuario, Cuenta cuentaUsuario) {
		return pDao.obtenerPrestamosAprobadosUsuario(usuario, cuentaUsuario);
	}
	
	@Override
	public ArrayList<Prestamo> obtenerPrestamosUsuario(Usuario usuario) {
		return pDao.obtenerPrestamosUsuario(usuario);
	}	
	
	@Override
	public Integer validarPrestamosEntreFechas(String fechaInicio, String fechaFin) {
		if(fechaInicio.isEmpty() || fechaFin.isEmpty()) return 3;
		
		LocalDate fechaInicioLD = LocalDate.parse(fechaInicio);
	    LocalDate fechaFinLD = LocalDate.parse(fechaFin);  
	    if(fechaInicioLD.compareTo(fechaFinLD) > 0) return 2;
		
	    return 1;
	}
	
	@Override
	public Integer validarPrestamosEntreMontos(String min, String max) {
		if(min.isEmpty() || max.isEmpty()) return 4;
		
		int minimo = Integer.parseInt(min);
		int maximo = Integer.parseInt(max);
		
	    if(minimo > maximo) return 5;
		
	    return 1;
	}
	
	@Override
	public ArrayList<Prestamo> prestamosEntreFechas(String fechaInicio, String fechaFin) {
		return pDao.prestamosEntreFechas(fechaInicio, fechaFin);
	}
	
	@Override
	public ArrayList<Prestamo> prestamosEntreMontos(String min, String max) {
		int minimo = Integer.parseInt(min);
		int maximo = Integer.parseInt(max);
		return pDao.prestamosEntreMontos(minimo, maximo);
	}
	
	@Override
	public Integer aprobarPrestamo(String codPrestamo) {
		prestamo.setCodPrestamo(Integer.parseInt(codPrestamo));	
		prestamo = pDao.getPrestamo(prestamo);
		// 1 es prestamo aprobado
		prestamo.setEstado(1);
		
		cuenta.setNumCuenta(prestamo.getCuenta().getNumCuenta());
		cuenta = cDao.getCuenta(cuenta);
		cuenta.setSaldo(cuenta.getSaldo() + prestamo.getImportePedido());
		
		Integer resultActualizarSaldo = cDao.actualizarSaldo(cuenta);
		//si resultActualizarSaldo es 1 cambio el estado, si no devuelvo resultActualizarSaldo
		return resultActualizarSaldo == 1 ? pDao.cambiarEstadoPrestamo(prestamo) : resultActualizarSaldo;
	}
	
	@Override
	public Integer rechazarPrestamo(String codPrestamo) {
		prestamo.setCodPrestamo(Integer.parseInt(codPrestamo));	
		prestamo = pDao.getPrestamo(prestamo);
		// 2 es prestamo rechazado
		prestamo.setEstado(2);
		
		return pDao.cambiarEstadoPrestamo(prestamo);
	}
	
	@Override
	public Integer pagarCuotasPrestamo(String codPrestamo, String cantidadCuotasAPagar, HttpSession session) {
		if(cantidadCuotasAPagar.isEmpty()) return 3;
		
		prestamo.setCodPrestamo(Integer.parseInt(codPrestamo));
		prestamo = pDao.getPrestamo(prestamo);
		
		Integer resultPagarCuotas = 0;
		
		// Calculo de cuotas pagadas
		Integer nuevoCuotasPagadas = (prestamo.getCuotasPagadas() + Integer.parseInt(cantidadCuotasAPagar)) > prestamo.getCuotas() 
				? prestamo.getCuotas() 
				: prestamo.getCuotasPagadas() + Integer.parseInt(cantidadCuotasAPagar);
		prestamo.setCuotasPagadas(nuevoCuotasPagadas);		
		
		Float montoCuota = (prestamo.getImporteAPagar() / prestamo.getCuotas());
		
		cuenta = (Cuenta)session.getAttribute("cuentaActual");		
		if(cuenta.getSaldo() < (montoCuota * Integer.parseInt(cantidadCuotasAPagar))) return 2;
		
		if(prestamo.getCuotasPagadas() == prestamo.getCuotas()) {
			// 3 -> prestamo pagado
			prestamo.setEstado(3); 	
			resultPagarCuotas = pDao.cambiarEstadoPrestamo(prestamo);
		}
		
		cuenta.setSaldo(cuenta.getSaldo() - (montoCuota * Integer.parseInt(cantidadCuotasAPagar)));
		resultPagarCuotas = cDao.actualizarSaldo(cuenta);
		
		return resultPagarCuotas == 1 ? pDao.actualizarCuotasPrestamo(prestamo) : resultPagarCuotas;
	}

}
