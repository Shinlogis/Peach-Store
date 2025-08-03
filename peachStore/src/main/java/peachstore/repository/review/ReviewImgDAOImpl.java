package peachstore.repository.review;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.ReviewImg;

@Repository
public class ReviewImgDAOImpl implements ReviewImgDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void insert(ReviewImg reviewImg) {
		sqlSessionTemplate.insert("ReviewImg.insert", reviewImg);
		
	}

}
