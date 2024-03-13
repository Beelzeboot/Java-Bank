<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="entidades.Usuario"%>
<%@page import="entidades.Cuenta"%>
<%@page import="java.util.ArrayList"%>

<%
	int indiceCuentaActual = 0;
	Usuario usuario = null;
	ArrayList<Cuenta> cuentasUsuario = null;
	Cuenta cuentaActual = null;
%>

<%
	if (session.getAttribute("usuario") != null) {
		usuario = (Usuario) session.getAttribute("usuario");
	}

	if (session.getAttribute("cuentasUsuario") != null) {
		cuentasUsuario = (ArrayList<Cuenta>) session.getAttribute("cuentasUsuario");
	}

	if (session.getAttribute("indiceCuentaActual") != null) {
		indiceCuentaActual = (int) session.getAttribute("indiceCuentaActual");
	}

	if (session.getAttribute("cuentaActual") != null) {
		cuentaActual = (Cuenta) session.getAttribute("cuentaActual");
	}
%>

<nav class="navbar navbar-expand-md bg-primary navbar-dark mb-3" id="nav">
	<div class="container-fluid">
		<a class="navbar-brand text-uppercase fw-bolder" href="Inicio.jsp">
		<img src="./images/Banco1.png"></a>
		<a class="navbar-brand text-uppercase fw-bolder" href="Inicio.jsp"><%=application.getAttribute("Nombre")%></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<%
					if (usuario != null) {
				%>
				<%
					if (usuario.getTipoUsuario()) {
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false" > Usuarios </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="AltaUsuario.jsp">Alta</a></li>
						<li><a class="dropdown-item" href="BajaUsuario.jsp">Baja</a></li>
						<li><a class="dropdown-item" href="ModificarUsuario.jsp">Modificar</a></li>
						<li>
							<form action="servletUsuario" method="POST" autocomplete="off">
								<button class="dropdown-item btn btn-link" type="submit"
									name="btnMostrarUsuarios">Listar</button>
							</form>
						</li>
					</ul></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Cuentas </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="AltaCuenta.jsp">Alta</a></li>
						<li><a class="dropdown-item" href="BajaCuenta.jsp">Baja</a></li>
						<li><a class="dropdown-item" href="ModificarCuenta.jsp">Modificar</a></li>
						<li>
							<form action="servletCuenta" method="POST" autocomplete="off">
								<button class="dropdown-item btn btn-link" type="submit"
									name="btnMostrarCuentas">Listar</button>
							</form>
						</li>
						<li><a class="dropdown-item" href="AsignarCuenta.jsp">Asignar
								Cuenta</a></li>
					</ul></li>
				<li class="nav-item">
					<form action="servletPrestamo" method="POST">
						<button class="btn btn-link nav-link" name="btnAprobarPrestamos">Aprobar
							Prestamos</button>
					</form>
				</li>
				<li class="nav-item"><a class="btn btn-link nav-link"
					aria-current="page" href="Reportes.jsp">Reportes</a></li>
				<%
					} else { 
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Prestamos </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="SolicitarPrestamo.jsp">Solicitar
								Prestamo</a></li>
						<li>
							<form action="servletPrestamo" method="POST">
								<button class="dropdown-item btn btn-primary btn-link"
									type="submit" name="btnVerPrestamos">Ver Prestamos
									Solicitados</button>
							</form>
						</li>
					</ul></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Transferencias
				</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="RealizarTransferencia.jsp">Realizar
								Transferencia</a></li>
					</ul></li>
				<li class="nav-item">
					<form action="servletMovimiento" method="POST">
						<button class="btn btn-link nav-link" type="submit"
							name="btnVerMovimientos">Movimientos</button>
					</form>
				</li>
				<%
					}
				%>
				<%
					}
				%>
			</ul>
			<%
				if (usuario != null) {
			%>
			<div class="d-flex flex-column">
				<div class="text-end">
					<a href="#"
						class="d-block link-light text-decoration-none dropdown-toggle"
						id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
						<span class="d-inline-block me-2"> USUARIO: <%=usuario.getNombre()%>
							<%=usuario.getApellido()%>
					</span>
					</a>
					<div class="dropdown">
						<ul class="dropdown-menu dropdown-menu-end text-small"
							aria-labelledby="dropdownUser1">
							<%
								if (!usuario.getTipoUsuario()) {
							%>
							<li><a class="dropdown-item" href="PerfilUsuario.jsp">Perfil</a></li>
							<li><hr class="dropdown-divider"></li>
							<%
								}
							%>
							<li>
								<form action="servletLogin" method="POST">
									<input type="hidden" name="btnLogout"></input>
									<button class="dropdown-item" type="submit">Cerrar
										Sesion</button>
								</form>
							</li>
						</ul>
					</div>
				</div>
				<%
					if (!usuario.getTipoUsuario()) {
				%>
				<div class="text-end mt-2">
					<span class="my-auto" style="color: white;">Cuenta
						seleccionada:</span>
					<form class="d-inline-block" id="selectCuentas"
						action="servletPage" method="POST">
						<select class="my-auto" name="selectCuentas">
							<%
										for(int i = 0; i < cuentasUsuario.size(); i++) {
									%>
							<%
											if(indiceCuentaActual == i) {
										%>
							<option value="<%= i %>" selected="true"><%= cuentasUsuario.get(i).getNumCuenta() %></option>
							<%
											} else {	
										%>
							<option value="<%= i %>"><%= cuentasUsuario.get(i).getNumCuenta() %></option>
							<%
											}
										%>
							<%
	 									}
									%>
						</select>
					
					<div class="vr mx-1"></div>
					<div class="d-inline-block valign">
						<span class="my-auto" style="color: white;">CBU: <%= cuentaActual.getCbu() %></span>
					</div>
					<div class="vr mx-1"></div>
					<div class="d-inline-block">
						<span class="my-auto" style="color: white;">Saldo:$ <%= String.format("%.2f", cuentaActual.getSaldo()) %></span>
					</div>
					</form>
				</div>
				<%
					}
				%>
			</div>

			<%
				}
			%>

		</div>
	</div>
</nav>