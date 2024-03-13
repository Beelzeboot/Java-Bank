package entidades;

import java.time.LocalDate;

public class Movimiento {
	private Integer codMovimiento;
	private LocalDate fechaMovimiento;
	private String detalle;
	private Float importe;
	private TipoMovimiento tipoMovimiento;
	private String numeroCuenta;
	
	public Movimiento() {
		
	}
	
	public Movimiento(Cuenta cuenta, Float monto, Integer tipoMov) {
	    this.setFechaMovimiento(LocalDate.now());
	    this.setImporte(monto);
	    
	    switch (tipoMov) {
	        case 1:
	            this.setDetalle("Alta de Cuenta por $" + String.format("%.02f", monto));
	            break;
	        case 2:
	            this.setDetalle("Prestamo acreditado por $" + String.format("%.02f", monto));
	            break;
	        case 3:
	            this.setDetalle("Pago de prestamo por $" + String.format("%.02f", monto));
	            break;
	        case 4:
	            this.setDetalle("Transferencia enviada por $" + String.format("%.02f", monto));
	            break;
	        case 5:
	            this.setDetalle("Transferencia recibida por $" + String.format("%.02f", monto));
	            break;
	    }

	    TipoMovimiento tipoMovimiento = new TipoMovimiento();
	    
	    if (tipoMov == 1) {
	        tipoMovimiento.setDescripcion("Alta Cuenta");
	        tipoMovimiento.setCodTipoMovimiento(1);
	    } else if (tipoMov == 2) {
	        tipoMovimiento.setDescripcion("Prestamo Acreditado");
	        tipoMovimiento.setCodTipoMovimiento(2);
	    } else if (tipoMov == 3) {
	        tipoMovimiento.setDescripcion("Pago Prestamo");
	        tipoMovimiento.setCodTipoMovimiento(3);
	    } else if (tipoMov == 4 || tipoMov == 5) {
	        tipoMovimiento.setDescripcion("Transferencia");
	        tipoMovimiento.setCodTipoMovimiento(4);
	    }

	    this.setTipoMovimiento(tipoMovimiento);
	    this.setNumeroCuenta(cuenta.getNumCuenta());
	}
	
	public Integer getCodMovimiento() {
		return codMovimiento;
	}
	
	public void setCodMovimiento(Integer codMovimiento) {
		this.codMovimiento = codMovimiento;
	}
	
	public LocalDate getFechaMovimiento() {
	    return fechaMovimiento;
	}
	
	public void setFechaMovimiento(LocalDate fechaMovimiento) {
		this.fechaMovimiento = fechaMovimiento;
	}
	
	public String getDetalle() {
		return detalle;
	}
	
	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}
	
	public Float getImporte() {
		return importe;
	}
	
	public void setImporte(Float importe) {
		this.importe = importe;
	}
	
	public TipoMovimiento getTipoMoviento() {
		return tipoMovimiento;
	}
	
	public void setTipoMovimiento(TipoMovimiento tipoMovimiento) {
		this.tipoMovimiento = tipoMovimiento;
	}
	
	public String getNumeroCuenta() {
		return numeroCuenta;
	}
	
	public void setNumeroCuenta(String numeroCuenta) {
		this.numeroCuenta = numeroCuenta;
	}
}
