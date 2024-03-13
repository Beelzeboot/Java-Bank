package negocio;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import dao.CuentaDAO;
import dao.MovimientoDAO;
import dao.PrestamoDAO;
import entidades.Cuenta;
import entidades.Movimiento;
import entidades.Prestamo;
import excepciones.CuentaNoEncontrada;
import interfaces.ICuentaDAO;
import interfaces.IMovimientoDAO;
import interfaces.IMovimientoNegocio;
import interfaces.IPrestamoDAO;

public class MovimientoNegocio implements IMovimientoNegocio {
	IMovimientoDAO mDao = new MovimientoDAO();
	ICuentaDAO cDao = new CuentaDAO();
	IPrestamoDAO pDao = new PrestamoDAO();
	Cuenta cuenta = new Cuenta();
	
	private int crearMovimientoDestino(Movimiento movimiento) {
		return mDao.crearMovimiento(movimiento);
	}
	
	@Override
	public Integer crearMovimientoTransferencia(String cbuDestino, String monto, HttpSession session) {
		if(cbuDestino.isEmpty() || monto.isEmpty()) return 3;
		
		Cuenta cuenta = (Cuenta)session.getAttribute("cuentaActual");
		Cuenta cuentaD = cDao.cbuExiste(cbuDestino) ? cDao.obtenerCuentaPorCbu(cbuDestino) : new Cuenta();
		Integer resultCrearMovimiento = 0;

		if(cuenta.getSaldo() < Float.parseFloat(monto)) return 6;
		if(Float.parseFloat(monto) < 0) return 5;
		if(cuenta.getNumCuenta().equals(cuentaD.getNumCuenta())) return 4;

		Movimiento movimiento = new Movimiento(cuenta, Float.parseFloat(monto), 4);
		Movimiento movimientoD = new Movimiento(cuentaD, Float.parseFloat(monto), 5);
		
		resultCrearMovimiento = mDao.crearMovimiento(movimiento);
		
		if(resultCrearMovimiento == 1) {
			cuenta.setSaldo(cuenta.getSaldo() - Float.parseFloat(monto));
			cuentaD.setSaldo(cuentaD.getSaldo() + Float.parseFloat(monto));
			cDao.actualizarSaldo(cuenta);
			cDao.actualizarSaldo(cuentaD);
		}
		
		return resultCrearMovimiento == 1 ? crearMovimientoDestino(movimientoD) : resultCrearMovimiento;
	}
	
	@Override
	public Integer crearMovimientoAltaCuenta(String cbu) {
	    try {
	        // Verificar si el CBU existe
	        Cuenta cuenta = cDao.cbuExiste(cbu) ? cDao.obtenerCuentaPorCbu(cbu) : null;

	        if (cuenta == null) {
	            throw new CuentaNoEncontrada("No se encontró la cuenta asociada al CBU: " + cbu);
	        }
	
	        Movimiento movimiento = new Movimiento(cuenta, cuenta.getSaldo(), 1);

	        return mDao.crearMovimiento(movimiento);
	    } catch (Exception e) {
	        e.printStackTrace();  
	        return -1;  
	    }
	}
	
	@Override
	public Integer crearMovimientoPrestamoAprobado(String codPrestamo) {
	    
		Prestamo prestamo = new Prestamo();
	    prestamo.setCodPrestamo(Integer.parseInt(codPrestamo));
	  
        prestamo = pDao.getPrestamo(prestamo);
        Movimiento movimiento = new Movimiento(prestamo.getCuenta(), prestamo.getImportePedido(), 2);
        
        return mDao.crearMovimiento(movimiento);
	}
	
	@Override
	public Integer crearMovimientoPagoPrestamo(String codPrestamo, String cantidadCuotasAPagar, HttpSession session) {
	    
		Prestamo prestamo = new Prestamo();
	    prestamo.setCodPrestamo(Integer.parseInt(codPrestamo));
	  
        prestamo = pDao.getPrestamo(prestamo);
        
        Float montoAbonado = ((prestamo.getImporteAPagar() / prestamo.getCuotas()) * Integer.parseInt(cantidadCuotasAPagar));
        cuenta = (Cuenta)session.getAttribute("cuentaActual");	
        
        Movimiento movimiento = new Movimiento(cuenta, montoAbonado, 3);
        
        return mDao.crearMovimiento(movimiento);
	}


	@Override
	public ArrayList<Movimiento> obtenerMovimientosCuenta(Cuenta cuenta) {
		return mDao.obtenerMovimientosCuenta(cuenta);
	}
	
}
