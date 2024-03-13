package entidades;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Prestamo {
	private Integer codPrestamo;
	private Cuenta cuenta;
	private LocalDate fecha;
	private Float importeAPagar;
	private Float importePedido;
	private LocalDate plazoDePago;
	private Integer cuotas;
	private Integer cuotasPagadas;
	private Integer estado;
	private Float interes = 1.25f; // 25% f -> Float no Doble
	
	public Prestamo() {
		
	}
	
	public Prestamo(Cuenta cuenta, Float importePedido, Integer cuotas) {
		this.cuenta = cuenta;
		this.fecha = LocalDate.now();
		this.importeAPagar = importePedido * interes;
		this.importePedido = importePedido;
		this.plazoDePago = LocalDate.now().plusMonths(cuotas);
		this.cuotas = cuotas;
	}
	
	public Integer getCodPrestamo() {
		return codPrestamo;
	}
	
	public void setCodPrestamo(Integer codPrestamo) {
		this.codPrestamo = codPrestamo;
	}
	
	public Cuenta getCuenta() {
		return cuenta;
	}

	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}
	
	public String getFecha() {
		DateTimeFormatter myFormatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    String formattedDate = fecha.format(myFormatDate);
		
	    return formattedDate;
	}
	
	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
	}
	
	public Float getImporteAPagar() {
		return importeAPagar;
	}
	
	public void setImporteAPagar(Float importeAPagar) {
		this.importeAPagar = importeAPagar;
	}
	
	public Float getImportePedido() {
		return importePedido;
	}
	
	public void setImportePedido(Float importePedido) {
		this.importePedido = importePedido;
	}
	
	public String getPlazoDePago() {
		if(this.plazoDePago == null) {
			return null;
		}
		
		DateTimeFormatter myFormatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    String formattedDate = plazoDePago.format(myFormatDate);
		
	    return formattedDate;
	}
	
	public void setPlazoDePago(LocalDate plazoDePago) {	
		this.plazoDePago = plazoDePago;
	}
	
	public Integer getCuotas() {
		return cuotas;
	}
	
	public void setCuotas(Integer cuotas) {
		this.cuotas = cuotas;
	}
	
	public Integer getCuotasPagadas() {
		return cuotasPagadas;
	}

	public void setCuotasPagadas(Integer cuotasPagadas) {
		this.cuotasPagadas = cuotasPagadas;
	}
	
	public Integer getEstado() {
		return estado;
	}
	
	public void setEstado(Integer estado) {
		this.estado = estado;
	}
}

