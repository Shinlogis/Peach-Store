package peachstore.exception;

public class ProductTopcategoryException extends RuntimeException{
	
	public ProductTopcategoryException(String msg) {
		super(msg);
	}
	public ProductTopcategoryException(String msg, Throwable e) {
		super(msg, e);
	}
	public ProductTopcategoryException(Throwable e) {
		super(e);
	}
	
}