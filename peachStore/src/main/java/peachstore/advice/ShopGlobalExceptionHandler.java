package peachstore.advice;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import peachstore.exception.InquiryException;
import peachstore.exception.InquiryImgException;
import peachstore.exception.ReviewException;
import peachstore.exception.ReviewImgException;
import peachstore.exception.Uploadexception;

//각 컨트롤러에 명시된 예외처리 어노테이션 @ExceptionHandler를 이 클래스에서 공통적으로 처리
@RestControllerAdvice
public class ShopGlobalExceptionHandler {

	// 문의 관련 실패 처리
	@ExceptionHandler({ InquiryException.class, InquiryImgException.class })
	public ResponseEntity<Map<String, Object>> inquiry(Exception e) {

		Map<String, Object> result = new HashMap<>();
		result.put("msg", e.getMessage());

		return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	}

	// 리뷰 관련 실패 처리
	@ExceptionHandler({ ReviewException.class, ReviewImgException.class })
	public ResponseEntity<Map<String, Object>> review(Exception e) {

		Map<String, Object> result = new HashMap<>();
		result.put("msg", e.getMessage());

		return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	}

	// 리뷰 관련 실패 처리
	@ExceptionHandler(Uploadexception.class )
	public ResponseEntity<Map<String, Object>> upload(Exception e) {

		Map<String, Object> result = new HashMap<>();
		result.put("msg", e.getMessage());

		return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	}

}
