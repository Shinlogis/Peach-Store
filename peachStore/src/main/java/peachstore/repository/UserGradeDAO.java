package peachstore.repository;

import peachstore.domain.UserGrade;

public interface UserGradeDAO {
	public UserGrade select(int user_grade_id);
}
