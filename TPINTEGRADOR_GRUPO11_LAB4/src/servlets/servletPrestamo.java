package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import entidades.Prestamo;
import entidades.Usuario;
import interfaces.IMovimientoNegocio;
import interfaces.IPrestamoNegocio;
import negocio.MovimientoNegocio;
import negocio.PrestamoNegocio;


@WebServlet("/servletPrestamo")
public class servletPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public servletPrestamo() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario)session.getAttribute("usuario");
		RequestDispatcher rd = null;
		IPrestamoNegocio pNeg = new PrestamoNegocio();
		IMovimientoNegocio mNeg = new MovimientoNegocio();
		
		if(request.getParameter("btnSolicitar") != null) {
			String cuotas = request.getParameter("selectCuotas");
			String monto = request.getParameter("txtMonto");
			int resultSolicitarPrestamo = 0;
			
			resultSolicitarPrestamo = pNeg.solicitarPrestamo(cuotas, monto, session);
			
			request.setAttribute("resultSolicitarPrestamo", resultSolicitarPrestamo);
			
			rd = request.getRequestDispatcher("/SolicitarPrestamo.jsp");

		}
		
		if(request.getParameter("btnAprobarPrestamos") != null) {
			ArrayList<Prestamo> prestamos = pNeg.obtenerPrestamosSinAprobar();
			
			request.setAttribute("prestamos", prestamos);
			rd = request.getRequestDispatcher("/AprobarPrestamos.jsp");
					
		}
		
		if(request.getParameter("btnPrestamosEntreFechas") != null) {
			String fechaInicio = request.getParameter("txtFechaInicio");
			String fechaFin = request.getParameter("txtFechaFin");
			Integer resultValidar = pNeg.validarPrestamosEntreFechas(fechaInicio, fechaFin);
			ArrayList<Prestamo> prestamosEntreFechas = null;
			Float max = -1f;
			Float min = Float.MAX_VALUE;
			if(resultValidar == 1) {
		        prestamosEntreFechas = pNeg.prestamosEntreFechas(fechaInicio, fechaFin);
		        
		        if (prestamosEntreFechas != null) {
		            for (Prestamo n : prestamosEntreFechas) {
		                if (n.getImportePedido() > max) {
		                    max = n.getImportePedido();
		                }
		            }
		            for (Prestamo n : prestamosEntreFechas) {
		                if (n.getImportePedido() < min) {
		                    min = n.getImportePedido();
		                }
		            }
		        }
		    }

		    if(min == Float.MAX_VALUE) {
		        min = -1f;
		    }

		    request.setAttribute("valorMaximo", max);
		    request.setAttribute("valorMinimo", min);
		    request.setAttribute("resultValidar", resultValidar);

		    rd = request.getRequestDispatcher("/Reportes.jsp");
			
		}
		
		if(request.getParameter("btnAprobarPrestamo") != null) {
			String codPrestamo = request.getParameter("txtCodPrestamo");
			Integer resultAprobarPrestamo = 0;
			
			resultAprobarPrestamo = pNeg.aprobarPrestamo(codPrestamo);
			if(resultAprobarPrestamo == 1) {
				mNeg.crearMovimientoPrestamoAprobado(codPrestamo);
			}
			
			ArrayList<Prestamo> prestamos = pNeg.obtenerPrestamosSinAprobar();

			request.setAttribute("resultAprobarPrestamo", resultAprobarPrestamo);
			request.setAttribute("prestamos", prestamos);
			
			rd = request.getRequestDispatcher("/AprobarPrestamos.jsp");

		}
		
		if(request.getParameter("btnRechazarPrestamo") != null) {
			String codPrestamo = request.getParameter("txtCodPrestamo");
			Integer resultRechazarPrestamo = 0;
			
			resultRechazarPrestamo = pNeg.rechazarPrestamo(codPrestamo);
			
			ArrayList<Prestamo> prestamos = pNeg.obtenerPrestamosSinAprobar();

			request.setAttribute("resultRechazarPrestamo", resultRechazarPrestamo);
			request.setAttribute("prestamos", prestamos);
			
			rd = request.getRequestDispatcher("/AprobarPrestamos.jsp");

		}
		if(request.getParameter("btnPrestamosMontos") != null) {
			String min = request.getParameter("txtMin");
			String max = request.getParameter("txtMax");
			int resultValidar = pNeg.validarPrestamosEntreMontos(min, max);
			ArrayList<Prestamo> prestamosEntreMontos = null;

			if(resultValidar == 1) {
				prestamosEntreMontos = pNeg.prestamosEntreMontos(min, max);
			}
			
			request.setAttribute("prestamosEntreMontos", prestamosEntreMontos);
			request.setAttribute("resultValidar", resultValidar);
			
			rd = request.getRequestDispatcher("/Reportes.jsp");
		}
		
		if(request.getParameter("btnVerPrestamos") != null) {	
					
			ArrayList<Prestamo> prestamos = pNeg.obtenerPrestamosUsuario(usuario);
			
			request.setAttribute("prestamos", prestamos);
			
			rd = request.getRequestDispatcher("/VerPrestamos.jsp");
		}
		
		if(request.getParameter("btnPagarCuota") != null) {
			String codPrestamo = request.getParameter("txtCodPrestamo");
			String cantidadCuotasAPagar = request.getParameter("selectCuotasAPagar");
			Integer resultPagarCuotas = 0;
			
			resultPagarCuotas = pNeg.pagarCuotasPrestamo(codPrestamo, cantidadCuotasAPagar, session);
			if(resultPagarCuotas == 1) {
				mNeg.crearMovimientoPagoPrestamo(codPrestamo, cantidadCuotasAPagar, session);
			}
			
			ArrayList<Prestamo> prestamos = pNeg.obtenerPrestamosUsuario(usuario);
			
			request.setAttribute("prestamos", prestamos);
			request.setAttribute("resultPagarCuotas", resultPagarCuotas);
			
			rd = request.getRequestDispatcher("/VerPrestamos.jsp");	
		}
		
		rd.forward(request, response);
	}

}
