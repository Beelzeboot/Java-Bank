package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Cuenta;
import excepciones.CuentaNoEncontrada;
import interfaces.ICuentaNegocio;
import interfaces.IMovimientoNegocio;
import negocio.CuentaNegocio;
import negocio.MovimientoNegocio;


/**
 * Servlet implementation class servletCuentas
 */
@WebServlet("/servletCuenta")
public class servletCuenta extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public servletCuenta() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ICuentaNegocio cNeg = new CuentaNegocio();
		IMovimientoNegocio mNeg = new MovimientoNegocio();
		RequestDispatcher rd = null;
		
		if(request.getParameter("btnAltaCuenta") != null) {
			String numCuenta = request.getParameter("txtNroCuenta");
			String tipoCuenta = request.getParameter("selectTipoCuenta");
			String nroCbu = request.getParameter("txtNroCBU");

			String resultAltaCuenta = cNeg.altaCuenta(numCuenta, tipoCuenta, nroCbu);
			if ("Alta exitosa".equals(resultAltaCuenta)) {
				 mNeg.crearMovimientoAltaCuenta(nroCbu);
			}			
			
			request.setAttribute("resultAltaCuenta", resultAltaCuenta);
			
			rd = request.getRequestDispatcher("/AltaCuenta.jsp");   
		}
		
		if(request.getParameter("btnBajaCuenta") != null) {
			String numCuenta = request.getParameter("txtNroCuenta");

            int resultBajaCuenta = cNeg.bajaCuenta(numCuenta);

            request.setAttribute("resultBajaCuenta", resultBajaCuenta);

            rd = request.getRequestDispatcher("/BajaCuenta.jsp");
        }
		
		if(request.getParameter("btnModificarCuenta") != null) {
			String numCuenta = request.getParameter("txtNroCuenta");
			String tipoCuentaNuevo = request.getParameter("selectTipoCuenta");
			String nuevoSaldo = request.getParameter("txtNuevoSaldo");
			
			int resultModificarCuenta = cNeg.actualizarCuenta(numCuenta, tipoCuentaNuevo, nuevoSaldo);
			
			request.setAttribute("resultModificarCuenta", resultModificarCuenta);
			
			rd = request.getRequestDispatcher("/ModificarCuenta.jsp");  
		}
		
		if(request.getParameter("btnMostrarCuentas")!=null)
		{
			ArrayList<Cuenta> lista= cNeg.obtenerCuentas();
			 
			request.setAttribute("listaC", lista);

			rd = request.getRequestDispatcher("/ListarCuenta.jsp");   
		} 

		if(request.getParameter("btnAsignarCuenta")!=null) {
			String numCuenta = request.getParameter("txtNroCuenta");
			String dni = request.getParameter("txtDni");
			
			int resultAsignarCuenta = cNeg.asignarCuenta(numCuenta, dni);
			
			request.setAttribute("resultAsignarCuenta", resultAsignarCuenta);
			
			rd = request.getRequestDispatcher("/AsignarCuenta.jsp");         
		}	
		rd.forward(request, response);
	}
}
