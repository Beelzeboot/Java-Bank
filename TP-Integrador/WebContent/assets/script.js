
$(document).ready(function () {
    $("#table_pagination").DataTable();
})

/*
 * SELECT DE CUENTAS DEL USUARIO EN EL MENU (HEADER PAGINA)
 */

document.addEventListener("DOMContentLoaded", function() {
	 let selectCuentas = null;

	 if (document.querySelector("[name='selectCuentas']") !== null) {
	     const cambiarCuentasForm = document.querySelector("#selectCuentas");
	     selectCuentas = document.querySelector("[name='selectCuentas']");

	     selectCuentas.addEventListener("change", (e) => {
	         cambiarCuentasForm.submit();
	     });

	     console.log("Código JavaScript ejecutado correctamente");
	 }
});

