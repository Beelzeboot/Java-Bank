<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	session.setAttribute("nombreJsp", "ModificarUsuario.jsp");
	String alert = "";
	int resultModicficarUsuario = -1;
	
	if(request.getAttribute("resultModificarUsuario") != null) {
		resultModicficarUsuario = (int)request.getAttribute("resultModificarUsuario");		
	}

%>
	
<% 
	
	switch(resultModicficarUsuario) {
	case 0:
		alert = "Usuario no existe, intente ingresando un usuario diferente";
		break;
	case 1:
		alert = "La contraseña ha sido modificada con éxito";
		break;
	case 2:
		alert = "Por favor, complete todos los campos";
		break;
	}

%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Modificar Usuario" />
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
						<h3 class="py-5 text-center">Modificar Contraseña Usuario</h3>
							<form action="servletUsuario" method="POST" autocomplete="off">
									<div class="form-floating mb-3">
									  <input type="number" class="form-control" id="txtDni" onblur="validarDni(this)" name="txtDni" placeholder="DNI">
									  <label for="txtDni">DNI</label>
									  <div id="txtDni" class="form-text">Por ejemplo: 12345678</div>
									</div>
									<div class="form-floating mb-3">
									  <input type="password" class="form-control" id="txtContrasena" name="txtContrasena" placeholder="Nueva Contraseña">
									  <label for="txtContrasena">Nueva Contraseña</label>
									  <div id="txtContrasena" class="form-text">Ingrese la nueva contraseña </div>
									</div><br>
								<div class="col-12 d-flex align-items-center justify-content-center">	
									<button class="btn btn-secondary" type="submit" name="btnModificar">Modificar</button>
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
		if(resultModicficarUsuario == 0 || resultModicficarUsuario == 2 ) {
	%>
		<div class="alert alert-danger fixed-top alert-dismissible fade show text-center" role="alert">
  <%
		} else if(resultModicficarUsuario == 1) {
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