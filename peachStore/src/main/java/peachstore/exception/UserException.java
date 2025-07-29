package peachstore.exception;

public class UserException extends RuntimeException {
	
	public UserException(String msg) {
		super(msg);
	}
	
	public UserException(Throwable e) {
		super(e);
	}
	
	public UserException(String msg, Throwable e) {
		super(msg, e);
	}
}
