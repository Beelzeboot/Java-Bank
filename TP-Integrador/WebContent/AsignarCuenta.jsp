<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%
	session.setAttribute("nombreJsp", "AsignarCuenta.jsp");
	Integer resultAsignarCuenta = -1;
	String alert = "";

	if (request.getAttribute("resultAsignarCuenta") != null) {
		resultAsignarCuenta = (Integer) request.getAttribute("resultAsignarCuenta");
	}

	switch (resultAsignarCuenta) {
	case 1:
		alert = "La cuenta ha sido asignada con éxito";
		break;
	case 3:
		alert = "Por favor, complete todos los datos";
		break;
	case 4:
		alert = "La cuenta no existe, ingrese una cuenta diferente";
		break;
	case 5:
		alert = "El usuario alcanzo el maximo de cuentas";
		break;
	case 6:
		alert = "El usuario no existe, ingrese un usuario diferente";
		break;
	case 7:
		alert = "La cuenta ya pertenece a un cliente";
		break;
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp">
	<jsp:param name="section" value="Asignar Cuenta" />
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
			<%
				if (!usuario.getTipoUsuario()) {
			%>
			<div class="col-12 text-center">
				<h3>Usted no tiene los permisos para ver este contenido</h3>
				<%
					} else {
				%>
				<div class="col-6 text-center">
					<h3 class="my-5 text-center">Asignar Cuenta</h3>
					<form action="servletCuenta" method="POST">
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="txtNroCuenta"
								maxlength="5" onblur="validarCuenta(this)" name="txtNroCuenta"
								placeholder="Nro de cuenta"> <label for="txtNroCuenta">N°
								de Cuenta</label>
							<div id="txtNroCuentaHelp" class="form-text">Ingrese 5 digitos para el N° de cuenta</div>
						</div>
						<div class="form-floating mb-3">
							<input type="number" class="form-control" id="txtDni"
								onblur="validarDni(this)" name="txtDni" placeholder="">
							<label for="txtDni">DNI</label>
							<div id="txtDniHelp" class="form-text">Por ejemplo: 12345678</div>
						</div>
						<div
							class="col-12 d-flex align-items-center justify-content-center">
							<input type="hidden" name="btnAsignarCuenta">
							<button class="btn btn-secondary" name="btnAsignar" onclick="return confirm('¿Estás seguro de que deseas asignar la cuenta?')" >Aceptar</button>
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
		if (resultAsignarCuenta == 3 || resultAsignarCuenta == 4
				|| resultAsignarCuenta == 5 || resultAsignarCuenta == 6 || resultAsignarCuenta == 7) {
	%>
	<div
		class="alert alert-danger fixed-top alert-dismissible fade show text-center"
		role="alert">

		<%
			} else if (resultAsignarCuenta == 1) {
		%>
		<div
			class="alert alert-success fixed-top alert-dismissible fade show text-center"
			role="alert">
			<%
				} else {
			%>
			<div
				class="alert alert-warning fixed-top alert-dismissible fade show text-center d-none"
				role="alert">
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
</html>