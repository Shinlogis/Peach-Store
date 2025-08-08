package peachstore.exception;

public class ProductSubcategoryException extends RuntimeException{
	
	public ProductSubcategoryException(String msg) {
		super(msg);
	}
	public ProductSubcategoryException(String msg, Throwable e) {
		super(msg, e);
	}
	public ProductSubcategoryException(Throwable e) {
		super(e);
	}
	
}