package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class ReviewException extends RuntimeException{

	public ReviewException(String msg) {
		super(msg);
	}
	
	public ReviewException(Throwable e) {
		super(e);
	}
	
	public ReviewException(String msg, Throwable e) {
		super(msg, e);
	}
}
