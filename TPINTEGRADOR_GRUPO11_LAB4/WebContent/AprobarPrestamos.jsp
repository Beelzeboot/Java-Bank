<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Prestamo"%>

<%
	session.setAttribute("nombreJsp", "AprobarPrestamos.jsp");
	String alert = "";
	ArrayList<Prestamo> prestamos = null;
	Integer resultAprobarPrestamo = -1, resultRechazarPrestamo = -1;
	
	if(request.getAttribute("prestamos") != null) {
		prestamos = (ArrayList<Prestamo>)request.getAttribute("prestamos");
	}
	
	if(request.getAttribute("resultAprobarPrestamo") != null) {
		resultAprobarPrestamo = (Integer)request.getAttribute("resultAprobarPrestamo");
	}
	
	if(request.getAttribute("resultRechazarPrestamo") != null) {
		resultRechazarPrestamo = (Integer)request.getAttribute("resultRechazarPrestamo");
	}
	
	if(resultAprobarPrestamo == 1) {
		alert = "El prestamo ha sido aprobado con exito";
	}

	if(resultRechazarPrestamo == 1) {
		alert = "El prestamo ha sido rechazado con exito";
	}
	
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Aprobar Prestamos" />
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
			<div class="col-12">
				<% 
					if(usuario != null) { 
				%>
					<% 
						if(!usuario.getTipoUsuario()) {
					%>
						<h3>Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
						<%
							if(prestamos.size() != 0) {
						%>
							<h3 class="my-5 text-center">Prestamos Solicitados</h3>
							<table id="table_pagination" class="table">
							  <thead>
							    <tr>
							    	<th scope="col">Prestamo #</th>
							      <th scope="col">Cuenta #</th>
							      <th scope="col">Fecha</th>
							      <th scope="col">Importe Pedido</th>
							      <th scope="col">Importe a Pagar</th>
							      <th scope="col">Cuotas</th>
							      <th scope="col"></th>
							    </tr>
							  </thead>
							  <tbody>
						  	<%
						  		
					  			for(Prestamo prestamo : prestamos) {
						  	%>
								    <tr>
								      <td class="cell-valign" scope="row"><%= prestamo.getCodPrestamo() %></td>
								      <td class="cell-valign" scope="row"><%= prestamo.getCuenta().getNumCuenta() %></td>
								      <td class="cell-valign"><%= prestamo.getFecha() %></td>
								      <td class="cell-valign">$ <%= prestamo.getImportePedido() %></td>
								      <td class="cell-valign">$ <%= prestamo.getImporteAPagar() %></td>
								      <td class="cell-valign"><%= prestamo.getCuotas() %></td>
								      <td class="cell-valign">
								      	<form class="d-inline-block me-2" action="servletPrestamo" method="POST">
													<input type="hidden" name="txtCodPrestamo" value="<%= prestamo.getCodPrestamo() %>">
								      		<button class="btn btn-success" name="btnAprobarPrestamo">Aprobar</button>
								      	</form>
								      	<form class="d-inline-block me-2" action="servletPrestamo" method="POST">
													<input type="hidden" name="txtCodPrestamo" value="<%= prestamo.getCodPrestamo() %>">
								      		<button class="btn btn-danger" name="btnRechazarPrestamo">Rechazar</button>
								      	</form>
								      </td>
								    </tr>
						    <%
						  		}
						    %>
						  </tbody>
						</table>
						<%
							} else {
						%>
							<h3 class="my-5 text-center">No hay prestamos pendientes de revision</h3>
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
		if(resultAprobarPrestamo == 1 || resultRechazarPrestamo == 1) {
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