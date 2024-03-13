<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Prestamo"%>

<%
	session.setAttribute("nombreJsp", "VerPrestamos.jsp");
	ArrayList<Prestamo> prestamos = null;
	String alert = "";
	Integer resultPagarCuotas = -1;

	if (request.getAttribute("prestamos") != null) {
		prestamos = (ArrayList<Prestamo>) request.getAttribute("prestamos");
	}

	if (request.getAttribute("resultPagarCuotas") != null) {
		resultPagarCuotas = (Integer) request.getAttribute("resultPagarCuotas");
	}

	switch (resultPagarCuotas) {
	case 1:
		alert = "Cuota pagada con exito";
		break;
	case 2:
		alert = "Saldo insuficiente";
		break;
	case 3:
		alert = "Por favor, seleccione las cuotas a pagar";
		break;
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp">
	<jsp:param name="section" value="Ver Prestamos" />
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
			<div class="col-12">
				<%
					if (usuario != null) {
				%>
				<%
					if (usuario.getTipoUsuario()) {
				%>
				<h3 class="my-5 text-center">Usted no tiene los permisos para ver este contenido</h3>
				<%
					} else {
				%>
				<h3 class="pt-5 text-center">Ver Prestamos</h3>
				<%
					if (prestamos != null) {
				%>
				<%
					if (prestamos.size() != 0) {
				%>
				
				<div class="col-3 d-flex align-items-center">
				        <label for="selectPrestamos" class="me-2">Filtro:</label>
				        <select class="form-select" id="filtro" onchange="filtrarTablaPrestamos()" name="selectPrestamos" aria-label="estado de prestamo">
							    <option selected>- Eliga el estado del Prestamo -</option>
							    <option value="0">Pendientes</option>
							    <option value="1">Aprobados</option>
							    <option value="2">Rechazado</option>
							    <option value="3">Pagado</option>
						</select>
				    </div>
			
			
			
			<div class="col-12 mt-4">
				
				
				<table id="table_pagination" class="table">
					<thead>
						<tr>
							<th scope="col">Nro Prestamo</th>
							<th scope="col">Nro Cuenta</th>
							<th scope="col">Fecha</th>
							<th scope="col">Importe Pedido</th>
							<th scope="col">Importe a Pagar</th>
							<th scope="col">Plazo a Pagar</th>
							<th scope="col">Monto Cuota</th>
							<th scope="col">Cuotas</th>
							<th scope="col">Pagar Cuota</th>
						</tr>
					</thead>
					<tbody>

						<%
							for (Prestamo prestamo : prestamos) {
						%>
						<tr>
							<td class="cell-valign"><%=prestamo.getCodPrestamo()%></td>
							<td class="cell-valign"><%=prestamo.getCuenta().getNumCuenta()%></td>
							<td class="cell-valign"><%=prestamo.getFecha()%></td>
							<td class="cell-valign">$ <%=String.format("%.2f", prestamo.getImportePedido())%></td>
							<td class="cell-valign">$ <%=String.format("%.2f", prestamo.getImporteAPagar())%></td>
							<td class="cell-valign"><%=prestamo.getPlazoDePago()%></td>
							<td class="cell-valign">$ <%=String.format("%.2f", (prestamo.getImporteAPagar() / prestamo.getCuotas()))%></td>
							<td class="cell-valign"><%=prestamo.getCuotas()%></td>
							<td class="cell-valign" data-estado="<%= prestamo.getEstado() %>">
								<%
									switch (prestamo.getEstado()) {
									case 0:
										out.println("<span class='text-secondary'>Prestamo prendiente de revision</span>");
										break;
									case 2:
										out.println("<span class='text-danger'>Prestamo rechazado</span>");
										break;
									case 3:
										out.println("<span class='text-success'>Prestamo pagado</span>");
										break;
									}
								%> 
			<%
 			if (prestamo.getEstado() == 1) {
			%>
				<form action="servletPrestamo" method="POST"
					class="d-flex flex-row">
					<div class="form-floating me-3" style="width: 120px;">
						<select class="form-select" id="selectCuotasAPagar"
							name="selectCuotasAPagar" aria-label="Cuotas a Pagar">
							<option selected></option>
							<%
								for (int i = 0; i < prestamo.getCuotas() - prestamo.getCuotasPagadas(); i++) {
							%>
							<option value="<%=i + 1%>"><%=i + 1%></option>
							<%
								}
							%>
						</select> <label for="selectCuotasAPagar">Cuotas a Pagar</label>
					</div>
					<div class=" align-items-center">
						<input type="hidden" name="txtCodPrestamo"
							value="<%=prestamo.getCodPrestamo()%>">
						<button class="btn btn-secondary" style="height: 100%;"
							type="submit" name="btnPagarCuota">Pagar Cuota</button>
					</div>
				</form> 
				<%
				 	}
				%>
						</td>
						</tr>

						<%
							}
						%>

					</tbody>
				</table>
				</div>
				<%
					} else {
				%>
				<h2 class="my-5 text-center">No hay prestamos aprobados para mostrar</h2>
				<%
					}
				%>
				<%
					}
				%>
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
		if (resultPagarCuotas == 1) {
	%>
	<div
		class="alert alert-success fixed-top alert-dismissible fade show text-center"
		role="alert">
		<%
			} else if (resultPagarCuotas == 2 || resultPagarCuotas == 3) {
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
</html>