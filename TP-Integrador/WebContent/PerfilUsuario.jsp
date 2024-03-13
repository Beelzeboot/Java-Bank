<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	session.setAttribute("nombreJsp", "PerfilUsuario.jsp");
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp">
	<jsp:param name="section" value="Mi Perfil" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="includes/style.css">
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<%@include file="includes/nav.jsp"%>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-12">
				<% 
					if(usuario != null) { 
				%>
				<% 
						if(!usuario.getTipoUsuario()) { 
					%>
				<h3 class="my-5 text-center">Mi Perfil</h3>
				<div class="row gx-3">
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtNombre"
							name="txtNombre" value="<%= usuario.getNombre() %>"
							placeholder="Nombre" disabled> <label for="txtNombre">Nombre</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtApellido"
							name="txtApellido" value="<%= usuario.getApellido() %>"
							placeholder="Apellido" disabled> <label for="txtApellido">Apellido</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtDni" name="txtDni"
							value="<%= usuario.getDni() %>" placeholder="DNI" disabled>
						<label for="txtDni">DNI</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtCuil"
							name="txtCuil" value="<%= usuario.getCuil() %>"
							placeholder="CUIL" disabled> <label for="txtCuil">CUIL</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="date" class="form-control" id="fechaNacimiento"
							name="fechaNacimiento"
							value="<%= usuario.getFechaNacimiento() %>"
							placeholder="Fecha nacimiento" disabled> <label
							for="fechaNacimiento">Fecha nacimiento</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<select class="form-select" id="selectSexo" name="selectSexo"
							aria-label="Sexo" disabled>
							<option selected><%= "M".equals(usuario.getSexo()) == true ? "Masculino" : "Femenino" %></option>
						</select> <label for="selectSexo">Sexo</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<select class="form-select" id="selectNacionalidad"
							name="selectNacionalidad" aria-label="Nacionalidad" disabled>
							<option selected><%= usuario.getNacionalidad() %></option>
						</select> <label for="selectNacionalidad">Nacionalidad</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<select class="form-select" id="selectProvincia"
							name="selectProvincia" aria-label="Provincia" disabled>
							<option selected><%= usuario.getProvincia() %></option>
						</select> <label for="selectProvincia">Provincia</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<select class="form-select" id="selectLocalidad"
							name="selectLocalidad" aria-label="Localidad" disabled>
							<option selected><%= usuario.getLocalidad() %></option>
						</select> <label for="selectLocalidad">Localidad</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtDireccion"
							name="txtDireccion" value="<%= usuario.getDireccion() %>"
							placeholder="Direccion" disabled> <label
							for="txtDireccion">Direccion</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="email" class="form-control" id="txtCorreo"
							name="txtCorreo" value="<%= usuario.getCorreoElectronico() %>"
							placeholder="Email" disabled> <label for="txtCorreo">Email</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtTelefono"
							name="txtTelefono" value="<%= usuario.getTelefono() %>"
							placeholder="Telefono" disabled> <label for="txtTelefono">Telefono</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtUsuario"
							name="txtUsuario" value="<%= usuario.getNombreUsuario() %>"
							placeholder="Usuario" disabled> <label for="txtUsuario">Usuario</label>
					</div>
					<div class="col-6 form-floating mb-3 px-2">
						<input type="text" class="form-control" id="txtContrasena"
							name="txtContrasena" value="<%= usuario.getContrasena() %>"
							placeholder="Contraseña" disabled> <label
							for="txtContrasena">Contraseña</label>
					</div>
				</div>
				<%
						}
					%>

				<%
					}
				%>
			</div>
		</div>
	</div>

	<script src="assets/bootstrap/js/bootstrap.bundle.js"></script>
	<script src="assets/script.js"></script>
</body>
</html>