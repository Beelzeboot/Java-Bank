<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	session.setAttribute("nombreJsp", "AltaCuenta.jsp");
	String alert = "";
	if(request.getAttribute("resultAltaCuenta") != null) {
		alert = (String)request.getAttribute("resultAltaCuenta");		
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Alta Cuenta" />
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
						<div class="col-12 text-center">
						<h3>Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
					<div class="col-6 text-center">
						<h3 class="py-5 text-center">Alta de Cuenta</h3>
						<form class="mb-3" action="servletCuenta" method="POST" autocomplete="off">
							<div class="form-floating mb-3">
							  <input type="text" class="form-control" id="txtNroCuenta" maxlength="5" onblur="validarCuenta(this)" name="txtNroCuenta" placeholder="Nro de Cuenta">
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
							</div>
							
							<div class="form-floating mb-3">
							  <input type="text" class="form-control" id="txtNroCBU" maxlength="10" onblur="validarCBU(this)" name="txtNroCBU" placeholder="Nro de CBU">
							  <label for="txtNroCbu">N° de CBU</label>
							  <div id="txtNroCbuHelp" class="form-text">Ingrese 10 digitos para el N° de CBU</div>
							</div>
							<div class="col-12 d-flex align-items-center justify-content-center">
								<input type="hidden" name="btnAltaCuenta">
								<button class="btn btn-secondary" type="submit" name="btnAceptar">Aceptar</button>
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
		if(alert == "Alta exitosa") {
	%>
		<div class="alert alert-success fixed-top alert-dismissible fade show text-center" role="alert">
  <%
		} else if(!alert.isEmpty()) {
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