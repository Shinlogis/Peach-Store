package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class TosspaymentException extends RuntimeException{

	public TosspaymentException(String msg) {
		super(msg);
	}
	
	public TosspaymentException(Throwable e) {
		super(e);
	}
	
	public TosspaymentException(String msg, Throwable e) {
		super(msg, e);
	}
}
