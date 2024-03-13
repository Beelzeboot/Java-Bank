<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	session.setAttribute("nombreJsp", "ModificarUsuario.jsp");
	String alert = "";
	Integer resultModificarCuenta = -1;
	
	if(request.getAttribute("resultModificarCuenta") != null) {
		resultModificarCuenta = (Integer)request.getAttribute("resultModificarCuenta");		
	}

		switch(resultModificarCuenta) {
			case 5:
				alert ="El monto del saldo tiene que ser mayor a cero";
				break;
			case 1:
				alert = "La cuenta ha sido modificada con éxito";
				break;
			case 4:
				alert = "La cuenta que intenta ingresar, no existe";
				break;
			case 3:
				alert = "Por favor, complete todos los datos";
				break;
		}
	
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Modificar Cuenta" />
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
			
				<% 
					if(usuario != null) { 
				%>
					<% 
						if(!usuario.getTipoUsuario()) { 
					%>
						<div class="col-12">
						<h3 class="my-5 text-center">Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
						<div class="col-6 text-center">
						<h3 class="my-5 text-center">Modificar Cuenta</h3>
						<form class="mb-3" action="servletCuenta" method="POST" autocomplete="off">
							<div class="form-floating mb-3">
							  <input type="text"  class="form-control" id="txtNroCuenta" maxlength="5" onblur="validarCuenta(this)" name="txtNroCuenta" placeholder="Nro de cuenta">
							  <label for="txtNroCuenta">N° de Cuenta</label>
							  <div id="txtNroCuentaHelp" class="form-text">Ingrese 5 digitos para el N° de cuenta</div>
							</div>
							<div class="form-floating mb-3">
							  <select class="form-select" id="selectTipoCuenta" name="selectTipoCuenta" aria-label="Tipo de Cuenta">
							    <option selected></option>
							    <option value="1">Cuenta Corriente</option>
							    <option value="2">Caja de Ahorros</option>
							  </select>
							  <label for="selectTipoCuenta">Tipo de cuenta</label>
							  <div id="selectTipoCuentaHelp" class="form-text">Ingrese el nuevo tipo de cuenta</div>
							</div>
							<div class="form-floating mb-3">
							  <input type="number" class="form-control" id="txtNuevoSaldo" name="txtNuevoSaldo" placeholder="Nuevo saldo">
							  <label for="txtNuevoSaldo">Nuevo saldo</label>
							  <div id="txtNuevoSaldoHelp" class="form-text">Ingrese el nuevo saldo de la cuenta</div>
							</div>
							<div class="col-12 d-flex align-items-center justify-content-center">
								<input type="hidden" name="btnModificarCuenta">
								<button class="btn btn-secondary" onclick="return confirm('¿Estás seguro de que deseas modificar la cuenta?')" type="submit" name="btnModificar">Aceptar</button>
							</div>
						</form>
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
	
	<!-- ALERT -->
	<%
		if(resultModificarCuenta == 3 || resultModificarCuenta == 4 || resultModificarCuenta == 5) {
	%>
		<div class="alert alert-danger fixed-top alert-dismissible fade show text-center" role="alert">
  <%
		} else if(resultModificarCuenta == 1) {
  %>
  	<div class="alert alert-success fixed-top alert-dismissible fade show text-center" role="alert">
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