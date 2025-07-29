package peachstore.exception;
/**
 * 상품 색상 예외처리
 * @author 김지민 
 * @since 2025-07-29
 */
public class ProductColorException extends RuntimeException{
	
	public ProductColorException(String msg) {
		super(msg);
	}
	public ProductColorException(String msg, Throwable e) {
		super(msg, e);
	}
	public ProductColorException(Throwable e) {
		super(e);
	}
	
}