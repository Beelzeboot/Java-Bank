<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%
	session.setAttribute("nombreJsp","SolicitarPrestamo.jsp");
	String alert = "";
	Integer resultSolicitarPrestamo = -1;
	
	if(request.getAttribute("resultSolicitarPrestamo") != null) {
		resultSolicitarPrestamo = (Integer)request.getAttribute("resultSolicitarPrestamo");		
	}
	
	switch(resultSolicitarPrestamo) {
		case 1:
			alert = "El prestamo ha sido solicitado con éxito";
			break;
		case 2:
			alert = "Ha ocurrido un error en la solicitud del prestamo";
			break;
		case 3:
			alert = "Por favor, complete todos los campos";
			break;
		case 4:
			alert = "El monto del prestamo tiene que ser mayor a cero";
			break;
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Solicitar Prestamo" />
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
						if(usuario.getTipoUsuario()) {
					%>
						<div class="col-12 text-center">
						<h3>Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
					<div class="col-6 text-center">
						<h3 class="my-5 text-center">Solicitud de prestamo</h3>
						<form action="servletPrestamo" method="POST"> 
							<div class="form-floating mb-3">
							  <select class="form-select px-3" id="selectCuotas" name="selectCuotas" aria-label="Cantidad de Cuotas">
							    <option selected></option>
							    <option value="3">3</option>
									<option value="6">6</option>
									<option value="9">9</option>
									<option value="12">12</option>
							  </select>
							  <label for="selectCuotas">Cuotas</label>
							  <div id="selectCuotasHelp" class="form-text">Seleccione la cantidad de cuotas</div>
							</div>
							<div class="form-floating mb-3">
							  <input type="text" class="form-control" id="txtMonto" name="txtMonto" placeholder="Monto">
							  <label for="txtMonto">Monto $</label>
							  <div id="txtMontoHelp" class="form-text">Al monto tendrá un interes del 25%</div>
							</div>
							<div class="col-12 d-flex align-items-center justify-content-center">
								<button class="btn btn-secondary" type="submit" name="btnSolicitar">Solicitar Prestamo</button>
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
		if(resultSolicitarPrestamo == 1) {
	%>
		<div class="alert alert-success fixed-top alert-dismissible fade show text-center" role="alert">
  <%
		} else if(resultSolicitarPrestamo == 2 || resultSolicitarPrestamo == 3 || resultSolicitarPrestamo == 4) {
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