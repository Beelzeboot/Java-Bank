package entidades;

import java.time.LocalDate;

public class Cuenta {
	private String numCuenta;
	private String dni;
	private LocalDate fechaCreacion;
	private TipoCuenta tipoCuenta;
	private String cbu;
	private Float saldo;
	private Boolean estado;
	
	public Cuenta() {
		this.setNumCuenta(null);
		this.setDni(null);
		this.setFechaCreacion(null);
		this.setTipoCuenta(null);
		this.setCbu(null);
		this.setSaldo(null);
		this.setEstado(null);
	}
	
	public Cuenta(String numCuenta, TipoCuenta tipoCuenta, String nroCbu) {
		this.setNumCuenta(numCuenta);
		this.setDni(null);
		this.setFechaCreacion(LocalDate.now());
		this.setTipoCuenta(tipoCuenta);
		this.setCbu(nroCbu);
		this.setSaldo(10000f);
		this.setEstado(true);
	}
	
	public String getNumCuenta() {
		return numCuenta;
	}

	public void setNumCuenta(String numCuenta) {
		this.numCuenta = numCuenta;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public LocalDate getFechaCreacion() {
		return fechaCreacion;
	}

	public void setFechaCreacion(LocalDate fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public TipoCuenta getTipoCuenta() {
		return tipoCuenta;
	}

	public void setTipoCuenta(TipoCuenta tipoCuenta) {
		this.tipoCuenta = tipoCuenta;
	}

	public String getCbu() {
		return cbu;
	}

	public void setCbu(String cbu) {
		this.cbu = cbu;
	}

	public Float getSaldo() {
		return saldo;
	}

	public void setSaldo(Float saldo) {
		this.saldo = saldo;
	}

	public Boolean getEstado() {
		return estado;
	}

	public void setEstado(Boolean estado) {
		this.estado = estado;
	}	
}
