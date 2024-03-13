<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Movimiento"%>

<%
	session.setAttribute("nombreJsp","Movimientos.jsp");
	ArrayList<Movimiento> movimientos = null;
	
	if(request.getAttribute("movimientos") != null) {
		movimientos = (ArrayList<Movimiento>)request.getAttribute("movimientos");
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Movimientos" />
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
						if(usuario.getTipoUsuario()) {
					%>
						<h3>Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
						<h3 class="my-5 text-center">Movimientos</h3>		
						<table id="table_pag" class="table">
						  <thead>
						    <tr>
						      <th scope="col">Fecha</th>
						      <th scope="col">Detalle</th>
						      <th scope="col">Monto</th>
						    </tr>
						  </thead>
						  <tbody>
						  	<%
						  	for (int i = movimientos.size() - 1; i >= 0; i--) {
						        Movimiento movimiento = movimientos.get(i);
						  	%>
							    <tr>
							      <td><%= movimiento.getFechaMovimiento() %></td>
							      <td><%= movimiento.getDetalle() %></td>
							      <td>
							      	<%
							      		if(movimiento.getDetalle().contains("enviada") || movimiento.getDetalle().contains("Pago") ) {
							      	%>
							      		<span class='text-danger'>- $ <%= String.format("%.02f", movimiento.getImporte()) %></span>
							      	<%
							      		} else if (movimiento.getDetalle().contains("Alta") || movimiento.getDetalle().contains("acreditado") || movimiento.getDetalle().contains("recibida") ) {
							      	%>
							      		<span class='text-success'>+ $ <%= String.format("%.02f", movimiento.getImporte()) %></span>
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
					<%
						}
					%>
					
				<%
					}
				%>
			</div>
		</div>
	</div>
	
	
	<script src="assets/bootstrap/js/bootstrap.bundle.js"></script>
	<script src="assets/script.js"></script>
</body>
</html>