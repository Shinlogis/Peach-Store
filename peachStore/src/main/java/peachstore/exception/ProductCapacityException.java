package peachstore.exception;
/**
 * 상품 용량 예외처리
 * @author 김지민 
 * @since 2025-07-29
 */
public class ProductCapacityException extends RuntimeException{
	
	public ProductCapacityException(String msg) {
		super(msg);
	}
	public ProductCapacityException(String msg, Throwable e) {
		super(msg, e);
	}
	public ProductCapacityException(Throwable e) {
		super(e);
	}
	
}