package interfaces;

import java.util.ArrayList;

import entidades.Cuenta;
import entidades.Movimiento;

public interface IMovimientoDAO {
	public int crearMovimiento(Movimiento movimiento);
	public ArrayList<Movimiento> obtenerMovimientosCuenta(Cuenta cuenta);
}
