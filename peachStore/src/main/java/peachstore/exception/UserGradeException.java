package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class UserGradeException extends RuntimeException{

	public UserGradeException(String msg) {
		super(msg);
	}
	
	public UserGradeException(Throwable e) {
		super(e);
	}
	
	public UserGradeException(String msg, Throwable e) {
		super(msg, e);
	}
}
