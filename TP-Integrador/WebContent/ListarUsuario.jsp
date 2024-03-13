<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.ArrayList"%>

<% 
	session.setAttribute("nombreJsp", "ListarUsuario.jsp");
	ArrayList<Usuario> listaUsuarios = null;
	if(request.getAttribute("listaU") != null) {
		listaUsuarios = (ArrayList<Usuario>) request.getAttribute("listaU");
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/head.jsp" >
  <jsp:param name="section" value="Listar Usuarios" />
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
						<h3 class="my-5 text-center">Listar Usuarios</h3>
					<%
						}
					%>
					
				<%
					}
				%>
			</div>
		</div>	
			        
				
				    <div class="col-2 d-flex align-items-center">
				        <label for="selectSexo" class="me-2">Filtro:</label>
				        <select class="form-select form-select-sm" id="filtro" onchange="filtrarTablaUsuarios()" name="selectSexo" aria-label="Sexo">
				            <option selected>- Eliga el sexo -</option>
				            <option value="F">Femenino</option>
				            <option value="M">Masculino</option>
				        </select>
				    </div>
				
					
			<div class="col-12 mt-4">
				<% 
					if(listaUsuarios != null) {
				%>						
					<table id="table_pagination" class="table table-hover">
					  <thead class="bg-primary">
					    <tr>
					    	<th scope="col">DNI</th>
					    	<th scope="col">CUIL</th>  
							<th scope="col">Nombre y Apellido</th>
							<th scope="col">Sexo</th>  
							<th scope="col">Fecha de Nacimiento</th>
							<th scope="col">Direccion</th>
							<th scope="col">Localidad</th>
							<th scope="col">Provincia</th>
							<th scope="col">Correo Electronico</th>
							<th scope="col">Telefono</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<% 
					  		for(Usuario user : listaUsuarios) {	
					  			if(user.getEstado()){
							%>

									<tr class="bg-light">
								    <td scope="row"><%= user.getDni() %> </td>    
								    <td><%= user.getCuil() %></td>   
							    	<td><%= user.getNombre() %> <%= user.getApellido() %></td>
							    	<td><%= user.getSexo() %></td>        
								    <td><%= user.getFechaNacimiento() %></td>    
								    <td><%= user.getDireccion() %></td>
								    <td><%= user.getLocalidad() %></td>
								    <td><%= user.getProvincia() %></td>    
								    <td><%= user.getCorreoElectronico() %></td>    
								    <td><%= user.getTelefono() %></td>   
									</tr>
									
							<%  
						  			}
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