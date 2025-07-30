package peachstore.advice;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import peachstore.exception.UserGradeException;

/**
 * 관리자 페이지 전역 예외처리 클래스
 * 컨트롤러에서 발생하는 예외를 한 곳에서 처리
 */
@RestControllerAdvice
public class AdminGlobalExceptionHandler {
	
	/**
	 * 사용자 등급 처리 중 발생하는 예외를 처리하는 메서드
	 * @param e 예외 객체
	 * @return json 응답, http 상태 코드
	 */
	@ExceptionHandler(UserGradeException.class)
	public ResponseEntity<Map<String, Object>> handle(UserGradeException e){
		Map<String, Object> result = new HashMap<>();
		result.put("success", false);
		result.put("message", "등급이 등록되지 않았습니다.");
		
		return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	}
}
