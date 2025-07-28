package peachstore.exception;

public class ProductCategoryException extends RuntimeException{
	
	public ProductCategoryException(String msg) {
		super(msg);
	}
	public ProductCategoryException(String msg, Throwable e) {
		super(msg, e);
	}
	public ProductCategoryException(Throwable e) {
		super(e);
	}
	
}