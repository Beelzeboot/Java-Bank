<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	session.setAttribute("nombreJsp", "BajaCuenta.jsp");
	String alert = "";
	Integer resultBajaCuenta = -1;
	
	if(request.getAttribute("resultBajaCuenta") != null) {
		resultBajaCuenta = (Integer)request.getAttribute("resultBajaCuenta");		
	}
	
		switch(resultBajaCuenta) {
			case 0:
				alert ="Ha ocurrido un error dando de baja la cuenta";
				break;
			case 1:
				alert = "Baja exitosa";
				break;
			case 2:
				alert = "La cuenta que intenta ingresar, no existe";
				break;
			case 3:
				alert = "Ingrese un número de cuenta";
				break;
		}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Baja Cuenta" />
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
						<h3>Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
						<div class="col-6 text-center">
						<h3 class="my-5 text-center">Baja de Cuenta</h3>
						<form id="bajaForm" action="servletCuenta" method="POST" autocomplete="off">
							<div class="form-floating mb-3">
							  <input type="text"  class="form-control" id="txtNroCuenta" maxlength="5" onblur="validarCuenta(this)" name="txtNroCuenta" placeholder="Nro de cuenta">
							  <label for="txtNroCuenta">N° de Cuenta</label>
							  <div id="txtNroCuentaHelp" class="form-text">Ingrese 5 digitos para el N° de cuenta</div>
							</div>
							<div class="col-12 d-flex align-items-center justify-content-center">
								<input type="hidden" name="btnBajaCuenta">
								<button id="btnBaja" onclick="return confirmarBajaCuenta()" class="btn btn-secondary" type="submit">Aceptar</button>
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
		if(resultBajaCuenta == 1) {
	%>
		<div class="alert alert-success fixed-top alert-dismissible fade show text-center" role="alert">
  <%
		} else if(resultBajaCuenta == 0 || resultBajaCuenta == 2 || resultBajaCuenta == 3 || resultBajaCuenta == 4) {
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
		
	<!-- MODAL (MENSAJE CONFIRMACION) -->
	<div id="bajaModal" class="modal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Cuenta #<span id="spanInfoBaja"></span></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>Esta seguro que desea dar de baja esta cuenta?</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
					<button id="btnBajaModal" class="btn btn-primary" type="button">Dar de Baja</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script src="assets/bootstrap/js/bootstrap.bundle.js"></script>
	<script src="assets/script.js"></script>
</body>
</html>