package excepciones;

public class CuentaNoEncontrada extends Exception {

	private static final long serialVersionUID = 1L;
	
	public CuentaNoEncontrada(String message) {
        super(message);
    }
}
