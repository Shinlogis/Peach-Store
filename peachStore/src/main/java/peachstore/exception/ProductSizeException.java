package peachstore.exception;
/**
 * 상품 크기 예외처리
 * @author 김지민 
 * @since 2025-07-29
 */
public class ProductSizeException extends RuntimeException{
	
	public ProductSizeException(String msg) {
		super(msg);
	}
	public ProductSizeException(String msg, Throwable e) {
		super(msg, e);
	}
	public ProductSizeException(Throwable e) {
		super(e);
	}
	
}