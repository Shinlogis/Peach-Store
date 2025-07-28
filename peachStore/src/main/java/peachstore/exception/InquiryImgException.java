package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class InquiryImgException extends RuntimeException{

	public InquiryImgException(String msg) {
		super(msg);
	}
	
	public InquiryImgException(Throwable e) {
		super(e);
	}
	
	public InquiryImgException(String msg, Throwable e) {
		super(msg, e);
	}
}
