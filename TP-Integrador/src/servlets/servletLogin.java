package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import interfaces.IUsuarioNegocio;
import negocio.UsuarioNegocio;


@WebServlet("/servletLogin")
public class servletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public servletLogin() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		HttpSession session = request.getSession();
		IUsuarioNegocio uNeg = new UsuarioNegocio();
		
		if(request.getParameter("btnAceptar") != null) {
			String nombreUsuario = request.getParameter("txtUsuario");
			String contrasena = request.getParameter("txtContrasena");
			Integer resultLogin = 0;
			
			resultLogin = uNeg.login(nombreUsuario, contrasena, session);	
			
			request.setAttribute("resultLogin", resultLogin);
		}
				
		if(request.getParameter("btnLogout") != null) {
			if (session != null && session.getAttribute("usuario") != null) {
	            session.invalidate();
	        }
		    response.sendRedirect("Inicio.jsp");
		    return;
		}
		
		rd = request.getRequestDispatcher("/Inicio.jsp");
		rd.forward(request, response);
	}
}
