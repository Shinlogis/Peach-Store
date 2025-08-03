package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class ReviewImgException extends RuntimeException{

	public ReviewImgException(String msg) {
		super(msg);
	}
	
	public ReviewImgException(Throwable e) {
		super(e);
	}
	
	public ReviewImgException(String msg, Throwable e) {
		super(msg, e);
	}
}
