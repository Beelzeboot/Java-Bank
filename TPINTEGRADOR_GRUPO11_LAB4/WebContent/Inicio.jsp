<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="entidades.Usuario"%>

<%
	application.setAttribute("Nombre", "BANCO GRUPO 11");

	String alert = "";
	Integer resultLogin = -1;

	if (request.getAttribute("resultLogin") != null) {
		resultLogin = (Integer) request.getAttribute("resultLogin");
	}

	switch (resultLogin) {
	case 0:
		alert = "El usuario aún no poseé una cuenta";
		break;
	case 2:
		alert = "Por favor, complete todos los campos";
		break;
	case 3:
		alert = "El usuario o la contraseña son incorrectas";
		break;
	case 4:
		alert = "El usuario se encuentra deshabilitado";
		break;

	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp">
	<jsp:param name="section" value="Inicio" />
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
			<%
				if (usuario != null) {
			%>
			<div class="col-12 text-center">
				<h1 class="my-5 text-center" style="font-size: 48px;">
					Bienvenido<br>
					<%=usuario.getNombre()%>
					<%=usuario.getApellido()%></h1>

				<%
					} else {
				%>
				<div class="col-6 text-center">
					<h3>Iniciar sesion</h3>
					<form action="servletLogin" method="POST" autocomplete="off">
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="txtUsuario"
								name="txtUsuario" placeholder=""> <label
								for="txtUsuario">Usuario</label>
						</div>
						<div class="form-floating mb-3">
							<input type="password" class="form-control" id="txtContrasena"
								name="txtContrasena" placeholder=""> <label
								for="txtContrasena">Contraseña</label>
						</div>
						<input type="hidden" name="login"></input>
						<button class="btn btn-secondary" type="submit" name="btnAceptar">Iniciar sesion</button>
					</form>
				</div>
				<%
					}
				%>
			</div>
		</div>
	</div>

	<!-- ALERT -->
	<%
		if (resultLogin == 0 || resultLogin == 2 || resultLogin == 3 || resultLogin == 4) {
	%>
	<div
		class="alert alert-danger fixed-top alert-dismissible fade show text-center"
		role="alert">
		<%
			} else {
		%>
		<div class="alert alert-danger d-none">
			<%
				}
			%>
			<strong><%=alert%></strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>

		<script src="assets/bootstrap/js/bootstrap.bundle.js"></script>
		<script src="assets/script.js"></script>
</body>