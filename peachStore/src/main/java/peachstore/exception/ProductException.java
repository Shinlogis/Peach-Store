package peachstore.exception;
/**
 * 상품 예외처리
 * @author 김지민 
 * @since 2025-07-29
 */
public class ProductException extends RuntimeException{
	
	public ProductException(String msg) {
		super(msg);
	}
	public ProductException(String msg, Throwable e) {
		super(msg, e);
	}
	public ProductException(Throwable e) {
		super(e);
	}
	
}