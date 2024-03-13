<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<title><%= application.getAttribute("Nombre") %> - ${param.section}</title>
	
	<link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap.css">
	
	<!-- DATATABLES (LISTADO PAGINADO) -->
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
	<link rel="stylesheet" type="text/css" href="assets/styles.css">
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
	<script>
			function validarDni(input) {
			    var valor = input.value.trim();
			    
			    if (valor === "") {
			        
			    } else {
			        var regex = /^\d{7,8}$/;

			        if (!regex.test(valor)) {
			            alert("El DNI debe tener entre 7 y 8 dígitos numéricos");
			            input.value = ''; 
			        }
			    }
			}
			
			function confirmarBaja() {
	            // Confirmar la baja solo si el DNI no está vacío
	            var dniInput = document.getElementById('txtDni');
	            if (dniInput.value.trim() === "") {
	                alert('El DNI no puede estar vacío. Por favor, ingréselo.');
	                return false; // Detiene el evento onclick
	            }

	            return confirm('¿Estás seguro de que deseas dar de baja el usuario?');
	        }

		
			function validarCuil(input) {
				var valor = input.value.trim();
			    
			    if (valor === ""){ 
			    
			    }else {	
			    	var regex = /^\d{2}-\d{7,8}-\d{1}$/;
		
			   		 if (!regex.test(valor)) {
					       alert("El formato no es correcto");
					       input.value = ''; 
			    	}
				}
			}
			
			 function validarCuenta(input) {
				 var valor = input.value.trim();
				    
				    if (valor === ""){
				    	
				    }else {
		           		 var cuenta = document.getElementById("txtNroCuenta").value;
		           		 if (cuenta.length !== 5 || isNaN(cuenta)) {
		                	alert("La cuenta debe contener exactamente 5 dígitos numéricos.");
		           		 }
		        	}
			}
			 
			 function confirmarBajaCuenta() {
		            // Confirmar la baja solo si el numero de cuenta no está vacío
		            var dniInput = document.getElementById('txtNroCuenta');
		            if (dniInput.value.trim() === "") {
		                alert('El N° de Cuenta no puede estar vacío. Por favor, ingréselo.');
		                return false; // Detiene el evento onclick
		            }

		            return confirm('¿Estás seguro de que deseas dar de baja la Cuenta?');
		        }
			 
			 function validarCBU(input) {
				 var valor = input.value.trim();
				    
				    if (valor === ""){
				    	
				    }else {
		           		 var cbu = document.getElementById("txtNroCBU").value;
		           		 if (cbu.length !== 10 || isNaN(cbu)) {
		                	alert("El CBU debe contener exactamente 10 dígitos numéricos.");
		           		 }
		        	}
			 }
			 
			 function validarContrasenas() {
		            var password1 = document.getElementById("txtContrasena").value;
		            var password2 = document.getElementById("txtConfirmarContrasena").value;
					
		            if(password1 === "" || password2 === ""){
		            
		            }else if (password1 !== password2) {
		                alert("Las contraseñas no coinciden.");
		           		} 
		        } 
			 
			 function filtrarTablaUsuarios(){
				 var filtro = document.getElementById("filtro").value.toUpperCase();
				 var table = document.getElementById("table_pagination");
				 var tr = table.getElementsByTagName("tr");
				 		 
				 for (i = 0; i < tr.length; i++){
					 var td = tr[i].getElementsByTagName("td")[3];//indice 3 para la columna del sexo
					 if(td){
						 var txtValue = td.textContent || td.innerText;
						 var mostrarFila = (filtro === "- ELIGA EL SEXO -" || txtValue.toUpperCase() === filtro);
						 tr[i].style.display = mostrarFila ? "" : "none";
					 }
				 }
			 }
			 
			 function filtrarTablaCuentas() {
				    var filtro = document.getElementById("filtro").value.toUpperCase();
				    var table = document.getElementById("table_pagination");
				    var tr = table.getElementsByTagName("tr");

				    for (var i = 0; i < tr.length; i++) {
				        var td = tr[i].getElementsByTagName("td")[3]; // índice 3 para la columna del tipo de cuenta

				        if (td) {
				        	 var codTipoCuenta = td.dataset.codTipoCuenta;
				        	 var mostrarFila = (filtro === "- ELIGA EL TIPO DE CUENTA -" || codTipoCuenta === filtro);

				             tr[i].style.display = mostrarFila ? "" : "none";
				        }
				    }
				}
			 
			 function filtrarTablaPrestamos() {
				    var filtro = document.getElementById("filtro").value.toUpperCase();
				    var table = document.getElementById("table_pagination");
				    var tr = table.getElementsByTagName("tr");

				    for (var i = 0; i < tr.length; i++) {
				        var td = tr[i].getElementsByTagName("td")[8]; // índice 8 para la columna del estado del prestamo

				        if (td) {
				        	 var estadoPrestamo = td.dataset.estado;
				        	 var mostrarFila = (filtro === "- ELIGA EL ESTADO DEL PRESTAMO -" || estadoPrestamo === filtro);

				             tr[i].style.display = mostrarFila ? "" : "none";
				        }
				    }
				}
			 
	</script>
</head>