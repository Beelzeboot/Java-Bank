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
import entidades.Cuenta;
import entidades.Movimiento;
import interfaces.IMovimientoNegocio;
import negocio.MovimientoNegocio;

@WebServlet("/servletMovimiento")
public class servletMovimiento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public servletMovimiento() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		IMovimientoNegocio mNeg = new MovimientoNegocio();
		
		if(request.getParameter("btnTransferir") != null) {
			String cbuDestino = request.getParameter("txtNroCBU");
			String monto = request.getParameter("txtMonto");
			Integer resultCrearMovimiento = 0;
			
			resultCrearMovimiento = mNeg.crearMovimientoTransferencia(cbuDestino, monto, session);
			
			request.setAttribute("resultCrearMovimiento", resultCrearMovimiento);
			
			RequestDispatcher rd = request.getRequestDispatcher("/RealizarTransferencia.jsp");   
	        
			rd.forward(request, response);
		}
		
		if(request.getParameter("btnVerMovimientos") != null) {
			Cuenta cuenta = (Cuenta)session.getAttribute("cuentaActual");
			ArrayList<Movimiento> movimientos = mNeg.obtenerMovimientosCuenta(cuenta);
			
			request.setAttribute("movimientos", movimientos);
			
			RequestDispatcher rd = request.getRequestDispatcher("/Movimientos.jsp");   
	        rd.forward(request, response);
		}
	}

}
