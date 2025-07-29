package peachstore.repository;

import org.springframework.stereotype.Repository;

import lombok.Data;
import peachstore.domain.UserGrade;

@Repository
public class UserGradeDAOImpl implements UserGradeDAO {
	@Override
	public UserGrade select(int user_grade_id) {
		return null;
	}
}
