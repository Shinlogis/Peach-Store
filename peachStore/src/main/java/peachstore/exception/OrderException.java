package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class OrderException extends RuntimeException{

	public OrderException(String msg) {
		super(msg);
	}
	
	public OrderException(Throwable e) {
		super(e);
	}
	
	public OrderException(String msg, Throwable e) {
		super(msg, e);
	}
}
