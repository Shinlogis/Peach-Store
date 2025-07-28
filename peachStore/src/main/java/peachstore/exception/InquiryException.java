package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class InquiryException extends RuntimeException{

	public InquiryException(String msg) {
		super(msg);
	}
	
	public InquiryException(Throwable e) {
		super(e);
	}
	
	public InquiryException(String msg, Throwable e) {
		super(msg, e);
	}
}
