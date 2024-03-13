package interfaces;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import entidades.Cuenta;
import entidades.Movimiento;

public interface IMovimientoNegocio {
	public Integer crearMovimientoTransferencia(String cbuDestino, String monto, HttpSession session);
	public ArrayList<Movimiento> obtenerMovimientosCuenta(Cuenta cuenta);
	public Integer crearMovimientoAltaCuenta(String cbu);
	public Integer crearMovimientoPrestamoAprobado(String codPrestamo);
	public Integer crearMovimientoPagoPrestamo(String codPrestamo, String cantidadCuotasAPagar, HttpSession session);
}
