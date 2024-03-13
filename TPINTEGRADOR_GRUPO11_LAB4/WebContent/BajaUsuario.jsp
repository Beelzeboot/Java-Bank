<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	session.setAttribute("nombreJsp", "BajaUsuario.jsp");
	String alert = "";
	Integer resultBajaUsuario = -1;

	if(request.getAttribute("resultBajaUsuario") != null) {
		resultBajaUsuario = (Integer)request.getAttribute("resultBajaUsuario");		
	}
		
		switch(resultBajaUsuario) {
			case 1:
				alert = "Baja exitosa";
				break;
			case 3:
				alert = "Por favor, complete todos los campos";
				break;
			case 4:
				alert = "El usuario no existe, ingrese un usuario diferente";
				break;
		}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Baja Usuario" />
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
						<h3 class="py-5 text-center">Baja de Usuario</h3>		
						<form action="servletUsuario" method="POST" autocomplete="off">
							<div class="form-floating mb-3">
								  <input type="number" class="form-control" id="txtDni" onblur="validarDni(this)" name="txtDni" placeholder="DNI">
								  <label for="txtDni">DNI</label>
								  <div id="txtDniHelp" class="form-text">Por ejemplo: 12345678</div>
							</div>
								<div class="col-12 d-flex align-items-center justify-content-center">	
									<input type="hidden" name="btnBajaUsuario">						
									<button id="btnBaja" class="btn btn-secondary" onclick="return confirmarBaja()" type="submit">Dar de Baja</button>
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
		if(resultBajaUsuario == 1) {
	%>
		<div class="alert alert-success fixed-top alert-dismissible fade show text-center" role="alert">
  <%
		} else if(resultBajaUsuario == 3 || resultBajaUsuario == 4) {
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