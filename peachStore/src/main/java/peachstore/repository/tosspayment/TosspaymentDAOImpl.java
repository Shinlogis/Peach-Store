package peachstore.repository.tosspayment;

import java.time.LocalDateTime;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Tosspayment;
import peachstore.exception.TosspaymentException;

/**
 * 토스 페이먼트 DAO 구현체입니다
 * @author 김예진
 * @since 2025-08-03
 */
@Repository
@RequiredArgsConstructor
@Slf4j
public class TosspaymentDAOImpl implements TosspaymentDAO{
	
	private final SqlSessionTemplate sqlSessionTemplate;

	@Override
	public Tosspayment insert(String tossOrderId, String tossPaymentKey, String tossPaymentMethod, String tossPaymentStatus,
			long totalAmount, LocalDateTime ApprovedAt, LocalDateTime requestedAt) {
		
		Tosspayment tosspayment = new Tosspayment();
		tosspayment.setTossOrderId(tossOrderId);
		tosspayment.setTossPaymentKey(tossPaymentKey);
		tosspayment.setTossPaymentMethod(tossPaymentMethod);
		tosspayment.setTossPaymentStatus(tossPaymentStatus);
		tosspayment.setTotalAmount(totalAmount);
		tosspayment.setApprovedAt(ApprovedAt);
		tosspayment.setRequestedAt(requestedAt);
		
		int result = sqlSessionTemplate.insert("Tosspayment.insert", tosspayment);
		if (result == 0) {
			throw new TosspaymentException("결제정보 insert 실패");
		}
		log.debug("insert count - {}", result);

		return tosspayment;
	}

}
