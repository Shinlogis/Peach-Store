package peachstore.exception;
/**
 * 상품 이미지 등록 예외
 * @author 김지민
 * @since 2025-07-30
 */
public class ProductImgException extends RuntimeException{

	public ProductImgException(String msg) {
		super(msg);
	}
	
	public ProductImgException(Throwable e) {
		super(e);
	}
	
	public ProductImgException(String msg, Throwable e) {
		super(msg, e);
	}
}
