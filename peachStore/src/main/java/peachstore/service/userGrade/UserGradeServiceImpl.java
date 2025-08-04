package peachstore.service.userGrade;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.domain.UserGrade;
import peachstore.exception.UserGradeException;
import peachstore.repository.userGrade.UserGradeDAO;
import peachstore.service.user.UserService;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserGradeServiceImpl implements UserGradeService{

	private final UserGradeDAO userGradeDAO;
	private final UserService userService;

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
	
	
	/**
	 * 해당 사용자의 등급 계산 후 업데이트
	 */
	@Override
	public void calUserGrade(int userId) {
		log.debug("calUserGrade - userId: {}", userId);
		// 금액 조건이 높은 순으로 등급 조회
		List<UserGrade> grades = gradeSelectByAmount();
		// 사용자 조회
		User user = userService.selectByUserId(userId);
		// 총 결제 금액 조회
		Long totalAmount = selectTotalAmountByUser(userId);
		for(UserGrade userGrade: grades) {
			log.debug("calUserGrade - userGrade: {}", userGrade.getUserGradeName());
			log.debug("calUserGrade - user.getUser_grade(): {}", user.getUser_grade().getUserGradeName());
			// 총 결제 금액이 기준금액 이상이고, 현재 등급과 해당 등급이 다른 경우
			if (totalAmount >= userGrade.getCriteriaAmount() && !user.getUser_grade().equals(userGrade)) {
				// 등급을 새로 설정
				user.setUser_grade(userGrade);
				// 해당 등급으로 update
				userService.update(user);
				break;
			}
		}
	}

	/**
	 * 금액 조건이 높은 등급 순으로 불러오기
	 */
	public List<UserGrade> gradeSelectByAmount() {
		return userGradeDAO.gradeSelectByAmount();
	}

	/**
	 * 해당 사용자의 총 결제 금액 불러오기
	 */
	public Long selectTotalAmountByUser(int userId) {
		return userGradeDAO.selectTotalAmountByUserId(userId);
	}



}
