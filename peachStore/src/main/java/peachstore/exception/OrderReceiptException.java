package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class OrderReceiptException extends RuntimeException{

	public OrderReceiptException(String msg) {
		super(msg);
	}
	
	public OrderReceiptException(Throwable e) {
		super(e);
	}
	
	public OrderReceiptException(String msg, Throwable e) {
		super(msg, e);
	}
}
