package entidades;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;



public class Usuario {
	private String dni;
	private String cuil;
	private String nombre;
	private String apellido;
	private String sexo;
	private String nacionalidad;
	private LocalDate fechaNacimiento;
	private String direccion;
	private String localidad;
	private String provincia;
	private String correoElectronico;
	private String telefono;
	private String nombreUsuario;
	private String contrasena;
	private Boolean tipoUsuario;
	private Boolean estado;
	
	public Usuario() {
		this.setDni(null);
		this.setCuil(null);
		this.setNombre(null);
		this.setApellido(null);
		this.setSexo(null);
		this.setNacionalidad(null);
		this.setFechaNacimiento(null);
		this.setDireccion(null);
		this.setLocalidad(null);
		this.setProvincia(null);
		this.setCorreoElectronico(null);
		this.setTelefono(null);
		this.setNombreUsuario(null);
		this.setContrasena(null);
		this.setTipoUsuario(false);
		this.setEstado(true);
	}
	
	public Usuario(String dni, String cuil, String nombre, String apellido, String sexo, String nacionalidad,
			String fechaNacimiento, String direccion, String localidad, String provincia, String correoElectronico, 
			String telefono, String nombreUsuario, String contrasena) {
		this.setDni(dni);
		this.setCuil(cuil);
		this.setNombre(nombre);
		this.setApellido(apellido);
		this.setSexo(sexo);
		this.setNacionalidad(nacionalidad);
		this.setFechaNacimiento(fechaNacimiento);
		this.setDireccion(direccion);
		this.setLocalidad(localidad);
		this.setProvincia(provincia);
		this.setCorreoElectronico(correoElectronico);
		this.setTelefono(telefono);
		this.setNombreUsuario(nombreUsuario);
		this.setContrasena(contrasena);
		this.setTipoUsuario(tipoUsuario);
		this.setEstado(estado);
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getCuil() {
		return cuil;
	}

	public void setCuil(String cuil) {
		this.cuil = cuil;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String getNacionalidad() {
		return nacionalidad;
	}

	public void setNacionalidad(String nacionalidad) {
		this.nacionalidad = nacionalidad;
	}

	public String getFechaNacimiento() {
		if(this.fechaNacimiento == null) {
			return null;
		}
		
		DateTimeFormatter myFormatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    String formattedDate = fechaNacimiento.format(myFormatDate);
		
	    return formattedDate;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); 
		LocalDate dateTime = fechaNacimiento != null ? LocalDate.parse(fechaNacimiento, formatter) : null;

		this.fechaNacimiento = dateTime;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getLocalidad() {
		return localidad;
	}

	public void setLocalidad(String localidad) {
		this.localidad = localidad;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getCorreoElectronico() {
		return correoElectronico;
	}

	public void setCorreoElectronico(String correoElectronico) {
		this.correoElectronico = correoElectronico;
	}

	public String getNombreUsuario() {
		return nombreUsuario;
	}

	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}

	public String getContrasena() {
		return contrasena;
	}

	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}

	public Boolean getTipoUsuario() {
		return tipoUsuario;
	}

	public void setTipoUsuario(Boolean tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}

	public Boolean getEstado() {
		return estado;
	}

	public void setEstado(Boolean estado) {
		this.estado = estado;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	
}
