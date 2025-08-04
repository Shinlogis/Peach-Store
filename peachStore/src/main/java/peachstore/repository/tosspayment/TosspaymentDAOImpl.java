package peachstore.repository.tosspayment;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Tosspayment;

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
	public int insert(Tosspayment tosspayment) {
		int result = sqlSessionTemplate.insert("Tosspayment.insert", tosspayment);
		log.debug("insert count - {}", result);
		return result;
	}

}
