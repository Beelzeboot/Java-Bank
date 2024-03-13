package negocio;

import java.util.ArrayList;

import dao.CuentaDAO;
import dao.UsuarioDAO;
import entidades.Cuenta;
import entidades.TipoCuenta;
import entidades.Usuario;
import interfaces.ICuentaDAO;
import interfaces.ICuentaNegocio;
import interfaces.IUsuarioDAO;


public class CuentaNegocio implements ICuentaNegocio {
	ICuentaDAO cDao = new CuentaDAO();
	IUsuarioDAO uDao = new UsuarioDAO();
	Cuenta cuenta = new Cuenta();
	Usuario usuario = new Usuario();
		
	@Override
	public String altaCuenta(String numCuenta, String tipoCuenta, String nroCbu) {
		if(numCuenta.isEmpty() || tipoCuenta.isEmpty() || nroCbu.isEmpty()) return "Por favor, complete todos los campos";
		
		TipoCuenta tipoC = new TipoCuenta();
		tipoC.setCodTipoCuenta(Integer.parseInt(tipoCuenta));
		
		cuenta = new Cuenta(numCuenta, tipoC, nroCbu);

		if(cDao.existe(cuenta)) return "La cuenta o el CBU ingresados ya existen";
		
		if(cDao.altaCuenta(cuenta)==0) {
			return "Ha ocurrido un error dando de alta la cuenta";
		}
		
		return "Alta exitosa";
	}
	
	@Override
	public boolean existe(Cuenta cuenta) {
		return cDao.existe(cuenta);
	}
	
	@Override
	public int bajaCuenta(String numCuenta) {
		if(numCuenta.isEmpty()) return 3;
		
		cuenta.setNumCuenta(numCuenta);
		if(!cDao.existe(cuenta)) return 2;
			
		return cDao.bajaCuenta(cuenta);
	}
	
	@Override
	public int actualizarCuenta(String numCuenta, String tipoCuentaNuevo, String nuevoSaldo) {
		if(numCuenta.isEmpty() || tipoCuentaNuevo.isEmpty() || nuevoSaldo.isEmpty()) return 3;
		if(Float.parseFloat(nuevoSaldo) < 0) return 5;
		
		TipoCuenta tipoC = new TipoCuenta();
		tipoC.setCodTipoCuenta(Integer.parseInt(tipoCuentaNuevo));
		
		cuenta.setNumCuenta(numCuenta);		
		cuenta = cDao.getCuenta(cuenta);
		if(!cDao.existe(cuenta)) return 4; 
		cuenta.setSaldo(Float.parseFloat(nuevoSaldo));
		cuenta.setTipoCuenta(tipoC);
			
		return cDao.actualizarCuenta(cuenta);
	}
	
	@Override
	public ArrayList<Cuenta> obtenerCuentas() {
		return cDao.obtenerCuentas();
	}
	
	@Override
	public ArrayList<Cuenta> obtenerCuentasUsuario(Usuario usuario) {
		return cDao.obtenerCuentasUsuario(usuario);
	}
	
	@Override
	public int asignarCuenta(String numCuenta, String dni) {
		if(numCuenta.isEmpty() || dni.isEmpty()) return 3;

		usuario.setDni(dni);
		
		if(uDao.existe(usuario)) {
			usuario = uDao.getUsuario(usuario);		
			if(cDao.cantidadCuentasUsuario(usuario) >= 3) return 5;
		} else return 6;	
				
		cuenta.setNumCuenta(numCuenta);
			
		if(cDao.existe(cuenta)) {
			cuenta = cDao.getCuenta(cuenta);
		} else return 4;	
		
		if(cuenta.getDni() != null) {
			if(!cuenta.getDni().equals(usuario.getDni())) return 7;
		}		
		cuenta.setDni(dni);
					
		return cDao.asignarCuenta(cuenta);		 
	}

}
