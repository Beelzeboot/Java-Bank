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
import entidades.Prestamo;
import entidades.Usuario;
import interfaces.ICuentaNegocio;
import interfaces.IMovimientoNegocio;
import interfaces.IPrestamoNegocio;
import negocio.CuentaNegocio;
import negocio.MovimientoNegocio;
import negocio.PrestamoNegocio;


@WebServlet("/servletPage")
public class servletPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public servletPage() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		HttpSession session = request.getSession();
		String nombreJsp = null;
		
		if(session.getAttribute("nombreJsp") != null) {
		    nombreJsp = session.getAttribute("nombreJsp").toString();
		}else {
			nombreJsp = "Inicio.jsp";
		}
	    
		if(request.getParameter("selectCuentas") != null) {
			int indiceCuentaActual = Integer.parseInt(request.getParameter("selectCuentas"));
			ICuentaNegocio cNeg = new CuentaNegocio();
			Usuario usuario = (Usuario)session.getAttribute("usuario");
			
			ArrayList<Cuenta> cuentasUsuarios = cNeg.obtenerCuentasUsuario(usuario);
			
			session.setAttribute("indiceCuentaActual", indiceCuentaActual);
			session.setAttribute("cuentaActual", cuentasUsuarios.get(indiceCuentaActual));
			Cuenta cuentaActual = cuentasUsuarios.get(indiceCuentaActual);
			
			if(nombreJsp == "VerPrestamos.jsp") {
				IPrestamoNegocio pNeg = new PrestamoNegocio();
				ArrayList<Prestamo> prestamos = pNeg.obtenerPrestamosAprobadosUsuario(usuario, cuentaActual);
				
				request.setAttribute("prestamos", prestamos);
			}
			
			if(nombreJsp == "Movimientos.jsp") {
				IMovimientoNegocio mNeg = new MovimientoNegocio();
				Cuenta cuenta = (Cuenta)session.getAttribute("cuentaActual");
				ArrayList<Movimiento> movimientos = mNeg.obtenerMovimientosCuenta(cuenta);
				
				request.setAttribute("movimientos", movimientos);
			}
		}
		
		rd = request.getRequestDispatcher("/" + nombreJsp);
		
		rd.forward(request, response);
	}

}
