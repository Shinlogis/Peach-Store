package peachstore.repository.tosspayment;

import java.time.LocalDateTime;

import peachstore.domain.Tosspayment;

/**
 * 토스 페이먼트 DAO 인터페이스입니다
 * @author 김예진
 * @since 2025-08-03
 */
public interface TosspaymentDAO {
	
	/**
	 * 결제정보 insert
	 * @param tosspayment
	 * @return
	 */
	public Tosspayment insert(String tossOrderId, String tossPaymentKey, String tossPaymentMethod,  String tossPaymentStatus, long totalAmount, LocalDateTime ApprovedAt, LocalDateTime requestedAt);

}
