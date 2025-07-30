package peachstore.service.userGrade;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.UserGrade;
import peachstore.exception.UserGradeException;
import peachstore.repository.userGrade.UserGradeDAO;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserGradeServiceImpl implements UserGradeService{

	private final UserGradeDAO userGradeDAO;

	@Override
	public List<UserGrade> findAll() {
		return userGradeDAO.selectAll();
	}

	@Override
	public void register(String userGradeName, BigDecimal discountRate, int criteriaAmount) {
		UserGrade userGrade = new UserGrade();
		userGrade.setUserGradeName(userGradeName);
		userGrade.setDiscountRate(discountRate);
		userGrade.setCriteriaAmount(criteriaAmount);
		
		int result = userGradeDAO.insert(userGrade);
		if (result == 0) {
			throw new UserGradeException("사용자 등급 등록 실패");
		}
	}

	@Override
	public void update(String userGradeName, int criteriaAmount, BigDecimal discountRate, int userGradeId) {
		// pk로 사용자 등급 검색
		UserGrade userGrade = userGradeDAO.findById(userGradeId);
		userGrade.setUserGradeName(userGradeName);
		userGrade.setCriteriaAmount(criteriaAmount);
		userGrade.setDiscountRate(discountRate);
		
		int result = userGradeDAO.update(userGrade);
		if (result == 0) {
			throw new UserGradeException("사용자 등급 수정 실패");
		}		
	}
	
	@Override
	public void toggleActivation(int userGradeId) {
		// pk로 사용자 등급 검색
		UserGrade userGrade = userGradeDAO.findById(userGradeId);
		userGrade.setActive(!userGrade.isActive());

		int result = userGradeDAO.update(userGrade);
		if (result == 0) {
			throw new UserGradeException("사용자 등급 수정 실패");
		}
	}

	@Override
	public void delete(int userGradeId) {
		int result = userGradeDAO.delete(userGradeId);
		if (result == 0) {
			throw new UserGradeException("사용자 등급이 존재하지 않아 삭제 실패");
		}
	}


}
