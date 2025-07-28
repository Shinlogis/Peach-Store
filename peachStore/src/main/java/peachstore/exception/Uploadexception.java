package peachstore.exception;
/**
 * 파일 업로드 exception
 * @author 성유진 
 * @since 2025-07-26
 */
public class Uploadexception extends RuntimeException{
	
	public Uploadexception(String msg) {
		super(msg);
	}
	
	public Uploadexception(Throwable e) {
		super(e);
	}
	
	public Uploadexception(String msg, Throwable e) {
		super(msg, e);
	}

}
