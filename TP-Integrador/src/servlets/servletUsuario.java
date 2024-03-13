package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.UsuarioDAO;
import entidades.Usuario;
import interfaces.IUsuarioNegocio;
import negocio.UsuarioNegocio;


@WebServlet("/servletUsuario")
public class servletUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public servletUsuario() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/Inicio.jsp");
		IUsuarioNegocio uNeg = new UsuarioNegocio();
		
		if(request.getParameter("altaUsuario") != null) {
			String dni = request.getParameter("txtDni");
			String cuil = request.getParameter("txtCuil");
			String nombre = request.getParameter("txtNombre");
			String apellido = request.getParameter("txtApellido");
			String sexo = request.getParameter("selectSexo");
			String nacionalidad = request.getParameter("selectNacionalidad");
			String fechaNacimiento = request.getParameter("fechaNacimiento");
			String direccion = request.getParameter("txtDireccion");
			String localidad = request.getParameter("selectLocalidad");
			String provincia = request.getParameter("selectProvincia");
			String correoElectronico = request.getParameter("txtCorreo");
			String telefono = request.getParameter("txtTelefono");
			String nombreUsuario = request.getParameter("txtUsuario");
			String contrasena = request.getParameter("txtContrasena");
			String confirmarContrasena = request.getParameter("txtContrasena");
			Integer resultAltaUsuario = 0;
			
		
			resultAltaUsuario = uNeg.altaUsuario(dni, cuil, nombre, apellido, sexo, nacionalidad, 
					fechaNacimiento, direccion, localidad, provincia, correoElectronico, telefono, nombreUsuario, contrasena, confirmarContrasena);
			
			request.setAttribute("resultAltaUsuario", resultAltaUsuario);
			
			rd = request.getRequestDispatcher("/AltaUsuario.jsp");   	        
		}
		
		if(request.getParameter("btnMostrarUsuarios")!=null)
		{
			UsuarioDAO udao = new UsuarioDAO();
			ArrayList<Usuario> lista = udao.obtenerUsuarios();
			 
			request.setAttribute("listaU", lista);
			
			rd = request.getRequestDispatcher("/ListarUsuario.jsp");   
		} 
		
		if(request.getParameter("btnBajaUsuario") != null) {
			String dni = request.getParameter("txtDni").toString();
			int resultBajaUsuario = 0;
			
			resultBajaUsuario = uNeg.bajaUsuario(dni);
			
			request.setAttribute("resultBajaUsuario", resultBajaUsuario);
			
			rd = request.getRequestDispatcher("/BajaUsuario.jsp");   

		}
		
		if (request.getParameter("btnModificar") != null) {
		    String dni = request.getParameter("txtDni");
		    String nuevaContrasena = request.getParameter("txtContrasena");
		    Integer resultModificarUsuario = 0;
		    
		    // Agregar la lógica para modificar el usuario aquí
		    resultModificarUsuario = uNeg.actualizarUsuario(dni, nuevaContrasena);
		    
		    request.setAttribute("resultModificarUsuario", resultModificarUsuario);
		    rd = request.getRequestDispatcher("/ModificarUsuario.jsp");
		}
		
		if (request.getParameter("btnPorcentajeGeneros") != null) {
		    UsuarioDAO udao = new UsuarioDAO();
		    ArrayList<Usuario> listaUsuarios = udao.obtenerUsuarios();

		    if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
		        int hombres = 0;
		        int mujeres = 0;

		        for (Usuario usuario : listaUsuarios) {
		            if ("M".equals(usuario.getSexo())) {
		                hombres++;
		            } else {
		                mujeres++;
		            }
		        }

		        float porcentajeHombres = (float)hombres / listaUsuarios.size() * 100;
		        float porcentajeMujeres = (float)mujeres / listaUsuarios.size() * 100;

		        request.setAttribute("hombres", porcentajeHombres);
		        request.setAttribute("mujeres", porcentajeMujeres);
		        rd = request.getRequestDispatcher("/Reportes.jsp");
		    }
		}
		
		rd.forward(request, response);
	}
	
}
