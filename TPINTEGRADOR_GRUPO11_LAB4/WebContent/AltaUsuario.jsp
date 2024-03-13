<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	session.setAttribute("nombreJsp", "AltaUsuario.jsp");
	String alert = "";
	Integer resultAltaUsuario = -1;
	
	if(request.getAttribute("resultAltaUsuario") != null) {
		resultAltaUsuario = (Integer)request.getAttribute("resultAltaUsuario");		
	}
	
	switch(resultAltaUsuario) {
		case 1:
			alert = "Alta exitosa";
			break;
		case 2:
			alert = "El usuario ya existe, ingrese un usuario diferente";
			break;
		case 3:
			alert = "Por favor, complete todos los campos";
			break;
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Alta Usuario" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="includes/style.css">
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<%@include file="includes/nav.jsp" %>	
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
						<h3>Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
						<h3 class="py-5 text-center">Alta de Usuario</h3>
						<form class="mb-3" action="servletUsuario" method="POST" autocomplete="off">
							<div class="row gx-3">
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="text" class="form-control" id="txtNombre" name="txtNombre" placeholder="">
								  <label for="txtNombre">Nombre</label>
								  <div id="txtNombreHelp" class="form-text">Por ejemplo: Jorge</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="text" class="form-control" id="txtApellido" name="txtApellido" placeholder="">
								  <label for="txtApellido">Apellido</label>
								  <div id="txtApellidoHelp" class="form-text">Por ejemplo: Lopez</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="number" class="form-control" id="txtDni" onblur="validarDni(this)" name="txtDni" placeholder="">
								  <label for="txtDni">DNI</label>
								  <div id="txtDniHelp" class="form-text">Por ejemplo: 12345678</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="text" class="form-control" id="txtCuil" onblur="validarCuil(this)" name="txtCuil" placeholder="">
								  <label for="txtCuil">CUIL</label>
								  <div id="txtCuilHelp" class="form-text">Por ejemplo: 20-12345678-5</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" placeholder="">
								  <label for="fechaNacimiento">Fecha nacimiento</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <select class="form-select" id="selectSexo" name="selectSexo" aria-label="Sexo">
								    <option selected></option>
								    <option value="F">Femenino</option>
								    <option value="M">Masculino</option>
								  </select>
								  <label for="selectSexo">Sexo</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <select class="form-select" id="selectNacionalidad" name="selectNacionalidad" aria-label="Nacionalidad">
								    <option selected></option>
								    <option value="Argentina">Argentina</option>
								    <option value="Uruguay">Uruguay</option>
								    <option value="Brasil">Brasil</option>
								  </select>
								  <label for="selectNacionalidad">Nacionalidad</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <select class="form-select" id="selectProvincia" name="selectProvincia" aria-label="Provincia">
								    <option selected></option>
								    <option value="Buenos Aires">Buenos Aires</option>
								    <option value="Santa Fe">Santa Fe</option>
								    <option value="Cordoba">Cordoba</option>
								    <option value="Corrientes">Montevideo</option>
								    <option value="Maldonado">Maldonado</option>
								    <option value="Colonia">Colonia</option>
								    <option value="Rio de Janeiro">Rio de Janeiro</option>
								    <option value="Sao Paulo">Sao Paulo</option>
								    <option value="Porto Alegre">Porto Alegre</option>
								  </select>
								  <label for="selectProvincia">Provincia</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <select class="form-select" id="selectLocalidad" name="selectLocalidad" aria-label="Localidad">
								    <option selected></option>
								    <option value="Capital Federal">Capital Federal</option>
								    <option value="Gran Buenos Aires">Gran Buenos Aires</option>						
								    <option value="Santa Fe">Santa Fe</option>
								    <option value="Rosario">Rosarioe</option>
								    <option value="Villa Carlos Paz">Villa Carlos Paz</option>
								    <option value="Cordoba">Cordoba</option>								
								    <option value="Pocitos">Pocitos</option>
								    <option value="Colonia del Sacramento">Colonia del Sacramento</option>
								    <option value="Rio de Janeiro">Rio de Janeiro</option>
								    <option value="Sao Paulo">Sao Paulo</option>
								    <option value="Porto Alegre">Porto Alegre</option>
								  </select>
								  <label for="selectLocalidad">Localidad</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="text" class="form-control" id="txtDireccion" name="txtDireccion" placeholder="Direccion">
								  <label for="txtDireccion">Direccion</label>
								  <div id="txtDireccionHelp" class="form-text">Por ejemplo: Avenida Santa Fe 1060</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="email" class="form-control" id="txtCorreo" name="txtCorreo" placeholder="Email">
								  <label for="txtCorreo">Email</label>
								  <div id="txtCorreoHelp" class="form-text">Por ejemplo: jorge.lopez@gmail.com</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="number" class="form-control" id="txtTelefono" name="txtTelefono" placeholder="Telefono">
								  <label for="txtTelefono">Telefono</label>
								  <div id="txtTelefonoHelp" class="form-text">Por ejemplo: 1167973098</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="text" class="form-control" id="txtUsuario" name="txtUsuario" placeholder="Usuario">
								  <label for="txtUsuario">Usuario</label>
								  <div id="txtUsuarioHelp" class="form-text">Por ejemplo: jlopez</div>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="password" class="form-control" id="txtContrasena" name="txtContrasena" placeholder="Contraseña">
								  <label for="txtContrasena">Contraseña</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
								  <input type="password" class="form-control" id="txtConfirmarContrasena" onblur="validarContrasenas()" name="txtConfirmarContrasena" placeholder="Confirmar contraseña">
								  <label for="txtConfirmarContrasena">Confirmar contraseña</label>
								</div>
								<input type="hidden" name="altaUsuario">
								<div class="col-12 d-flex align-items-center justify-content-center">
									<button class="btn btn-secondary" type="submit" name="btnAceptar">Aceptar</button>
								</div>
							</div>
						</form>
					<%
						}
					%>
					
				<%
					}
				%>
			</div>
		</div>
	</div>
	
	<!-- ALERT -->
	<%
		if(resultAltaUsuario == 1) {
	%>
		<div class="alert alert-success fixed-top alert-dismissible fade show text-center" role="alert">
  <%
		} else if(resultAltaUsuario == 2 || resultAltaUsuario == 3) {
  %>
  	<div class="alert alert-danger fixed-top alert-dismissible fade show text-center" role="alert">		
	<%
		} else if(resultAltaUsuario == 3) {
  %>
  	<div class="alert alert-danger fixed-top alert-dismissible fade show text-center" role="alert">	
  <%
		} else {
	%>
		<div class="alert alert-danger d-none">
	<%
		}
	%>
			<strong><%= alert %></strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	
	<script src="assets/bootstrap/js/bootstrap.bundle.js"></script>
	<script src="assets/script.js"></script>
</body>
</html>