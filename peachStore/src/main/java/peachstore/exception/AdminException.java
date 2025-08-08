package peachstore.exception;
/**
 * 문의 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class AdminException extends RuntimeException{

	public AdminException(String msg) {
		super(msg);
	}
	
	public AdminException(Throwable e) {
		super(e);
	}
	
	public AdminException(String msg, Throwable e) {
		super(msg, e);
	}
}
