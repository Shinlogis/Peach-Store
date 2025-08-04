package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class CustomOptionException extends RuntimeException{

	public CustomOptionException(String msg) {
		super(msg);
	}
	
	public CustomOptionException(Throwable e) {
		super(e);
	}
	
	public CustomOptionException(String msg, Throwable e) {
		super(msg, e);
	}
}
