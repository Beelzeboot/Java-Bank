<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Prestamo"%>

<%
	session.setAttribute("nombreJsp", "Reportes.jsp");
	
	String alert = "";
	ArrayList<Prestamo> prestamosEntreFechas = null;
	ArrayList<Prestamo> prestamosEntreMontos = null;
	Integer resultValidar = -1;
	Float maximo = -1.0f;
	Float minimo = -1.0f;
	float hombres = -1f;
	float mujeres = -1f;
	
	if(request.getAttribute("prestamosEntreFechas") != null) {
		prestamosEntreFechas = (ArrayList<Prestamo>)request.getAttribute("prestamosEntreFechas");
	}
	
	if(request.getAttribute("prestamosEntreMontos") != null) {
		prestamosEntreMontos = (ArrayList<Prestamo>)request.getAttribute("prestamosEntreMontos");
	}
	
	if(request.getAttribute("valorMaximo") != null && request.getAttribute("valorMinimo") != null){
		maximo = (Float)request.getAttribute("valorMaximo");
		minimo = (Float)request.getAttribute("valorMinimo"); 
	}
	
	if(request.getAttribute("resultValidar") != null) {
		resultValidar = (Integer)request.getAttribute("resultValidar");
	}
	
	if(request.getAttribute("hombres") != null){
		hombres = (float)request.getAttribute("hombres");
		mujeres = (float)request.getAttribute("mujeres");
	}
	
	
	switch(resultValidar) {
		case 2:
			alert = "La fecha de inicio no puede ser posterior a la fecha de fin";
			break;
		case 3:
			alert = "Por favor, complete las fechas";
			break;
		case 4:
			alert = "Por favor, complete los montos";
			break;
		case 5:
			alert = "Los montos tienen que ser mayor a cero";
			break;
	}
	
	// calcular el porcentaje de hombres y mujeres
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp">
	<jsp:param name="section" value="Alta Usuario" />
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
					if(usuario != null &&!usuario.getTipoUsuario()) { 
				%>
				<h3>Usted no tiene los permisos para ver este contenido</h3>
				<%
					} else {
				%>
				<div class="row justify-content-center">
					<div class="col-6 justify-content-center">
						<h3 class="py-5 text-center">Comparación de Montos de Préstamos</h3>
						<form class="mb-3" action="servletPrestamo" method="POST"
							autocomplete="off">
							<div class="row gx-3">
								<div class="col-6 form-floating mb-3 px-2">
									<input type="date" class="form-control" id="txtFechaInicio"
										name="txtFechaInicio" placeholder="Fecha de Inicio"> <label
										for="txtFechaInicio">Fecha de Inicio</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
									<input type="date" class="form-control" id="txtFechaFin"
										name="txtFechaFin" placeholder="Fecha de Fin"> <label
										for="txtFechaFin">Fecha de Fin</label>
								</div>
							</div>
							<div
								class="col-12 d-flex align-items-center justify-content-center">
								<button class="btn btn-secondary" type="submit"
									name="btnPrestamosEntreFechas">Generar reporte</button>
							</div>
						</form>
					</div>
				</div>
				<div class="row">
					<div class="col-12 ">
					
						<% 
							if(maximo != -1f) {
						%>
							<div class="container">
							    <div class="col p-3 mb-2 bg-info text-dark">
							        <h3 class="text-center">El mayor monto pedido entre las dos fechas es de:
							        	<span style="font-size: 1.5em;"> <%= String.format("%.2f", maximo) %> </span>
							        </h3>
							    </div>
			                	<div class="row">
								</div>
							    <div class="col p-3 mb-2 bg-warning text-dark">
							        <h3 class="text-center">El menor monto pedido entre las dos fechas es de:
							        	<span style="font-size: 1.5em;"> <%= String.format("%.2f", minimo) %> </span>
							        </h3>
							    </div>
							</div>
						<%
							}
							else if(request.getAttribute("valorMaximo") != null && resultValidar == 1 ){
						%>
							<div class="d-flex justify-content-center">
							    <div class="p-3 mb-2 bg-danger text-white">
							        <h3 class="text-center">No hay prestamos entre las fechas ingresadas</h3>
							    </div>
							</div>
								
						<%
							}
						%>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col-6 justify-content-center">
						<h3 class="py-5 text-center">Listar prestamos entre montos</h3>
						<form class="mb-3" action="servletPrestamo" method="POST"
							autocomplete="off">
							<div class="row gx-3">
								<div class="col-6 form-floating mb-3 px-2">
									<input type="number" class="form-control" id="txtMontoMayorA"
										name="txtMin" placeholder="Desde">
									<label for="txtMontoMayorA">Desde</label>
								</div>
								<div class="col-6 form-floating mb-3 px-2">
									<input type="number" class="form-control" id="txtMontoMenorA"
										name="txtMax" placeholder="Hasta">
									<label for="txtMontoMenorA">Hasta</label>
								</div>
							</div>
							<div
								class="col-12 d-flex align-items-center justify-content-center">
								<button class="btn btn-secondary" type="submit"
									name="btnPrestamosMontos">Generar reporte</button>
							</div>
						</form>
					</div>
				</div>
				
				<!-- Mostrar porcentaje -->
				<div class="row justify-content-center">
    				<div class="col-12">
        				<h3 class="py-3 text-center">Porcentaje de Hombres y Mujeres Registrados</h3>
        				<form action="servletUsuario" method="POST" autocomplete="off">
        				<div class="col-12 d-flex align-items-center justify-content-center">
        					<button class="btn btn-secondary" type="submit" name="btnPorcentajeGeneros">Obtener porcentaje</button>
        				</div>
        				</form>
        		
        				<%
        				if(request.getAttribute("hombres") != null){
        					
	        					if(hombres != -1){
	        			%>
			        				
			        					<div class="container" >
			        						 <div class="col p-4 mb-6">
			        						 	<div class=" -sm bg-info" >
				                					<h3 style="text-align:center;">Hombres:
				                					<span style="font-size: 1.5em;"> <%= String.format("%.2f", hombres) %>% </span>
				                				 	</h3>
			                				 	</div>
			                				 	<div class="row">
											    </div>
			        						 	<div class="col -sm bg-warning">
				                					<h3 style="text-align:center;">Mujeres: 
				                					<span style="font-size: 1.5em;"> <%= String.format("%.2f", mujeres) %>% </span>
				                				 	</h3>
				                				 </div>
			                				 </div>
			            				</div>
			        				
			        				
		        			<%
	        					}
	        					else{
	        				%>
	        						<h4>No hay usuarios</h4>
	        				<%
	        					}
        				}
        				%>
    				</div>
				</div>
				
				<div class="row">
					<div class="col-12">
						<%
								if(prestamosEntreMontos != null) {
							%>
						<table id="table_pagination" class="table table-hover">
							<thead class="bg-primary">
								<tr>
									<th scope="col">Num Cuenta</th>
									<th scope="col">Fecha</th>
									<th scope="col">Importe a Pagar</th>
									<th scope="col">Importe Pedido</th>
									<th scope="col">Plazo de Pago</th>
									<th scope="col">Cuotas</th>
									<th scope="col">Cuotas Pagadas</th>
									<th scope="col">Estado</th>
								</tr>
							</thead>
							<tbody>
								<% 
								  		for(Prestamo prestamo : prestamosEntreMontos) {
										%>
								<tr class="bg-light">
									<td scope="row"><%= prestamo.getCuenta().getNumCuenta() %></td>
									<td><%= prestamo.getFecha() %></td>
									<td><%= prestamo.getImporteAPagar() %></td>
									<td><%= prestamo.getImportePedido() %></td>
									<td><%= prestamo.getPlazoDePago() %></td>
									<td><%= prestamo.getCuotas() %></td>
									<td><%= prestamo.getCuotasPagadas() %></td>
									<td>
										<% 
														switch(prestamo.getEstado()) {
															case 0:
																out.println("<span class='text-secondary'>Prestamo prendiente de revision</span>");
																break;
															case 1:
																out.println("<span class='text-info'>Prestamo aprobado</span>");
																break;
															case 2:
																out.println("<span class='text-danger'>Prestamo rechazado</span>");
																break;
															case 3:
																out.println("<span class='text-success'>Prestamo pagado</span>");
																break;
														}
													%>
									</td>
								</tr>
								<%  
											}
										%>
							</tbody>
						</table>
						<%
								}
							%>
					</div>
				</div>
				<%
					}
				%>
			</div>
		</div>
	</div>

	<!-- ALERT -->
	<%
		if(resultValidar == 2 || resultValidar == 3 || resultValidar == 4 || resultValidar == 5) {
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
			<strong><%= alert %></strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>

		<script src="assets/bootstrap/js/bootstrap.bundle.js"></script>
		<script src="assets/script.js"></script>
</body>
</html>