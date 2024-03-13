<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	session.setAttribute("nombreJsp","RealizarTransferencia.jsp");
	String alert = "";
	Integer resultCrearMovimiento = -1;
	
	if(request.getAttribute("resultCrearMovimiento") != null) {
		resultCrearMovimiento = (Integer)request.getAttribute("resultCrearMovimiento");		
	}
	
	switch(resultCrearMovimiento) {
		case 1:
			alert = "Transferencia realizada con éxito";
			break;
		case 2:
			alert = "Ha ocurrido un error realizando la transferencia";
			break;
		case 3:
			alert = "Por favor, complete todos los campos";
			break;
		case 4:
 			alert = "No puede transferir dinero a la misma cuenta";
 			break;
 	    case 5:
 			alert = "El monto a transferir no puede ser negativo";
 			break;
 		case 6:
 			alert = "El saldo de la cuenta es insuficiente";
 			break;
 		case 7:
 			alert = "Por favor, verifique el CBU";
 			break;
 		default:
 			alert = "Ha ocurrido un error";
 			break;
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Realizar Transferencia" />
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
						<div class="col-12">
						<h3>Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
						<div class="col-6 text-center">
						<h3 class="py-5 text-center">Realizar Transferencia</h3>						
						<form action="servletMovimiento" method="POST">
							<div class="form-floating mb-3">
								  <input type="text" class="form-control" id="txtNroCBU" maxlength="10" onblur="validarCBU(this)" name="txtNroCBU" placeholder="Nro de CBU">
								  <label for="txtNroCBU">N° de CBU</label>
								  <div id="txtNroCbuHelp" class="form-text">Ingrese 10 digitos para el N° de CBU</div>
							</div>
							<div class="form-floating mb-3">
								  <input type="text" class="form-control" id="txtMonto" name="txtMonto" placeholder="Monto $">
								  <label for="txtMonto">Monto $</label>
							</div>
							<div class="col-12 d-flex align-items-center justify-content-center">
								<button class="btn btn-secondary" type="submit" name="btnTransferir">Transferir</button>
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
		if(resultCrearMovimiento == 1) {
  %>
  	<div class="alert alert-success fixed-top alert-dismissible fade show text-center" role="alert">		
  <%
		} else if(resultCrearMovimiento == 2 || resultCrearMovimiento == 3 || resultCrearMovimiento == 4 || resultCrearMovimiento == 5 || resultCrearMovimiento == 6 || resultCrearMovimiento == 7) {
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