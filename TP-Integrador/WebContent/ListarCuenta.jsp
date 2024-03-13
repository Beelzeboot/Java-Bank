<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Cuenta"%>
<%@page import="entidades.TipoCuenta"%>

<% 
	session.setAttribute("nombreJsp", "ListarCuenta.jsp");
	ArrayList<Cuenta> listaCuentas = null;
	if(request.getAttribute("listaC") != null)
	{
		listaCuentas = (ArrayList<Cuenta>)request.getAttribute("listaC");
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Listar Cuentas" />
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
						<h3 class="my-5 text-center">Usted no tiene los permisos para ver este contenido</h3>
					<%
						} else {
					%>
						<h3 class="my-5 text-center">Listar Cuentas</h3>
					<%
						}
					%>
					
				<%
					}
				%>
			</div>
			
			</div>	
			        
				
				    <div class="col-3 d-flex align-items-center">
				        <label for="selectCuenta" class="me-2">Filtro:</label>
				        <select class="form-select" id="filtro" onchange="filtrarTablaCuentas()" name="selectTipoCuenta" aria-label="Tipo de Cuenta">
							    <option selected>- Eliga el tipo de Cuenta -</option>
							    <option value="1">Cuenta Corriente</option>
							    <option value="2">Caja de Ahorros</option>
						</select>
				    </div>
			
			
			
			<div class="col-12 mt-4">
				<% 
					if(listaCuentas != null) {
				%>
					<table id="table_pagination" class="table table-hover">
					  <thead class="bg-primary">
					    <tr>
					    	<th scope="col">Num Cuenta</th>  
								<th scope="col">DNI titular</th>  
								<th scope="col">CBU</th>
								<th scope="col">Tipo de cuenta</th>
								<th scope="col">Saldo</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<% 
					  		for(Cuenta cuenta : listaCuentas) {
							%>
									<tr class="bg-light">     
								     <td scope="row"><%=cuenta.getNumCuenta() %> </td>    
								     <td><%= cuenta.getDni() == null ? "Cuenta no asignada" : cuenta.getDni() %></td>   
								     <td><%= cuenta.getCbu() %></td>
								     <td data-cod-tipo-cuenta="<%= cuenta.getTipoCuenta().getCodTipoCuenta() %>">
								     	<%= cuenta.getTipoCuenta().getCodTipoCuenta() == 1 ? "Cuenta Corriente" : "Caja de Ahorro"%></td>
									 <td><%= cuenta.getSaldo() %></td>    
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
	</div>
	
	<script src="assets/bootstrap/js/bootstrap.bundle.js"></script>
	<script src="assets/script.js"></script>
</body>
</html>